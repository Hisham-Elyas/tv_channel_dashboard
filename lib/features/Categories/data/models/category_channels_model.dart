class Channel {
  final int id;
  final int groupId;
  final String tvgId;
  final String tvgName;
  final String tvgLogo;
  final String name;
  final String url;
  final DateTime createdAt;

  Channel({
    required this.id,
    required this.groupId,
    required this.tvgId,
    required this.tvgName,
    required this.tvgLogo,
    required this.name,
    required this.url,
    required this.createdAt,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'],
      groupId: json['group_id'],
      tvgId: json['tvg_id'],
      tvgName: json['tvg_name'],
      tvgLogo: json['tvg_logo'],
      name: json['name'],
      url: json['url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'tvg_id': tvgId,
      'tvg_name': tvgName,
      'tvg_logo': tvgLogo,
      'name': name,
      'url': url,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class CategoryChannels {
  final int categoryId;
  final String categoryName;
  final int count;
  final List<Channel> channels;

  CategoryChannels({
    required this.categoryId,
    required this.categoryName,
    required this.count,
    required this.channels,
  });

  factory CategoryChannels.fromJson(Map<String, dynamic> json) {
    return CategoryChannels(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      count: json['count'],
      channels: (json['channels'] as List)
          .map((channel) => Channel.fromJson(channel))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'count': count,
      'channels': channels.map((channel) => channel.toJson()).toList(),
    };
  }
}
