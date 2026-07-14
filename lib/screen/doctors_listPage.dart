import 'package:doctor_directory_app/model/WorkExperienceItem.dart';
import 'package:doctor_directory_app/provider/doctor_provider.dart';
import 'package:doctor_directory_app/screen/add_doctor_screen.dart';
import 'package:doctor_directory_app/screen/doctor_detailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  static const Color primaryBlue = Color(0xFF0A2558);

  int _selectedCategoryIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> categories = [
    'All',
    'Cardiology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'Dental',
    'General Medicine',
    'Dermatology',
  ];

  static const Map<String, IconData> _categoryIcons = {
    'Cardiology': Icons.favorite,
    'Neurology': Icons.psychology,
    'Orthopedics': Icons.accessibility_new,
    'Pediatrics': Icons.child_care,
    'Dental': Icons.medical_services,
    'General Medicine': Icons.local_hospital,
    'Dermatology': Icons.spa,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorProvider>().fetchDoctors();
    });
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Doctor> _getFilteredDoctors(List<Doctor> allDoctors) {
    List<Doctor> filtered = allDoctors;

    // Category filter
    if (_selectedCategoryIndex != 0) {
      final selectedCat = categories[_selectedCategoryIndex];
      filtered = filtered
          .where((d) =>
              d.department.toLowerCase() == selectedCat.toLowerCase())
          .toList();
    }

    // Search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((d) =>
              d.fullName.toLowerCase().contains(_searchQuery) ||
              d.department.toLowerCase().contains(_searchQuery) ||
              d.qualification.toLowerCase().contains(_searchQuery))
          .toList();
    }

    return filtered;
  }

  /// Groups filtered doctors by department
  Map<String, List<Doctor>> _groupByDepartment(List<Doctor> doctors) {
    final Map<String, List<Doctor>> grouped = {};
    for (final doc in doctors) {
      grouped.putIfAbsent(doc.department, () => []).add(doc);
    }
    return grouped;
  }

  Future<void> _openAddDoctor() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddDoctorScreen()),
    );
    if (result == true && mounted) {
      context.read<DoctorProvider>().fetchDoctors();
    }
  }

  void _navigateToDetail(Doctor doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DoctorDetailsScreen(doctor: doctor),
      ),
    ).then((_) {
      // Refresh list in case doctor was deleted from detail page
      if (mounted) {
        context.read<DoctorProvider>().fetchDoctors();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        title: const Text(
          'Doctors',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<DoctorProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    'Failed to load doctors',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => provider.fetchDoctors(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final filtered = _getFilteredDoctors(provider.doctors);
          final grouped = _groupByDepartment(filtered);

          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search doctor by name...',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear,
                                  color: Colors.grey, size: 18),
                              onPressed: () => _searchController.clear(),
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),

              // Category Chips
              SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategoryIndex == index;
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                          categories[index],
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: primaryBlue,
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey.shade200,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Doctor List
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search_off,
                                size: 60, color: Colors.grey.shade300),
                            const SizedBox(height: 12),
                            Text(
                              'No doctors found',
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                        itemCount: grouped.keys.length,
                        itemBuilder: (context, catIndex) {
                          final deptName =
                              grouped.keys.elementAt(catIndex);
                          final deptDoctors = grouped[deptName]!;
                          return _DepartmentSection(
                            departmentName: deptName,
                            icon: _categoryIcons[deptName] ??
                                Icons.medical_services,
                            doctors: deptDoctors,
                            onDoctorTap: _navigateToDetail,
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddDoctor,
        backgroundColor: primaryBlue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}

// ─── Department Section ────────────────────────────────────────────────────────

class _DepartmentSection extends StatefulWidget {
  final String departmentName;
  final IconData icon;
  final List<Doctor> doctors;
  final void Function(Doctor) onDoctorTap;

  const _DepartmentSection({
    required this.departmentName,
    required this.icon,
    required this.doctors,
    required this.onDoctorTap,
  });

  @override
  State<_DepartmentSection> createState() => _DepartmentSectionState();
}

class _DepartmentSectionState extends State<_DepartmentSection> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0A2558);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Department Header
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              children: [
                Icon(widget.icon, color: primaryBlue, size: 20),
                const SizedBox(width: 8),
                Text(
                  widget.departmentName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
                const Spacer(),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: primaryBlue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Doctor Cards
          if (_expanded)
            ...widget.doctors.map(
              (doctor) => _DoctorCard(
                doctor: doctor,
                onTap: () => widget.onDoctorTap(doctor),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Doctor Card ──────────────────────────────────────────────────────────────

class _DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  const _DoctorCard({required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0A2558);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: primaryBlue,
            child: Text(
              doctor.initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          title: Text(
            doctor.fullName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            doctor.qualification,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StatusBadge(status: doctor.status),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Status Badge ─────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Active':
        bgColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF2E7D32);
        break;
      case 'Busy':
        bgColor = const Color(0xFFFFF3E0);
        textColor = const Color(0xFFE65100);
        break;
      default:
        bgColor = const Color(0xFFEEEEEE);
        textColor = const Color(0xFF616161);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}