import 'dart:convert';

class GroupChannelListModel {
  final int count;
  final List<GroupChannelModel> groups;

  GroupChannelListModel({
    required this.count,
    required this.groups,
  });

  factory GroupChannelListModel.fromMap(Map<String, dynamic> map) {
    return GroupChannelListModel(
      count: map['count'] as int, // Ensure it's an integer
      groups: List<GroupChannelModel>.from(
        (map['groups'] as List).map(
          (x) => GroupChannelModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory GroupChannelListModel.fromJson(String source) =>
      GroupChannelListModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'groups': groups.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}

class GroupChannelModel {
  final int id;
  final String groupTitle;
  final int channels;

  GroupChannelModel({
    required this.id,
    required this.groupTitle,
    required this.channels,
  });

  factory GroupChannelModel.fromMap(Map<String, dynamic> map) {
    return GroupChannelModel(
      id: map['id'] as int, // Ensure it's an integer
      groupTitle: map['group_title'] as String,
      channels: map['channels'] as int, // Ensure it's an integer
    );
  }

  factory GroupChannelModel.fromJson(String source) =>
      GroupChannelModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group_title': groupTitle,
      'channels': channels,
    };
  }

  String toJson() => json.encode(toMap());
}
