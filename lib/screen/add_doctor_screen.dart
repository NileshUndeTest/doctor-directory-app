import 'package:doctor_directory_app/model/WorkExperienceItem.dart';
import 'package:doctor_directory_app/provider/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _yearsOfExpController = TextEditingController();
  final _aboutController = TextEditingController();

  String _selectedDept = 'Cardiology';
  String _selectedStatus = 'Active';
  int _aboutLength = 0;
  bool _isSaving = false;

  final List<String> _departments = [
    'Cardiology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'Dental',
    'General Medicine',
    'Dermatology',
  ];

  final List<String> _statuses = ['Active', 'Offline', 'Busy'];

  @override
  void initState() {
    super.initState();
    _aboutController.addListener(() {
      setState(() {
        _aboutLength = _aboutController.text.length;
      });
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _qualificationController.dispose();
    _yearsOfExpController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _saveDoctor() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    String nameText = _fullNameController.text.trim();
    String initials = 'DR';
    final parts = nameText
        .replaceAll(RegExp(r'^(Dr\.|dr\.)\s*'), '')
        .trim()
        .split(' ');
    if (parts.isNotEmpty) {
      if (parts.length == 1) {
        initials =
            parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
      } else {
        initials = '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
    }

    final newDoctor = Doctor(
      fullName: nameText.startsWith(RegExp(r'^(Dr\.|dr\.)'))
          ? nameText
          : 'Dr. $nameText',
      avatar: initials,
      qualification: _qualificationController.text.trim(),
      department: _selectedDept,
      age: _ageController.text.trim(),
      yearsOfExperience: '${_yearsOfExpController.text.trim()} Years',
      status: _selectedStatus,
      about: _aboutController.text.trim(),
      workExperience: 'Specialist in $_selectedDept',
    );

    try {
      final success =
          await context.read<DoctorProvider>().addDoctor(newDoctor);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Doctor profile created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true); // Signal list to refresh
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save doctor: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const navyColor = Color(0xFF16213E);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Doctor'),
        backgroundColor: navyColor,
        foregroundColor: Colors.white,
      ),
      body: _isSaving
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full Name
                    _buildLabel('Full Name'),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Enter full name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Age
                    _buildLabel('Age'),
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Enter age',
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter age';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Qualification
                    _buildLabel('Qualification'),
                    TextFormField(
                      controller: _qualificationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'e.g. MBBS, MD (Cardiology)',
                        prefixIcon: Icon(Icons.school_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter qualification';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Department
                    _buildLabel('Department'),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedDept,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      items: _departments.map((dept) {
                        return DropdownMenuItem<String>(
                          value: dept,
                          child: Text(dept),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedDept = val);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Years of Experience + Status
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Years of Experience'),
                              TextFormField(
                                controller: _yearsOfExpController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  hintText: 'Enter years',
                                  prefixIcon:
                                      Icon(Icons.work_history_outlined),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Required';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Invalid';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Status'),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedStatus,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                ),
                                items: _statuses.map((stat) {
                                  return DropdownMenuItem<String>(
                                    value: stat,
                                    child: Text(stat),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() => _selectedStatus = val);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // About Me
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLabel('About Me'),
                        Text(
                          '$_aboutLength/500',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _aboutController,
                      maxLines: 4,
                      maxLength: 500,
                      buildCounter: (
                        context, {
                        required currentLength,
                        required isFocused,
                        maxLength,
                      }) =>
                          const SizedBox.shrink(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Write about the doctor...',
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please write a brief bio';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Create Doctor Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveDoctor,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: navyColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Create Doctor',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E293B),
        ),
      ),
    );
  }
}
