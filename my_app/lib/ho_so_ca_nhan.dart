import 'package:flutter/material.dart';
import 'services/database_service.dart';

class HoSoCaNhanScreen extends StatefulWidget {
  final String username;
  final String userRole;

  const HoSoCaNhanScreen({
    super.key, 
    required this.username, 
    required this.userRole
  });

  @override
  State<HoSoCaNhanScreen> createState() => _HoSoCaNhanScreenState();
}

class _HoSoCaNhanScreenState extends State<HoSoCaNhanScreen> {
  final DatabaseService _databaseService = DatabaseService();
  late Future<Map<String, dynamic>?> _hosoFuture;
  Map<String, dynamic> _hosoData = {};
  bool _isEditing = false;
  bool _isSaving = false;
  
  // Controllers cho edit mode
  late TextEditingController _tenSVController;
  late TextEditingController _emailController;
  late TextEditingController _sdtController;
  late TextEditingController _diaChiController;
  late TextEditingController _queQuanController;
  late TextEditingController _ngaySinhController;
  late TextEditingController _cmndController;

  @override
  void initState() {
    super.initState();
    _hosoFuture = _databaseService.getHoSoSV(widget.username);
    _initializeControllers();
  }

  void _initializeControllers() {
    _tenSVController = TextEditingController();
    _emailController = TextEditingController();
    _sdtController = TextEditingController();
    _diaChiController = TextEditingController();
    _queQuanController = TextEditingController();
    _ngaySinhController = TextEditingController();
    _cmndController = TextEditingController();
  }

