BuildInformation get buildInformation => _buildInformation!;
late final BuildInformation? _buildInformation;

class BuildInformation {
  const BuildInformation._init({
    required this.buildType,
    required this.apiBaseUrl,
  });

  final BuildType buildType;
  final String apiBaseUrl;

  static void init({
    required BuildType buildType,
    required String apiBaseUrl,
  }) {
    _buildInformation = BuildInformation._init(
      buildType: buildType,
      apiBaseUrl: apiBaseUrl,
    );
  }
}

enum BuildType {
  user,
  management,
}
