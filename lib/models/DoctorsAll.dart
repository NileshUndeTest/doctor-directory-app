import 'dart:convert';
DoctorsAll doctorsAllFromJson(String str) => DoctorsAll.fromJson(json.decode(str));
String doctorsAllToJson(DoctorsAll data) => json.encode(data.toJson());
class DoctorsAll {
  DoctorsAll({
    this.id,
    this.fullName,
    this.avatar,
    this.qualification,
    this.department,
    this.age,
    this.yearsOfExperience,
    this.status,
    this.about,
    this.workExperience,});

  DoctorsAll.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    avatar = json['avatar'];
    qualification = json['qualification'];
    department = json['department'];
    age = json['age'];
    yearsOfExperience = json['yearsOfExperience'];
    status = json['status'];
    about = json['about'];
    if (json['workExperience'] != null) {
      workExperience = [];
      json['workExperience'].forEach((v) {
        workExperience?.add(WorkExperience.fromJson(v));
      });
    }
  }
  String? id;
  String? fullName;
  String? avatar;
  String? qualification;
  String? department;
  String? age;
  String? yearsOfExperience;
  String? status;
  String? about;
  List<WorkExperience>? workExperience;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fullName'] = fullName;
    map['avatar'] = avatar;
    map['qualification'] = qualification;
    map['department'] = department;
    map['age'] = age;
    map['yearsOfExperience'] = yearsOfExperience;
    map['status'] = status;
    map['about'] = about;
    if (workExperience != null) {
      map['workExperience'] = workExperience?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

WorkExperience workExperienceFromJson(String str) => WorkExperience.fromJson(json.decode(str));
String workExperienceToJson(WorkExperience data) => json.encode(data.toJson());
class WorkExperience {
  WorkExperience({
    this.startYear,
    this.endYear,
    this.hospitalName,
    this.role,});

  WorkExperience.fromJson(dynamic json) {
    startYear = json['startYear'];
    endYear = json['endYear'];
    hospitalName = json['hospitalName'];
    role = json['role'];
  }
  String? startYear;
  String? endYear;
  String? hospitalName;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startYear'] = startYear;
    map['endYear'] = endYear;
    map['hospitalName'] = hospitalName;
    map['role'] = role;
    return map;
  }

}