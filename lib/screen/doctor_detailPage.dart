import 'package:doctor_directory_app/screen/doctor_detailPage.dart';
import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String qualification;
  final String specialty;
  final String status;
  final int age;
  final int experienceYears;
  final String department;
  final String about;
  final List<WorkExperience> workHistory;

  const Doctor({
    required this.name,
    required this.qualification,
    required this.specialty,
    required this.status,
    required this.age,
    required this.experienceYears,
    required this.department,
    required this.about,
    required this.workHistory,
  });
}

class WorkExperience {
  final String period;
  final String title;
  final String place;

  const WorkExperience({
    required this.period,
    required this.title,
    required this.place,
  });
}

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key});

  static const Color navy = Color(0xFF16213E);


  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final doctor = const Doctor(
      name: 'Dr. Rahul Verma',
      qualification: 'MBBS, MD (Cardiology)',
      specialty: 'Cardiology',
      status: 'Active',
      age: 45,
      experienceYears: 15,
      department: 'Cardiology',
      about:
          'Experienced Cardiologist with a demonstrated history of '
          'working in the healthcare industry. Skilled in Interventional '
          'Cardiology, Cardiac Diagnostics and Patient Care.',
      workHistory: [
        WorkExperience(
          period: '2024 - Present',
          title: 'Senior Cardiologist',
          place: 'Apollo Hospital',
        ),
        WorkExperience(
          period: '2020 - 2024',
          title: 'Consultant Cardiologist',
          place: 'Fortis Hospital',
        ),
        WorkExperience(
          period: '2016 - 2020',
          title: 'Resident Doctor',
          place: 'City Medical Center',
        ),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: DoctorDetailsScreen.navy,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Doctor Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _ProfileCard(doctor: doctor),
          const SizedBox(height: 16),
          _PersonalInfoCard(doctor: doctor),
          const SizedBox(height: 16),
          _AboutMeCard(about: doctor.about),
          const SizedBox(height: 16),
          _WorkExperienceCard(history: doctor.workHistory),
          const SizedBox(height: 24),
          _RemoveDoctorButton(doctorName: doctor.name),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final Doctor doctor;
  const _ProfileCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: DoctorDetailsScreen.navy,
            child: Text(
              doctor.name.trim().isNotEmpty
                  ? doctor.name.trim().replaceFirst('Dr. ', '')[0]
                  : '?',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  doctor.qualification,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 2),
                Text(
                  doctor.specialty,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    doctor.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalInfoCard extends StatelessWidget {
  final Doctor doctor;
  const _PersonalInfoCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 14),
          _InfoRow(
            icon: Icons.person_outline,
            label: 'Age',
            value: '${doctor.age} Years',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.access_time,
            label: 'Experience',
            value: '${doctor.experienceYears} Years',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.local_hospital_outlined,
            label: 'Department',
            value: doctor.department,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black45),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}

class _AboutMeCard extends StatelessWidget {
  final String about;
  const _AboutMeCard({required this.about});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Me',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            about,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkExperienceCard extends StatelessWidget {
  final List<WorkExperience> history;
  const _WorkExperienceCard({required this.history});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Work Experience',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < history.length; i++)
            _TimelineTile(entry: history[i], isLast: i == history.length - 1),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final WorkExperience entry;
  final bool isLast;

  const _TimelineTile({required this.entry, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: Color(0xFF2F6FED),
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: const Color(0xFFE0E4EC)),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.period,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.title,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  Text(
                    entry.place,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RemoveDoctorButton extends StatelessWidget {
  final String doctorName;
  const _RemoveDoctorButton({required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () => _showRemoveDialog(context, doctorName),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE64C4C)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
        ),
        icon: const Icon(Icons.delete_outline, color: Color(0xFFE64C4C)),
        label: const Text(
          'Remove Doctor',
          style: TextStyle(
            color: Color(0xFFE64C4C),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFDEAEA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFE64C4C),
                    size: 26,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Remove Doctor',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  'Are you sure you want to remove $name? '
                  'This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Color(0xFFE0E4EC)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$name removed')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: const Color(0xFFE64C4C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Remove',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
