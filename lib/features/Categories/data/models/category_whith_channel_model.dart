import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryWithChannels {
  final int categoryId;
  final String categoryName;
  final int count;
  final List<Channel> channels;

  CategoryWithChannels({
    required this.categoryId,
    required this.categoryName,
    required this.count,
    required this.channels,
  });

  factory CategoryWithChannels.fromJson(Map<String, dynamic> json) {
    return CategoryWithChannels(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      count: json['count'],
      channels: (json['channels'] as List<dynamic>)
          .map((channelJson) => Channel.fromJson(channelJson))
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

  /// Converts a list of JSON objects into a list of CategoryWithChannels objects
  static List<CategoryWithChannels> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CategoryWithChannels.fromJson(json)).toList();
  }

  @override
  String toString() {
    return 'CategoryWithChannels(categoryId: $categoryId, categoryName: $categoryName, count: $count, channels: $channels)';
  }

  @override
  bool operator ==(covariant CategoryWithChannels other) {
    if (identical(this, other)) return true;

    return other.categoryId == categoryId &&
        other.categoryName == categoryName &&
        other.count == count &&
        listEquals(other.channels, channels);
  }

  @override
  int get hashCode {
    return categoryId.hashCode ^
        categoryName.hashCode ^
        count.hashCode ^
        channels.hashCode;
  }
}

class Channel {
  final int id;
  final int groupId;
  final String tvgId;
  final String tvgName;
  final String tvgLogo;
  final String name;
  final String url;
  final String createdAt;
  final String customName;
  final List<ChannelLink> urlList;

  Channel({
    required this.id,
    required this.groupId,
    required this.tvgId,
    required this.tvgName,
    required this.tvgLogo,
    required this.name,
    required this.url,
    required this.createdAt,
    required this.customName,
    required this.urlList,
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
      createdAt: json['created_at'],
      customName: json['customName'],
      urlList: (json['links'] as List<dynamic>?)
              ?.map((link) => ChannelLink.fromJson(link))
              .toList() ??
          [],
      // urlList: [],
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
      'created_at': createdAt,
      'customName': customName,
      'links': urlList.map((link) => link.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Channel(id: $id, groupId: $groupId, tvgId: $tvgId, tvgName: $tvgName, tvgLogo: $tvgLogo, name: $name, url: $url, createdAt: $createdAt, customName: $customName, urlList: $urlList)';
  }

  @override
  bool operator ==(covariant Channel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.groupId == groupId &&
        other.tvgId == tvgId &&
        other.tvgName == tvgName &&
        other.tvgLogo == tvgLogo &&
        other.name == name &&
        other.url == url &&
        other.createdAt == createdAt &&
        other.customName == customName &&
        listEquals(other.urlList, urlList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        groupId.hashCode ^
        tvgId.hashCode ^
        tvgName.hashCode ^
        tvgLogo.hashCode ^
        name.hashCode ^
        url.hashCode ^
        createdAt.hashCode ^
        customName.hashCode ^
        urlList.hashCode;
  }
}

class ChannelLink {
  final String name;
  final String url;

  ChannelLink({required this.name, required this.url});

  factory ChannelLink.fromJson(Map<String, dynamic> json) {
    return ChannelLink(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  @override
  String toString() => 'ChannelLink(name: $name, url: $url)';

  @override
  bool operator ==(covariant ChannelLink other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
