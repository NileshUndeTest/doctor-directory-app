class DoctorsModel {
  final String id;
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
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.qualification,
    required this.department,
    required this.age,
    required this.yearsOfExperience,
    required this.status,
    required this.about,
    required this.workExperience
  });
}

class WorkExperienceItem{
 final String dateRange;
 final String hospitalName;
 final String role;


 WorkExperienceItem({
   required this.dateRange,
   required this.hospitalName,
   required this.role,
});

}
