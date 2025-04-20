class TrainingModel {
  final String place;
  final String name;
  final String date;

  TrainingModel({
    required this.place,
    required this.name,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'place': place,
        'name': name,
        'date': date,
      };

  factory TrainingModel.fromJson(Map<String, dynamic> json) => TrainingModel(
        place: json['place'],
        name: json['name'],
        date: json['date'],
      );
}
