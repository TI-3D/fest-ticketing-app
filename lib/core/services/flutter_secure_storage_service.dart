import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService() : _storage = const FlutterSecureStorage();

  // Fungsi untuk menyimpan data dengan waktu kedaluwarsa yang opsional
  Future<void> write(String key, String value, {Duration? exp}) async {
    DateTime? expiryTime;
    if (exp != null) {
      // Jika exp tidak null, tentukan waktu kedaluwarsa
      expiryTime = DateTime.now().add(exp);
    }

    final Map<String, dynamic> data = {
      'value': value,
      'expiry': expiryTime?.toIso8601String(), // Bisa null jika tidak ada expiry
    };

    // Convert data ke format JSON untuk disimpan
    await _storage.write(key: key, value: jsonEncode(data));
  }

  // Fungsi untuk membaca data dengan memeriksa waktu kedaluwarsa
  Future<String?> read(String key) async {
    String? storedData = await _storage.read(key: key);
    if (storedData == null) {
      return null;
    }

    // Decode data menjadi Map
    final Map<String, dynamic> data = jsonDecode(storedData);
    final expiryTimeString = data['expiry'];

    // Jika tidak ada expiry (null), data tidak memiliki kedaluwarsa
    if (expiryTimeString != null) {
      final DateTime expiryTime = DateTime.parse(expiryTimeString);

      // Cek apakah data sudah kedaluwarsa
      if (DateTime.now().isAfter(expiryTime)) {
        // Jika kedaluwarsa, hapus data dan kembalikan null
        await _storage.delete(key: key);
        return null;
      }
    }

    // Jika belum kedaluwarsa atau tidak ada expiry, kembalikan nilai
    return data['value'];
  }

  // Fungsi untuk menghapus data dengan key tertentu
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  // Fungsi untuk menghapus semua data yang ada
  Future<void> removeAll() async {
    await _storage.deleteAll();
  }
}
