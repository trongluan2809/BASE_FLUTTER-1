class BuildConfig {
  static String endpoint = Environment.dev.value;
  static bool isLog = false;
}

enum Environment { dev, product }

extension EnvironmentEx on Environment {
  String get value {
    switch (this) {
      case Environment.dev:
        return 'https://api.github.com/';
      case Environment.product:
        return 'server.product.here';
      default:
        return '';
    }
  }
}
