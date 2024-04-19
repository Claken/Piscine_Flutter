class MyEntry {
  int? id;
  String usermail;
  DateTime date;
  String title;
  String feeling;
  String content;

  MyEntry({
    this.id,
    required this.usermail,
    required this.date,
    required this.title,
    required this.feeling,
    required this.content,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'usermail': usermail,
      'date': date.toString(),
      'title': title,
      'feeling': feeling,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, usermail: $usermail, date: ${date.toString()}, title: $title, feeling: $feeling}';
  }
}
