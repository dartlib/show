class PropertyContainer {
  final _props = <String, dynamic>{};

  void set<T>(String key, T value) {
    _props[key] = value;
  }

  bool has(String key) {
    return _props.containsKey(key);
  }

  T get<T>(String key) {
    return _props[key] as T;
  }
}
