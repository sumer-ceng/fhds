import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  String? _selectedPatient;
  double _severityLevel = 1.0;

  final List<String> _patients = [
    'Ahmet Yılmaz - Bel Fıtığı',
    'Zeynep Kaya - Omuz Sıkışması',
    'Mehmet Öz - Diz Protezi',
    'Ayşe Demir - Boyun Düzleşmesi',
  ];

  // Dummy logic to determine physiotherapists based on severity
  List<Map<String, dynamic>> _getAvailablePhysiotherapists(int severity) {
    if (severity <= 5) {
      return [
        {'name': 'Fzt. Elif Şahin', 'specialty': 'Genel Fizyoterapi', 'status': 'Müsait'},
        {'name': 'Fzt. Burak Yılmaz', 'specialty': 'Genel Fizyoterapi', 'status': 'Müsait'},
      ];
    } else if (severity <= 10) {
      return [
        {'name': 'Fzt. Ayşe Demir', 'specialty': 'Ortopedik Rehabilitasyon', 'status': 'Müsait'},
        {'name': 'Fzt. Caner Taş', 'specialty': 'Sporcu Sağlığı', 'status': 'Meşgul (10 dk)'},
      ];
    } else {
      return [
        {'name': 'Uzm. Fzt. Kemal Can', 'specialty': 'Nörolojik & İleri Vaka', 'status': 'Müsait'},
        {'name': 'Uzm. Fzt. Deniz Arslan', 'specialty': 'İleri Ortopedi', 'status': 'Müsait'},
      ];
    }
  }

  void _assignPhysio(String physioName) {
    if (_selectedPatient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen önce bir hasta seçin.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$_selectedPatient, başarıyla $physioName isimli uzmana atandı!'),
        backgroundColor: AppColors.medicalGreen,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final int currentSeverity = _severityLevel.toInt();
    final physios = _getAvailablePhysiotherapists(currentSeverity);

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: AppColors.bgCard,
        elevation: 0,
        title: const Text(
          'Hasta Dağıtım (Triage)',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '1. Hasta Seçimi',
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text('Bekleyen hastalardan birini seçin...'),
                    value: _selectedPatient,
                    icon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryMid),
                    dropdownColor: AppColors.bgCard,
                    items: _patients.map((String patient) {
                      return DropdownMenuItem<String>(
                        value: patient,
                        child: Text(patient, style: const TextStyle(color: AppColors.textPrimary)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPatient = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                '2. Hastalık Derecesi (1-16)',
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'Hastanın durumuna göre zorluk derecesini belirleyin. (1: Hafif, 16: Kritik/Uzmanlık Gerektirir)',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              
              // Custom Slider Display
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryMid.withOpacity(0.1),
                    border: Border.all(color: AppColors.primaryMid, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      currentSeverity.toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryMid,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.primaryMid,
                  inactiveTrackColor: AppColors.borderSubtle,
                  thumbColor: AppColors.primaryAccent,
                  valueIndicatorColor: AppColors.primaryMid,
                  trackHeight: 8,
                ),
                child: Slider(
                  value: _severityLevel,
                  min: 1,
                  max: 16,
                  divisions: 15,
                  label: currentSeverity.toString(),
                  onChanged: (value) {
                    setState(() {
                      _severityLevel = value;
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1 (Hafif)', style: AppTextStyles.labelMedium),
                    Text('16 (Ağır)', style: AppTextStyles.labelMedium),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),

              const Text(
                '3. Uygun Fizyoterapistler',
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Derece $currentSeverity için önerilen personeller:',
                style: const TextStyle(color: AppColors.textHint, fontSize: 13),
              ),
              const SizedBox(height: 16),

              // Physiotherapists List
              ...physios.map((physio) => _buildPhysioCard(
                name: physio['name'],
                specialty: physio['specialty'],
                status: physio['status'],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhysioCard({
    required String name,
    required String specialty,
    required String status,
  }) {
    bool isAvailable = status == 'Müsait';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: AppColors.borderSubtle.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryLight.withOpacity(0.2),
            child: const Icon(Icons.person, color: AppColors.primaryMid),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isAvailable ? AppColors.medicalGreen : Colors.orange,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: isAvailable ? () => _assignPhysio(name) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMid,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Ata'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
