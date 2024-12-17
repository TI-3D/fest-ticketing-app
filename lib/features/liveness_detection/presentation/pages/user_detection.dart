import 'dart:convert';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:fest_ticketing/core/constant/api_url.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserDetectionPage extends StatefulWidget {
  final CameraDescription camera;

  const UserDetectionPage({super.key, required this.camera});

  @override
  _UserDetectionPageState createState() => _UserDetectionPageState();
}

class _UserDetectionPageState extends State<UserDetectionPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late WebSocketChannel _channel;
  String _currentMessage = "";
  bool _isProcessing = false;
  bool _isInitialized = false;
  bool _flashEnabled = false; // Variable to track flash state
  Timer? _cameraTimer;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _controller = CameraController(
        widget.camera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      _initializeControllerFuture = _controller.initialize();

      // Wait for camera initialization to finish
      await _initializeControllerFuture;

      // Check if the camera supports flash
      if (_controller.value.flashMode != FlashMode.off) {
        setState(() {
          _flashEnabled = false; // Default flash state
        });
      }

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        startUserDetection();
      }
    } catch (e) {
      setState(() {
        _currentMessage = 'Failed to initialize camera';
      });
    }
  }

  void startUserDetection() {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://${ApiUrl.host}/ws/detection_face'),
    );

    _channel.stream.listen(
      (response) {
        final data = jsonDecode(response);
        setState(() {
          _currentMessage = data['message'] ?? 'No message';
        });
      },
      onError: (error) {
        print('WebSocket error: $error');
        setState(() {
          _currentMessage = 'Connection error occurred';
        });
      },
      onDone: () {
        print('WebSocket connection closed');
      },
    );

    _processCameraStream();
  }

  Future<void> _processCameraStream() async {
    while (mounted) {
      try {
        if (!_controller.value.isInitialized) break;

        if (_isProcessing) {
          await Future.delayed(Duration(milliseconds: 100));
          continue;
        }

        _isProcessing = true;
        final image = await _controller.takePicture();
        final bytes = await image.readAsBytes();
        final base64Image = 'data:image/jpeg;base64,${base64Encode(bytes)}';

        if (!mounted) break;

        // Send image over WebSocket
        _channel.sink.add(jsonEncode({'image': base64Image}));

        _isProcessing = false;
        await Future.delayed(Duration(milliseconds: 100));
      } catch (e) {
        print('Error processing frame: $e');
        _isProcessing = false;
      }
    }
  }

  // Toggle flash mode
  Future<void> _toggleFlash() async {
    if (_flashEnabled) {
      await _controller.setFlashMode(FlashMode.off);
    } else {
      await _controller.setFlashMode(FlashMode.torch);
    }
    setState(() {
      _flashEnabled = !_flashEnabled;
    });
  }

  @override
  void dispose() {
    _cameraTimer?.cancel();
    _controller.dispose();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Detection')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      CameraPreview(_controller),
                      Positioned(
                        top: 20,
                        left: 20,
                        right: 20,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _currentMessage,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _toggleFlash,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        _flashEnabled
                            ? Colors.yellow.shade700
                            : Colors.grey.shade600,
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                    ),
                    child: Text(
                      _flashEnabled ? 'Turn Off Flash' : 'Turn On Flash',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
