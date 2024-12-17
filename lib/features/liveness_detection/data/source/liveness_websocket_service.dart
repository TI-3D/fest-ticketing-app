import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class LivenessDetectionRemoteDataSource {
  late WebSocketChannel _channel;

  void connect(String mode, String userId) {
    _channel = WebSocketChannel.connect(
      Uri.parse(
        mode == 'register'
            ? 'ws://192.168.73.247:3000/ws/register/$userId'
            : 'ws://192.168.73.247:3000/ws/verify/$userId',
      ),
    );
  }

  void sendImage(String base64Image) {
    _channel.sink.add(jsonEncode({'image': base64Image}));
  }

  Stream<dynamic> getWebSocketStream() {
    return _channel.stream;
  }

  void close() {
    _channel.sink.close();
  }
}