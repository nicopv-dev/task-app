class Task {
  String? title;
  String? uid;
  String? date;
  String? category;

  Task({this.title, this.uid, this.date, this.category});

  Map <String, Object?> toJson() => {
    'title': title,
    'uid': uid,
    'date': date,
    'category': category
  };

  static Task fromJson(Map<String, dynamic?> json) => Task(
      title: json['title']! as String,
      uid: json['uid'] as String,
      date: json['date'] as String,
      category: json['category'] as String
  );
}