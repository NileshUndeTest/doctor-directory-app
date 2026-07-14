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
    workExperience = json['workExperience'];
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
  String? workExperience;

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
    map['workExperience'] = workExperience;
    return map;
  }

}