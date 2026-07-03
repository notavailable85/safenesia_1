import 'package:flutter/material.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_article_list_page.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_career_list_page.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_certification_list_page.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_notification_list_page.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_regulation_list_page.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_schedule_list_page.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_training_list_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildDashboardCard(
            context,
            title: 'Articles',
            icon: Icons.article,
            color: Colors.blue,
            page: const AdminArticleListPage(),
          ),
          _buildDashboardCard(
            context,
            title: 'Trainings',
            icon: Icons.school,
            color: Colors.green,
            page: const AdminTrainingListPage(),
          ),
          _buildDashboardCard(
            context,
            title: 'Schedules',
            icon: Icons.schedule,
            color: Colors.orange,
            page: const AdminScheduleListPage(),
          ),
          _buildDashboardCard(
            context,
            title: 'Certifications',
            icon: Icons.workspace_premium,
            color: Colors.purple,
            page: const AdminCertificationListPage(),
          ),
          _buildDashboardCard(
            context,
            title: 'Careers',
            icon: Icons.work,
            color: Colors.brown,
            page: const AdminCareerListPage(),
          ),
          _buildDashboardCard(
            context,
            title: 'Notifications',
            icon: Icons.notifications,
            color: Colors.red,
            page: const AdminNotificationListPage(),
          ),
          _buildDashboardCard(
            context,
            title: 'Regulations',
            icon: Icons.gavel,
            color: Colors.teal,
            page: const AdminRegulationListPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget page,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.5), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
