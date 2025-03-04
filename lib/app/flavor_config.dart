class AppFlavorConfig {
  final String name;
  final String apiBaseUrl;
  final String webUrl;
  final String sentryDsn;
  final String mixpanelToken;

  AppFlavorConfig({
    required this.name,
    required this.apiBaseUrl,
    required this.webUrl,
    required this.sentryDsn,
    required this.mixpanelToken,
  });

  static AppFlavorConfig? _instance;

  static AppFlavorConfig get instance {
    if (_instance == null) {
      throw Exception('AppFlavorConfig has not been initialized');
    }
    return _instance!;
  }

  static void initialize(AppFlavorConfig config) {
    _instance = config;
  }
} 