import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/common/widgets/snackbar/snackbar_failed.dart';
import 'package:fest_ticketing/common/widgets/snackbar/snackbar_success.dart';
import 'package:fest_ticketing/core/constant/api_url.dart';
import 'package:fest_ticketing/core/main_menu/screen/main_menu.dart';
import 'package:fest_ticketing/core/services/flutter_secure_storage_service.dart';
import 'package:fest_ticketing/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:fest_ticketing/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LivenessDetection extends StatefulWidget {
  final CameraDescription camera;
  final String mode;

  const LivenessDetection({Key? key, required this.camera, required this.mode})
      : super(key: key);

  @override
  _LivenessDetectionState createState() => _LivenessDetectionState();
}

class _LivenessDetectionState extends State<LivenessDetection> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late WebSocketChannel _channel;
  Timer? _timer;
  int _remainingTime = 40;
  String _currentMessage = "";
  int _progress = 0;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      if (mounted) {
        startDetection();
      }
    });
  }

  void startDetection() async {
    final token = await sl<SecureStorageService>().read('access_token');

    print("Tokens: $token");
    _channel = WebSocketChannel.connect(
      Uri.parse(
        widget.mode == 'register'
            ? 'ws://${ApiUrl.host}/ws/register/$token'
            : 'ws://${ApiUrl.host}/ws/verify/$token',
      ),
    );

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          Navigator.pop(context);
        }
      });
    });

    _listenToWebSocket();
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

        _channel.sink.add(jsonEncode({
          'image': base64Image,
        }));

        _isProcessing = false;
        await Future.delayed(Duration(milliseconds: 100));
      } catch (e) {
        print('Error processing frame: $e');
        _isProcessing = false;
      }
    }
  }

  void _listenToWebSocket() {
    bool isCompleted = false;
    _channel.stream.listen(
      (response) {
        final data = jsonDecode(response);
        setState(() {
          _currentMessage = data['message'] ?? '';
          _progress = data['progress'] ?? 0;
          if (data['status'] == 'registration_completed' ||
              data['status'] == 'verification_successful') {
            ScaffoldMessenger.of(context).showSnackBar(
                SuccessSnackBar(message: 'Registration successfuly completed'));
            isCompleted = true;
            BlocProvider.of<AuthBloc>(context).add(AuthRegisteredCompleted());
            AppNavigator.pushReplacement(context, MainMenuScreen());
          } else if (data['status'] == 'max_attempts_reached' ||
              data['status'] == 'timeout') {
            ScaffoldMessenger.of(context).showSnackBar(
                FailedSnackBar(message: 'Liveness detection failed'));
          }
        });
      },
      onError: (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(FailedSnackBar(message: 'Connection error occurred'));
      },
      onDone: () {
        if (mounted && !isCompleted) {
          ScaffoldMessenger.of(context).showSnackBar(
              FailedSnackBar(message: 'WebSocket connection closed'));
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _channel.sink.close();
    _controller.dispose(); // Ensure the camera controller is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liveness Detection - ${widget.mode}')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Transform.scale(
                        scaleX: -1, // Flip the camera horizontally
                        child: CameraPreview(_controller),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        right: 20,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _currentMessage,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: _progress / 100,
                                backgroundColor: Colors.grey,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Time remaining: $_remainingTime seconds',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
