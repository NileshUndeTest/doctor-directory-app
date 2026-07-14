
class WorkExperienceItem {
  final String dateRange;
  final String title;
  final String subtitle;

  WorkExperienceItem({
    required this.dateRange,
    required this.title,
    required this.subtitle,
  });
}
class DoctorsModel {
  final String? id;
  final String fullName;
  final String avatar;
  final String qualification;
  final String department;
  final String age;
  final String yearsOfExperience;
  final String status;
  final String about;
  final dynamic workExperience;

  DoctorsModel({
    this.id,
    required this.fullName,
    required this.avatar,
    required this.qualification,
    required this.department,
    required this.age,
    required this.yearsOfExperience,
    required this.status,
    required this.about,
    required this.workExperience,
  });
}
  factory DoctorsModel.fromJson(Map<String, dynamic> json) {
    return DoctorsModel(
      id: json['id']?.toString(),
      fullName: json['fullName']?.toString() ?? '',
      avatar: json['avatar']?.toString() ?? '',
      qualification: json['qualification']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
      age: json['age']?.toString() ?? '',
      yearsOfExperience: json['yearsOfExperience']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Active',
      about: json['about']?.toString() ?? '',
      workExperience: json['workExperience'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'fullName': fullName,
      'avatar': avatar,
      'qualification': qualification,
      'department': department,
      'age': age,
      'yearsOfExperience': yearsOfExperience,
      'status': status,
      'about': about,
      'workExperience': workExperience,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  String get initials{
    if (avatar.trim().isNotEmpty) )
  }
}
}