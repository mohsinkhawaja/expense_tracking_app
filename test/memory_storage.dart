import 'package:localstorage/localstorage.dart';

class MemoryStorage implements LocalStorage {
  final Map<String, String> data = {};
  @override
  int get length => data.length;
  @override
  String? key(int index) =>
      index < data.length ? data.keys.elementAt(index) : null;
  @override
  String? getItem(String key) => data[key];
  @override
  void setItem(String key, String value) {
    data[key] = value;
  }

  @override
  void removeItem(String key) {
    data.remove(key);
  }

  @override
  void clear() => data.clear();
}
