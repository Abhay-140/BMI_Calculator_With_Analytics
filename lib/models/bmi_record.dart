class BmiRecord {
  final double bmi;
  final String category;
  final double weight;
  final double height;
  final int age;
  final String gender;
  final String date;

  BmiRecord({
    required this.bmi,
    required this.category,
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'bmi': bmi,
    'category': category,
    'weight': weight,
    'height': height,
    'age': age,
    'gender': gender,
    'date': date,
  };

  factory BmiRecord.fromJson(Map<String, dynamic> json) => BmiRecord(
    bmi: json['bmi'],
    category: json['category'],
    weight: json['weight'],
    height: json['height'],
    age: json['age'],
    gender: json['gender'],
    date: json['date'],
  );
}
