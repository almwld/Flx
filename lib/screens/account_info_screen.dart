import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final _nameController = TextEditingController(text: 'أحمد محمد');
  final _emailController = TextEditingController(text: 'ahmed@example.com');
  final _phoneController = TextEditingController(text: '777123456');
  final _addressController = TextEditingController(text: 'صنعاء، حدة');
  
  String? _selectedCity = 'صنعاء';
  bool _isEditing = false;

  final List<String> _yemenCities = [
    'صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب', 'سيئون',
    'ذمار', 'عمران', 'البيضاء', 'حجة', 'لحج', 'أبين', 'شبوة',
    'مأرب', 'الجوف', 'صعدة', 'حضرموت', 'المهرة', 'سقطرى',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'معلومات الحساب',
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() => _isEditing = !_isEditing);
              if (!_isEditing) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حفظ التغييرات'), backgroundColor: AppTheme.success),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldLight]),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.goldColor, width: 4),
                    ),
                    child: const Icon(Icons.person, size: 60, color: Colors.black),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt, size: 20, color: Colors.black),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField('الاسم الكامل', _nameController, Icons.person, _isEditing),
            const SizedBox(height: 16),
            _buildTextField('البريد الإلكتروني', _emailController, Icons.email, _isEditing),
            const SizedBox(height: 16),
            _buildTextField('رقم الهاتف', _phoneController, Icons.phone, _isEditing),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCity,
              decoration: InputDecoration(
                labelText: 'المدينة',
                prefixIcon: const Icon(Icons.location_city),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: _yemenCities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
              onChanged: _isEditing ? (value) => setState(() => _selectedCity = value) : null,
            ),
            const SizedBox(height: 16),
            _buildTextField('العنوان التفصيلي', _addressController, Icons.location_on, _isEditing, maxLines: 2),
            const SizedBox(height: 24),
            if (_isEditing)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.lock_outline),
                  label: const Text('تغيير كلمة المرور'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.goldColor,
                    side: const BorderSide(color: AppTheme.goldColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, bool enabled, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: !enabled,
      ),
    );
  }
}
