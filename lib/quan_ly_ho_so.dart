import 'package:flutter/material.dart';
import 'services/database_service.dart';

class QuanLyHoSoScreen extends StatefulWidget {
  const QuanLyHoSoScreen({super.key});

  @override
  State<QuanLyHoSoScreen> createState() => _QuanLyHoSoScreenState();
}

class _QuanLyHoSoScreenState extends State<QuanLyHoSoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _maSVController = TextEditingController();
  final _tenSVController = TextEditingController();
  final _ngaySinhController = TextEditingController();
  final _gioiTinhController = TextEditingController();
  final _queQuanController = TextEditingController();
  final _sdtController = TextEditingController();
  final _emailController = TextEditingController();
  final _diaChiController = TextEditingController();
  final _danTocController = TextEditingController();
  final _tonGiaoController = TextEditingController();
  final _cmndController = TextEditingController();
  final _ngayCapCmndController = TextEditingController();

  @override
  void dispose() {
    _maSVController.dispose();
    _tenSVController.dispose();
    _ngaySinhController.dispose();
    _gioiTinhController.dispose();
    _queQuanController.dispose();
    _sdtController.dispose();
    _emailController.dispose();
    _diaChiController.dispose();
    _danTocController.dispose();
    _tonGiaoController.dispose();
    _cmndController.dispose();
    _ngayCapCmndController.dispose();
    super.dispose();
  }

  Future<void> _themHoSo() async {
    if (_formKey.currentState!.validate()) {
      final success = await DatabaseService().addOrUpdateHoSo(
        maSV: _maSVController.text,
        tenSV: _tenSVController.text,
        ngaySinh: _ngaySinhController.text.isEmpty ? null : _ngaySinhController.text,
        gioiTinh: _gioiTinhController.text.isEmpty ? null : _gioiTinhController.text,
        queQuan: _queQuanController.text.isEmpty ? null : _queQuanController.text,
        sdt: _sdtController.text.isEmpty ? null : _sdtController.text,
        email: _emailController.text.isEmpty ? null : _emailController.text,
        diaChi: _diaChiController.text.isEmpty ? null : _diaChiController.text,
        danToc: _danTocController.text.isEmpty ? null : _danTocController.text,
        tonGiao: _tonGiaoController.text.isEmpty ? null : _tonGiaoController.text,
        cmnd: _cmndController.text.isEmpty ? null : _cmndController.text,
        ngayCapCmnd: _ngayCapCmndController.text.isEmpty ? null : _ngayCapCmndController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Đã lưu hồ sơ thành công')),
        );
        setState(() {});
        _maSVController.clear();
        _tenSVController.clear();
        _ngaySinhController.clear();
        _gioiTinhController.clear();
        _queQuanController.clear();
        _sdtController.clear();
        _emailController.clear();
        _diaChiController.clear();
        _danTocController.clear();
        _tonGiaoController.clear();
        _cmndController.clear();
        _ngayCapCmndController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Lưu hồ sơ thất bại')),
        );
      }
    }
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
          'QUẢN LÝ HỒ SƠ SINH VIÊN',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thêm/Cập nhật hồ sơ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              // Mã sinh viên
              TextFormField(
                controller: _maSVController,
                decoration: const InputDecoration(
                  labelText: 'Mã sinh viên *',
                  prefixIcon: Icon(Icons.person_pin),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã sinh viên';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Tên sinh viên
              TextFormField(
                controller: _tenSVController,
                decoration: const InputDecoration(
                  labelText: 'Họ và tên *',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên sinh viên';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Ngày sinh
              TextFormField(
                controller: _ngaySinhController,
                decoration: const InputDecoration(
                  labelText: 'Ngày sinh (DD/MM/YYYY)',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Giới tính
              TextFormField(
                controller: _gioiTinhController,
                decoration: const InputDecoration(
                  labelText: 'Giới tính (Nam/Nữ)',
                  prefixIcon: Icon(Icons.wc),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Quê quán
              TextFormField(
                controller: _queQuanController,
                decoration: const InputDecoration(
                  labelText: 'Quê quán',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Số điện thoại
              TextFormField(
                controller: _sdtController,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Địa chỉ
              TextFormField(
                controller: _diaChiController,
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ',
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Dân tộc
              TextFormField(
                controller: _danTocController,
                decoration: const InputDecoration(
                  labelText: 'Dân tộc',
                  prefixIcon: Icon(Icons.group),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Tôn giáo
              TextFormField(
                controller: _tonGiaoController,
                decoration: const InputDecoration(
                  labelText: 'Tôn giáo',
                  prefixIcon: Icon(Icons.church),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // CMND
              TextFormField(
                controller: _cmndController,
                decoration: const InputDecoration(
                  labelText: 'Số CMND/CCCD',
                  prefixIcon: Icon(Icons.card_membership),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Ngày cấp CMND
              TextFormField(
                controller: _ngayCapCmndController,
                decoration: const InputDecoration(
                  labelText: 'Ngày cấp CMND (DD/MM/YYYY)',
                  prefixIcon: Icon(Icons.date_range),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _themHoSo,
                  child: const Text(
                    'Lưu hồ sơ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'Danh sách hồ sơ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              FutureBuilder<List<Map<String, dynamic>>>(
                future: DatabaseService().getAllHoSo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final hoSoList = snapshot.data ?? [];
                  if (hoSoList.isEmpty) {
                    return const Center(child: Text('Chưa có hồ sơ nào'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: hoSoList.length,
                    itemBuilder: (context, index) {
                      final hoSo = hoSoList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ExpansionTile(
                          title: Text('${hoSo['tenSV'] ?? 'N/A'} (${hoSo['maSV']})'),
                          subtitle: Text('${hoSo['email'] ?? 'Chưa có email'}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              DatabaseService().deleteHoSo(hoSo['maSV']);
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('✅ Đã xóa hồ sơ')),
                              );
                            },
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow('🎂 Ngày sinh', hoSo['ngaySinh'] ?? 'N/A'),
                                  _buildInfoRow('👤 Giới tính', hoSo['gioiTinh'] ?? 'N/A'),
                                  _buildInfoRow('📍 Quê quán', hoSo['queQuan'] ?? 'N/A'),
                                  _buildInfoRow('📞 SĐT', hoSo['sdt'] ?? 'N/A'),
                                  _buildInfoRow('📧 Email', hoSo['email'] ?? 'N/A'),
                                  _buildInfoRow('🏠 Địa chỉ', hoSo['diaChi'] ?? 'N/A'),
                                  _buildInfoRow('👥 Dân tộc', hoSo['danToc'] ?? 'N/A'),
                                  _buildInfoRow('🙏 Tôn giáo', hoSo['tonGiao'] ?? 'N/A'),
                                  _buildInfoRow('🆔 CMND/CCCD', hoSo['cmnd'] ?? 'N/A'),
                                  _buildInfoRow('📅 Ngày cấp', hoSo['ngayCapCmnd'] ?? 'N/A'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
