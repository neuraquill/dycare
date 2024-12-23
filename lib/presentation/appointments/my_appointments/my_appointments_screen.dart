import 'package:dycare/core/utils/date_time_utils.dart';
import 'package:dycare/routes/app_pages.dart';
import 'package:dycare/theme/app_colors.dart';
import 'package:dycare/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/presentation/appointments/my_appointments/controller/my_appointments_controller.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:shimmer/shimmer.dart';

class MyAppointmentsScreen extends StatefulWidget {
  @override
  _MyAppointmentsScreenState createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  final MyAppointmentsController controller = Get.find<MyAppointmentsController>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          controller.setSelectedStatus("Upcoming");
          break;
        case 1:
          controller.setSelectedStatus("Completed");
          break;
        case 2:
          controller.setSelectedStatus("History");
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.offNamed(Routes.HOME),
        ),
        title: Text(
          'My Appointments',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryDark
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusFilterTabs(),
          const SizedBox(height: 16),
          Expanded(child: _buildAppointmentTabView()),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildStatusFilterTabs() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.primary,
      unselectedLabelColor: AppColors.textSecondary,
      labelColor: AppColors.white,
      tabs: [
        _buildStatusTab("Upcoming"),
        _buildStatusTab("Completed"),
        _buildStatusTab("History"),
      ],
    );
  }

  Widget _buildStatusTab(String status) {
    return Tab(
      child: Text(
        status,
        style: AppTypography.bodyMedium.copyWith(
          color: _tabController.index == ["Upcoming", "Completed", "History"].indexOf(status)
              ? AppColors.textSecondary
              : AppColors.textSecondary,
        ),
      ),
    );
  }


  Widget _buildAppointmentTabView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildAppointmentList("upcoming"),
        _buildAppointmentList("completed"),
        _buildAppointmentList("history of"),
      ],
    );
  }

  Widget _buildAppointmentList(String status) {
    return Obx(() {
      final filteredAppointments = controller.getFilteredAppointments(status) ?? [];
      if (controller.isLoading.value) {
        return Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: CircularProgressIndicator(
              key: ValueKey('loading_indicator'),
            ),
          ),
        );
      } else if (filteredAppointments.isEmpty) {
        return Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              'No $status appointments found',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
              key: ValueKey('no_appointments_text'),
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: ListView.builder(
              key: ValueKey('appointment_list_$status'),
              itemCount: filteredAppointments.length,
              itemBuilder: (context, index) {
                return _buildAppointmentCard(filteredAppointments[index]);
              },
            ),
          ),
        );
      }
    });
  }


  Widget _buildProfileImage(AppointmentEntity appointment) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        'https://via.placeholder.com/48',
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 48,
            height: 48,
            color: AppColors.background,
            child: Icon(Icons.error, color: AppColors.textSecondary),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentCard(AppointmentEntity appointment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        color: AppColors.white, // Explicit background color
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Relative padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: _buildProfileImage(appointment),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  Expanded(
                    child: _buildAppointmentDetails(appointment),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      DateTimeUtils.formatTime(appointment.time),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: _buildViewButton(appointment),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildAppointmentDetails(AppointmentEntity appointment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${controller.getNurseName(appointment.workerId)}',
          style: AppTypography.bodyMedium.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.035, // Smaller relative font size
            fontWeight: FontWeight.w600, // Optional for better emphasis
          ),
        ),
      ],
    );
  }

  Widget _buildViewButton(AppointmentEntity appointment) {
    return OutlinedButton(
      onPressed: () => Get.toNamed(Routes.APPOINTMENT_DETAILS, arguments: appointment.id),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary),
      ),
      child: const Text("View"),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.inputBorder, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.white,
        currentIndex: 2, // Set the Appointments tab as active
        onTap: (index) {
          switch (index) {
            case 0:
              Get.offNamed(Routes.HOME);
              break;
            case 1:
              Get.toNamed(Routes.SEARCH);
              break;
            case 2:
              Get.offNamed(Routes.MY_APPOINTMENTS);
              break;
            case 3:
              Get.toNamed(Routes.VIEW_PROFILE);
              break;
            default:
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
