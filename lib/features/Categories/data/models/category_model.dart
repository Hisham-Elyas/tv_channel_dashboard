class Category {
  final int id;
  final String name;
  final int channels;

  Category({required this.id, required this.name, required this.channels});

  // Factory constructor to create a Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      channels: json['channels'],
    );
  }

  // Convert a Category object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'channels': channels,
    };
  }

  // Convert a list of JSON objects to a list of Category objects
  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }
}
