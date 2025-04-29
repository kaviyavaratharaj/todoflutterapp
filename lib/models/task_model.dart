class TaskModel {
  final String id;
  String title;
  String description;
  final String ownerEmail;
  final List<String> sharedWith;
  late final bool isDone;
  final DateTime updatedAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.ownerEmail,
    required this.sharedWith,
    required this.isDone,
    required this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      ownerEmail: json['ownerEmail'],
      sharedWith: List<String>.from(json['sharedWith']),
      isDone: json['isDone'],
      updatedAt: (json['updatedAt']).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ownerEmail': ownerEmail,
      'sharedWith': sharedWith,
      'isDone': isDone,
      'updatedAt': updatedAt,
    };
  }
}
