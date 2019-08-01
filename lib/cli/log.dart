class LogLevel {
  static int error = 0;
  static int warning = 1;
  static int normal = 2;
  static int all = 3;
}

class Logger {
  int level = LogLevel.normal;

  message(String message) {
    print(message);
  }

  fine(String message) {}
}

final log = Logger();
