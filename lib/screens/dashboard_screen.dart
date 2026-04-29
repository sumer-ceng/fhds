import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'assignment_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: AppColors.bgCard,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'logo/logo.png',
              height: 32,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.medical_services,
                color: AppColors.primaryMid,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'FHDS',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textSecondary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: AppColors.primaryMid, size: 28),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Text
              const Text(
                'Hoş Geldiniz, Dr. Yılmaz',
                style: AppTextStyles.displayMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'Bugünkü hasta dağıtım ve tedavi özetiniz.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Bekleyen\nHastalar',
                      value: '12',
                      icon: Icons.people_outline,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Aktif\nSeanslar',
                      value: '8',
                      icon: Icons.healing,
                      color: AppColors.medicalGreenLight,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Müsait\nFizyoterapist',
                      value: '4',
                      icon: Icons.assignment_ind_outlined,
                      color: AppColors.primaryAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Quick Actions
              const Text(
                'Hızlı İşlemler',
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAction(
                    icon: Icons.person_add_alt_1_outlined,
                    label: 'Hasta Kayıt',
                    onTap: () {},
                  ),
                  _buildQuickAction(
                    icon: Icons.calendar_month_outlined,
                    label: 'Randevu',
                    onTap: () {},
                  ),
                  _buildQuickAction(
                    icon: Icons.transfer_within_a_station,
                    label: 'Dağıtım',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AssignmentScreen()),
                      );
                    },
                  ),
                  _buildQuickAction(
                    icon: Icons.bar_chart,
                    label: 'Raporlar',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Current Assignments / Queue
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Aktif Hasta Dağıtımı',
                    style: AppTextStyles.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Tümünü Gör', style: TextStyle(color: AppColors.primaryMid)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildPatientListItem(
                name: 'Ahmet Yılmaz',
                treatment: 'Bel Fıtığı Rehabilitasyonu',
                physio: 'Fzt. Ayşe Demir',
                room: 'Oda 3',
                status: 'Seans Başladı',
                statusColor: AppColors.medicalGreen,
              ),
              _buildPatientListItem(
                name: 'Zeynep Kaya',
                treatment: 'Omuz Sıkışma Sendromu',
                physio: 'Bekliyor',
                room: 'Bekleme Salonu',
                status: 'Sırada',
                statusColor: Colors.orange,
              ),
              _buildPatientListItem(
                name: 'Mehmet Öz',
                treatment: 'Diz Protezi Sonrası',
                physio: 'Fzt. Kemal Can',
                room: 'Oda 1',
                status: 'Seans Bitti',
                statusColor: AppColors.textHint,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: AppColors.bgCard,
        selectedItemColor: AppColors.primaryMid,
        unselectedItemColor: AppColors.textHint,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Panel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Hastalar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Randevular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.borderSubtle,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.borderSubtle,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.primaryMid, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientListItem({
    required String name,
    required String treatment,
    required String physio,
    required String room,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.bgDark,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name.substring(0, 1),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryMid,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  treatment,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(
                      physio,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textHint,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.meeting_room, size: 14, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(
                      room,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
