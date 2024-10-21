import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageService {
  static GetStorage? _storage;

  static Future<void> initializeStorage(String id) async {
    await GetStorage.init(id);
    _storage = GetStorage(id);
  }

  GetStorage get storage {
    if (_storage == null) {
      throw Exception('Storage has not been initialized'.hardcoded);
    }
    return _storage!;
  }

  Future<void> saveData<T>(String key, T value) async {
    _storage = storage;
    await _storage!.write(key, value);
  }

  T? getData<T>(String key) {
    _storage = storage;
    return _storage!.read<T>(key);
  }

  Future<void> remove(String key) async {
    _storage = storage;
    await _storage!.remove(key);
  }

  bool contains(String key) {
    _storage = storage;
    return _storage!.hasData(key);
  }

  Future<void> clear() async {
    _storage = storage;
    return _storage!.erase();
  }
}
