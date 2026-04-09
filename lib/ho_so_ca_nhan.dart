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
  late Future<Map<String, dynamic>?> _hosoFuture;

  @override
  void initState() {
    super.initState();
    _hosoFuture = DatabaseService().getHoSoSV(widget.username);
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
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _hosoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final hoSo = snapshot.data ?? {};
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Thẻ sinh viên số
                _buildStudentCard(hoSo),
                const SizedBox(height: 25),
                
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> hoSo) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue[900]!, Colors.blue[700]!]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
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
            'Mã SV: ${hoSo['maSV'] ?? 'N/A'}',
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