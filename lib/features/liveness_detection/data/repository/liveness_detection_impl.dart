import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:fest_ticketing/core/constant/api_url.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LivenessDetectionRepository {
  late WebSocketChannel _channel;
  late CameraController _controller;

  Future<void> initializeCamera(CameraDescription camera) async {
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await _controller.initialize();
  }

  void connectWebSocket(String mode, String userId) {
    _channel = WebSocketChannel.connect(
      Uri.parse(
        mode == 'register'
            ? ApiUrl.faceRegister(userId)
            : ApiUrl.faceVerify(userId),
      ),
    );
  }

  Future<String> takePicture() async {
    final image = await _controller.takePicture();
    final bytes = await image.readAsBytes();
    return 'data:image/jpeg;base64,${base64Encode(bytes)}';
  }

  void sendImage(String base64Image) {
    _channel.sink.add(jsonEncode({'image': base64Image}));
  }

  Stream<dynamic> getWebSocketStream() {
    return _channel.stream;
  }

  void closeWebSocket() {
    _channel.sink.close();
  }

  CameraController get controller => _controller;

  void disposeCamera() {
    _controller.dispose();
  }
}
