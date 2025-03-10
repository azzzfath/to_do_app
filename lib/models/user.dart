class UserModel {
  final String name;
  final DateTime dob;
  final String major;
  final String email;
  final String? photoPath;

  UserModel({
    required this.name,
    required this.dob,
    required this.major,
    required this.email,
    this.photoPath,
  });

  UserModel copyWith({
    String? name,
    DateTime? dob,
    String? major,
    String? email,
    String? photoPath,
  }) {
    return UserModel(
      name: name ?? this.name,
      dob: dob ?? this.dob,
      major: major ?? this.major,
      email: email ?? this.email,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        dob: json['dob'] != null ? DateTime.parse(json['dob']) : DateTime.now(),
        major: json['major'],
        email: json['email'],
        photoPath: json['photoPath'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'dob': dob.toIso8601String(),
        'major': major,
        'email': email,
        'photoPath': photoPath,
      };
}
