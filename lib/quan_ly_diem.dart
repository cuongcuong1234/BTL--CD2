import 'package:flutter/material.dart';
import 'services/database_service.dart';

class QuanLyDiemScreen extends StatefulWidget {
  const QuanLyDiemScreen({super.key});

  @override
  State<QuanLyDiemScreen> createState() => _QuanLyDiemScreenState();
}

class _QuanLyDiemScreenState extends State<QuanLyDiemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _maSVController = TextEditingController();
  final _monController = TextEditingController();
  final _diemController = TextEditingController();
  final _hocKyController = TextEditingController(text: 'HK1-2026');
  final _namHocController = TextEditingController(text: '2025-2026');

  @override
  void dispose() {
    _maSVController.dispose();
    _monController.dispose();
    _diemController.dispose();
    _hocKyController.dispose();
    _namHocController.dispose();
    super.dispose();
  }

  Future<void> _themDiem() async {
    if (_formKey.currentState!.validate()) {
      final success = await DatabaseService().addDiem(
        maSV: _maSVController.text,
        mon: _monController.text,
        diem: double.parse(_diemController.text),
        hocKy: _hocKyController.text,
        namHoc: _namHocController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Thêm điểm thành công')),
        );
        _maSVController.clear();
        _monController.clear();
        _diemController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Thêm điểm thất bại')),
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
          'QUẢN LÝ ĐIỂM',
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
                'Thêm điểm mới',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _maSVController,
                decoration: const InputDecoration(
                  labelText: 'Mã sinh viên',
                  prefixIcon: Icon(Icons.person),
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
              TextFormField(
                controller: _monController,
                decoration: const InputDecoration(
                  labelText: 'Môn học',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập môn học';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _diemController,
                decoration: const InputDecoration(
                  labelText: 'Điểm (0.0 - 10.0)',
                  prefixIcon: Icon(Icons.grade),
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập điểm';
                  }
                  final diem = double.tryParse(value);
                  if (diem == null || diem < 0 || diem > 10) {
                    return 'Điểm phải từ 0.0 đến 10.0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hocKyController,
                decoration: const InputDecoration(
                  labelText: 'Học kỳ',
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _namHocController,
                decoration: const InputDecoration(
                  labelText: 'Năm học',
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
                  onPressed: _themDiem,
                  child: const Text(
                    'Thêm điểm',
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
                'Danh sách điểm',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: DatabaseService().getAllDiem(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final diemList = snapshot.data ?? [];
                  if (diemList.isEmpty) {
                    return const Center(
                      child: Text('Chưa có điểm nào'),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: diemList.length,
                    itemBuilder: (context, index) {
                      final diem = diemList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text('${diem['mon'] ?? 'N/A'}'),
                          subtitle: Text(
                            'Sinh viên: ${diem['maSV']} | Điểm: ${diem['diem']}',
                          ),
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
}
