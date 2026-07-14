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

class Doctor {
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

  Doctor({
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

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
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

  String get initials {
    if (avatar.trim().isNotEmpty && !avatar.startsWith('http') && avatar.trim().length <= 3) {
      return avatar.trim().toUpperCase();
    }
    if (fullName.isEmpty) return 'DR';
    final nameClean = fullName.replaceAll(RegExp(r'^(Dr\.|dr\.)\s*'), '').trim();
    final parts = nameClean.split(' ');
    if (parts.isEmpty || parts[0].isEmpty) return 'DR';
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  List<WorkExperienceItem> get parsedExperience {
    if (workExperience is List) {
      return (workExperience as List).map((item) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(item as Map);
        final start = map['startYear']?.toString() ?? '';
        final end = map['endYear']?.toString() ?? '';
        final hospital = map['hospitalName']?.toString() ?? '';
        final role = map['role']?.toString() ?? '';
        return WorkExperienceItem(
          dateRange: '$start - $end',
          title: role,
          subtitle: hospital,
        );
      }).toList();
    }

    final String expStr = workExperience?.toString() ?? '';
    String role = expStr;
    String hospital = '';
    if (expStr.contains(' at ')) {
      final parts = expStr.split(' at ');
      role = parts[0];
      hospital = parts[1];
    } else if (expStr.contains(' @ ')) {
      final parts = expStr.split(' @ ');
      role = parts[0];
      hospital = parts[1];
    }

    int expYears = 5;
    try {
      expYears = int.parse(yearsOfExperience.replaceAll(RegExp(r'[^0-9]'), ''));
    } catch (_) {}

    final list = <WorkExperienceItem>[];
    list.add(WorkExperienceItem(
      dateRange: '2024 - Present',
      title: role.isNotEmpty ? role : 'Specialist Doctor',
      subtitle: hospital.isNotEmpty ? hospital : 'Medical Center',
    ));

    if (expYears >= 5) {
      list.add(WorkExperienceItem(
        dateRange: '2020 - 2024',
        title: 'Consultant $department',
        subtitle: 'Fortis Hospital',
      ));
    }
    if (expYears >= 10) {
      list.add(WorkExperienceItem(
        dateRange: '2016 - 2020',
        title: 'Resident Doctor',
        subtitle: 'City Medical Center',
      ));
    }
    return list;
  }
}