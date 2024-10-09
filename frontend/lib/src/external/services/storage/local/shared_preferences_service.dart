import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared preferences service
class SharedPreferencesService {
  static SharedPreferences? _prefs;

  /// Initialize storage
  static Future<void> initializeStorage() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('Shared Preference has not been initialized'.hardcoded);
    }
    return _prefs!;
  }

  Future<void> saveData<T>(String key, T value) async {
    _prefs = prefs;
    switch (T) {
      case String:
        await _prefs!.setString(key, value as String);
      case int:
        await _prefs!.setInt(key, value as int);
      case bool:
        await _prefs!.setBool(key, value as bool);
      case double:
        await _prefs!.setDouble(key, value as double);
      default:
        throw Exception('Unsupported data type');
    }
  }

  T? getData<T>(String key) {
    _prefs = prefs;
    switch (T) {
      case String:
        return _prefs!.getString(key) as T?;
      case int:
        return _prefs!.getInt(key) as T?;
      case bool:
        return _prefs!.getBool(key) as T?;
      case double:
        return _prefs!.getDouble(key) as T?;
      default:
        throw Exception('Unsupported data type'.hardcoded);
    }
  }

  Future<void> remove(String key) async {
    _prefs = prefs;
    await _prefs!.remove(key);
  }

  bool contains(String key) {
    _prefs = prefs;
    return _prefs!.containsKey(key);
  }

  Future<void> clear() async {
    _prefs = prefs;
    await _prefs!.clear();
  }
}