  void _updateControllers() {
    _tenSVController.text = _hosoData['tenSV'] ?? '';
    _emailController.text = _hosoData['email'] ?? '';
    _sdtController.text = _hosoData['sdt'] ?? '';
    _diaChiController.text = _hosoData['diaChi'] ?? '';
    _queQuanController.text = _hosoData['queQuan'] ?? '';
    _ngaySinhController.text = _hosoData['ngaySinh'] ?? '';
    _cmndController.text = _hosoData['cmnd'] ?? '';
  }

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);

    try {
      final updateData = {
        'tenSV': _tenSVController.text,
        'email': _emailController.text,
        'sdt': _sdtController.text,
        'diaChi': _diaChiController.text,
        'queQuan': _queQuanController.text,
        'ngaySinh': _ngaySinhController.text,
        'cmnd': _cmndController.text,
      };

      final success = await _databaseService.updateHoSoSV(
        widget.username,
        updateData,
      );

      if (!mounted) return;

      if (success) {
        _hosoData.addAll(updateData);
        setState(() {
          _isEditing = false;
          _isSaving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Cập nhật hồ sơ thành công'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Cập nhật hồ sơ thất bại'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Lỗi: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _tenSVController.dispose();
    _emailController.dispose();
    _sdtController.dispose();
    _diaChiController.dispose();
    _queQuanController.dispose();
    _ngaySinhController.dispose();
    _cmndController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.amber, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'HỒ SƠ & BẢO MẬT',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.amber),
              onPressed: () {
                if (_hosoData.isNotEmpty) {
                  _updateControllers();
                  setState(() => _isEditing = true);
                }
              },
            ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _hosoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 16),
                  const Text('❌ Lỗi tải dữ liệu'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hosoFuture = _databaseService.getHoSoSV(widget.username);
                      });
                    },
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          _hosoData = snapshot.data ?? {};
          
          if (_hosoData.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_off, color: Colors.grey, size: 50),
                  const SizedBox(height: 16),
                  const Text('⚠️ Không tìm thấy dữ liệu hồ sơ'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hosoFuture = _databaseService.getHoSoSV(widget.username);
                      });
                    },
                    child: const Text('Tải lại'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Thẻ sinh viên số
                _buildStudentCard(_hosoData),
                const SizedBox(height: 25),
                
                if (_isEditing)
                  _buildEditModeButton()
                else
                  _buildViewModeContent(_hosoData),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditModeButton() {
    return Column(
      children: [
        // Mục Thông tin cá nhân
        _buildSectionTitle('Thông tin cá nhân'),
        _buildEditField(Icons.person, 'Họ và tên', _tenSVController),
        _buildEditField(Icons.cake, 'Ngày sinh (DD/MM/YYYY)', _ngaySinhController),
        
        const SizedBox(height: 20),
        
        // Mục Thông tin liên hệ
        _buildSectionTitle('Thông tin liên hệ'),
        _buildEditField(Icons.location_on, 'Quê quán', _queQuanController),
        _buildEditField(Icons.home, 'Địa chỉ', _diaChiController),
        _buildEditField(Icons.email, 'Email', _emailController),
        _buildEditField(Icons.phone, 'SĐT', _sdtController),
        
        const SizedBox(height: 20),
        
        // Mục Giấy tờ tùy thân
        _buildSectionTitle('Giấy tờ tùy thân'),
        _buildEditField(Icons.credit_card, 'CMND/CCCD', _cmndController),
        
        const SizedBox(height: 30),
        
        // Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _isSaving
                    ? null
                    : () {
                        setState(() => _isEditing = false);
                      },
                icon: const Icon(Icons.close),
                label: const Text('HỦY'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _isSaving ? null : _saveProfile,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(_isSaving ? 'Đang lưu...' : 'LƯU'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildViewModeContent(Map<String, dynamic> hoSo) {
    return Column(
      children: [
        // Mục Thông tin cá nhân
        _buildSectionTitle('Thông tin cá nhân'),
        _buildInfoTile(Icons.person, 'Họ và tên', hoSo['tenSV'] ?? 'N/A'),
        _buildInfoTile(Icons.badge, 'Mã số', hoSo['maSV'] ?? 'N/A'),
        _buildInfoTile(Icons.cake, 'Ngày sinh', hoSo['ngaySinh'] ?? 'N/A'),
        _buildInfoTile(Icons.wc, 'Giới tính', hoSo['gioiTinh'] ?? 'N/A'),
        _buildInfoTile(Icons.public, 'Dân tộc', hoSo['danToc'] ?? 'N/A'),
        _buildInfoTile(Icons.location_city, 'Tôn giáo', hoSo['tonGiao'] ?? 'N/A'),
        
        const SizedBox(height: 20),
        
        // Mục Thông tin liên hệ
        _buildSectionTitle('Thông tin liên hệ'),
        _buildInfoTile(Icons.location_on, 'Quê quán', hoSo['queQuan'] ?? 'N/A'),
        _buildInfoTile(Icons.home, 'Địa chỉ', hoSo['diaChi'] ?? 'N/A'),
        _buildInfoTile(Icons.email, 'Email', hoSo['email'] ?? 'N/A'),
        _buildInfoTile(Icons.phone, 'SĐT', hoSo['sdt'] ?? 'N/A'),
        
        const SizedBox(height: 20),
        
        // Mục Giấy tờ tùy thân
        _buildSectionTitle('Giấy tờ tùy thân'),
        _buildInfoTile(Icons.credit_card, 'CMND/CCCD', hoSo['cmnd'] ?? 'N/A'),
        _buildInfoTile(Icons.event, 'Ngày cấp', hoSo['ngayCapCmnd'] ?? 'N/A'),
        
        const SizedBox(height: 20),
        
        // Mục Bảo mật
        _buildSectionTitle('Bảo mật'),
        _buildActionTile(Icons.lock_reset, 'Đổi mật khẩu', () {
          // Logic đổi mật khẩu
        }),
        _buildActionTile(Icons.security, 'Xác thực 2 lớp', null),
        
        const SizedBox(height: 30),
        
        // Nút Đăng xuất
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text('ĐĂNG XUẤT', style: TextStyle(color: Colors.red)),
            style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> hoSo) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue[900]!, Colors.blue[700]!]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Colors.blue),
          ),
          const SizedBox(height: 15),
          Text((hoSo['tenSV'] ?? widget.username).toUpperCase(), 
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('SINH VIÊN K13 - EAUT', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 10),
          Text(
            'Mã SV: ${hoSo['maSV'] ?? widget.username}',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 15),
          // Giả lập mã vạch/QR cho thẻ sinh viên số
          Container(
            height: 50,
            width: 200,
            color: Colors.white.withOpacity(0.9),
            child: const Icon(Icons.qr_code_2, size: 40, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[900]),
      title: Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
    );
  }

  Widget _buildEditField(IconData icon, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        enabled: !_isSaving,
        decoration: InputDecoration(
          hintText: label,
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue[900]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, VoidCallback? onTap) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}