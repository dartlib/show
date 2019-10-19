class LogLevel {
  static int error = 0;
  static int warning = 1;
  static int normal = 2;
  static int all = 3;
}

class Logger {
  int level = LogLevel.normal;

  void message(String message) {
    print(message);
  }

  void fine(String message) {}
}

final log = Logger();
