class Task {
  Task({required this.title, required this.dateTime});

  String title;
  DateTime dateTime;


  Task.fromJson(Map<String, dynamic> json)
  : title = json['title'],
  dateTime = DateTime.parse(json['dateTime']);



  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
