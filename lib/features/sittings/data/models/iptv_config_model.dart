class IptvConfig {
  int id;
  String host;
  String username;
  String password;
  int allowUse; // 1 = active, 0 = inactive

  IptvConfig({
    required this.id,
    required this.host,
    required this.username,
    required this.password,
    required this.allowUse,
  });

  factory IptvConfig.fromJson(Map<String, dynamic> json) {
    return IptvConfig(
      id: json['id'],
      host: json['host'],
      username: json['username'],
      password: json['password'],
      allowUse: json['allow_use'],
    );
  }
  // Convert list of JSON objects into a list of IptvConfig instances
  static List<IptvConfig> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => IptvConfig.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'username': username,
      'password': password,
    };
  }
}
