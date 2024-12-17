import 'package:camera/camera.dart';

class CameraService {
  late CameraDescription frontCamera;
  late CameraDescription backCamera;
  late List<CameraDescription> cameras;

  Future<void> initializeCameras() async {
    cameras = await availableCameras();
    frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);
  }
}
