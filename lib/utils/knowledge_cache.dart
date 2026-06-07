import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A simple in-memory cache with TTL (time to live) for knowledge hub data.
class KnowledgeCache {
  /// The cache instance.
  static KnowledgeCache? _instance;

  /// The cache map.
  final Map<String, CacheItem> _cache = {};

  /// The shared preferences instance.
  late SharedPreferences _prefs;

  /// Private constructor to prevent instantiation.
  KnowledgeCache._();

  /// Get the cache instance.
  static Future<KnowledgeCache> getInstance() async {
    if (_instance == null) {
      _instance = KnowledgeCache._();
      await _instance!._init();
    }
    return _instance!;
  }

  /// Initialize the cache.
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get a value from the cache.
  Future<String?> get(String key) async {
    final item = _cache[key];
    if (item != null && item.expiration > DateTime.now().millisecondsSinceEpoch) {
      return item.value;
    } else {
      final prefsValue = _prefs.getString(key);
      if (prefsValue != null) {
        _cache[key] = CacheItem(prefsValue, _prefs.getInt('$key-exp') ?? 0);
        return prefsValue;
      }
    }
    return null;
  }

  /// Set a value in the cache with a TTL.
  Future<void> set(String key, String value, {int ttl = 3600}) async {
    final expiration = DateTime.now().millisecondsSinceEpoch + ttl * 1000;
    _cache[key] = CacheItem(value, expiration);
    await _prefs.setString(key, value);
    await _prefs.setInt('$key-exp', expiration);
  }

  /// Remove a value from the cache.
  Future<void> remove(String key) async {
    _cache.remove(key);
    await _prefs.remove(key);
    await _prefs.remove('$key-exp');
  }
}

/// A cache item with a value and expiration time.
class CacheItem {
  /// The cache value.
  final String value;

  /// The expiration time in milliseconds since epoch.
  final int expiration;

  /// Create a new cache item.
  CacheItem(this.value, this.expiration);
}