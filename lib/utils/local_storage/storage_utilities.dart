import 'package:get_storage/get_storage.dart';

class TLocalStroage {
  late final GetStorage _storage;

  // singleton
  static TLocalStroage? _instance;
  TLocalStroage._internal();

  factory TLocalStroage.instance() {
    _instance ?? TLocalStroage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = TLocalStroage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readDate<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}
