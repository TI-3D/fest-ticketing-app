import 'package:camera/camera.dart';
import 'package:fest_ticketing/features/liveness_detection/data/repository/liveness_detection_impl.dart';

class LivenessDetectionUseCase {
  final LivenessDetectionRepository repository;

  LivenessDetectionUseCase(this.repository);

  Future<void> initializeCamera(CameraDescription camera) async {
    await repository.initializeCamera(camera);
  }

  void connectWebSocket(String mode, String userId) {
    repository.connectWebSocket(mode, userId);
  }

  Future<String> takePicture() async {
    return await repository.takePicture();
  }

  void sendImage(String base64Image) {
    repository.sendImage(base64Image);
  }

  Stream<dynamic> getWebSocketStream() {
    return repository.getWebSocketStream();
  }

  void closeWebSocket() {
    repository.closeWebSocket();
  }

  void disposeCamera() {
    repository.disposeCamera();
  }
}