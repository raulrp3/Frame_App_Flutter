// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

enum BuildVariant {
  dev,
  test,
  beta,
  pro,
}

class Environment {
  late final BuildVariant _buildVariant;
  late final String baseApiUrl;
  static Environment? _instance;

  Environment.internal(BuildVariant buildVariant) {
    _buildVariant = buildVariant;

    switch (_buildVariant) {
      case BuildVariant.dev:
        baseApiUrl = 'DEV';
        break;
      case BuildVariant.test:
        baseApiUrl = 'TEST';
        break;
      case BuildVariant.beta:
        baseApiUrl = 'BETA';
        break;
      case BuildVariant.pro:
        baseApiUrl = 'PRO';
        break;
    }
  }

  factory Environment.init(BuildVariant buildVariant) {
    _instance = Environment.internal(buildVariant);
    return _instance!;
  }

  static Environment get instance {
    if (_instance == null) throw Exception('You should init Environment before get instance');
    return _instance!;
  }

  BuildVariant get buildVariant => _buildVariant;
}
