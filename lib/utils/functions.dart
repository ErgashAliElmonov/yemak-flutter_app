import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final storage = FlutterSecureStorage();

  void set(String key, value) {
    storage.write(key: key, value: value);
  }

  Future<String?> get(String key) async {
    final value = await storage.read(key: key);
    return value;
  }

  Future<bool> isTokenExists() async {
    storage.deleteAll();
    String? token = await storage.read(key: 'token');
    return token != null;
  }
}
