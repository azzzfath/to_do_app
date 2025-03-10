class ToDo {
  String? id;
  String? todoTitle;
  String? todoDescription;
  String? todoCategory;
  bool isDone;
  DateTime? startDate;
  DateTime? endDate;

  ToDo({
    this.id,
    this.todoTitle,
    this.todoDescription,
    this.todoCategory,
    this.isDone = false,
    this.startDate,
    this.endDate,
  });

  // Dari JSON ke Object
  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        id: json['id'],
        todoTitle: json['todoTitle'],
        todoDescription: json['todoDescription'],
        todoCategory: json['todoCategory'],
        isDone: json['isDone'] ?? false,
        startDate: json['startDate'] != null
            ? DateTime.parse(json['startDate'])
            : null,
        endDate:
            json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      );

  // Dari Object ke JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'todoTitle': todoTitle,
        'todoDescription': todoDescription,
        'todoCategory': todoCategory,
        'isDone': isDone,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
      };
}
