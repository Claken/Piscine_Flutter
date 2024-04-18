class Entry {
  int? id;
  String title;
  String description;
  DateTime createdAt;

  Entry({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt
  });
}