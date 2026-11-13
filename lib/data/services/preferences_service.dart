import 'package:shared_preferences/shared_preferences.dart';

/// Stateless wrapper around [SharedPreferences] with safe in-memory fallback
/// so tests and headless contexts work without platform channel failures.
class PreferencesService {
  PreferencesService({this._prefs});

  SharedPreferences? _prefs;
  final Map<String, Object> _memoryFallback = {};

  Future<void> init() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
    } catch (_) {
      // Fall back to in-memory store when platform plugin is unavailable.
    }
  }

  bool getBool(String key, {bool defaultValue = false}) {
    if (_prefs != null) return _prefs!.getBool(key) ?? defaultValue;
    return (_memoryFallback[key] as bool?) ?? defaultValue;
  }

  Future<void> setBool(String key, bool value) async {
    _memoryFallback[key] = value;
    await _prefs?.setBool(key, value);
  }

  String? getString(String key) {
    if (_prefs != null) return _prefs!.getString(key);
    return _memoryFallback[key] as String?;
  }

  Future<void> setString(String key, String value) async {
    _memoryFallback[key] = value;
    await _prefs?.setString(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    if (_prefs != null) return _prefs!.getInt(key) ?? defaultValue;
    return (_memoryFallback[key] as int?) ?? defaultValue;
  }

  Future<void> setInt(String key, int value) async {
    _memoryFallback[key] = value;
    await _prefs?.setInt(key, value);
  }

  List<String> getStringList(String key) {
    if (_prefs != null) return _prefs!.getStringList(key) ?? const [];
    return (_memoryFallback[key] as List<String>?) ?? const [];
  }

  Future<void> setStringList(String key, List<String> value) async {
    _memoryFallback[key] = List<String>.from(value);
    await _prefs?.setStringList(key, value);
  }
}
