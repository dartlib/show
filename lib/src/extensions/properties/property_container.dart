class Property {
  final String name;
  final dynamic value;
  final Type type;
  Property({
    this.name,
    this.value,
    this.type,
  });
}

class PropertyContainer {
  final _props = <String, Property>{};

  void set<T>(String name, T value) {
    _props[name] = Property(
      name: name,
      type: _typeOf<T>(),
      value: value,
    );
  }

  Iterable<String> get keys {
    return _props.keys;
  }

  bool has(String name) {
    return _props.containsKey(name);
  }

  Property get(String name) {
    return _props[name];
  }

  Iterable<Property> get values {
    return _props.values;
  }

  Type _typeOf<T>() => T;
}
