// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChannelModelListModel {
  final int groupId;
  final String groupName;
  final int count;
  final List<ChannelModel> channelModels;

  ChannelModelListModel({
    required this.groupId,
    required this.groupName,
    required this.count,
    required this.channelModels,
  });

  factory ChannelModelListModel.fromJson(Map<String, dynamic> json) {
    return ChannelModelListModel(
      groupId: json['groupId'],
      groupName: json['groupName'],
      count: json['count'],
      channelModels: (json['channels'] as List)
          .map((channelModel) => ChannelModel.fromJson(channelModel))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'count': count,
      'channelModels':
          channelModels.map((channelModel) => channelModel.toJson()).toList(),
    };
  }
}

class ChannelModel {
  final int id;
  final int groupId;
  final String tvgId;
  final String tvgName;
  final String tvgLogo;
  final String name;
  final String url;
  final DateTime createdAt;

  ChannelModel({
    required this.id,
    required this.groupId,
    required this.tvgId,
    required this.tvgName,
    required this.tvgLogo,
    required this.name,
    required this.url,
    required this.createdAt,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'] ?? '',
      groupId: json['group_id'],
      tvgId: json['tvg_id'] ?? '',
      tvgName: json['tvg_name'],
      tvgLogo: json['tvg_logo'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
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

  @override
  String toString() {
    return 'ChannelModel(id: $id, groupId: $groupId, tvgId: $tvgId, tvgName: $tvgName, tvgLogo: $tvgLogo, name: $name, url: $url, createdAt: $createdAt)';
  }
}
