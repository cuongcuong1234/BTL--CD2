import 'package:flutter/material.dart';
import 'services/database_service.dart';

class QuanLyLichHocScreen extends StatefulWidget {
  const QuanLyLichHocScreen({super.key});

  @override
  State<QuanLyLichHocScreen> createState() => _QuanLyLichHocScreenState();
}

class _QuanLyLichHocScreenState extends State<QuanLyLichHocScreen> {
  final _formKey = GlobalKey<FormState>();
  final _maSVController = TextEditingController();
  final _thuController = TextEditingController();
  final _thuTuController = TextEditingController();
  final _monController = TextEditingController();
  final _phongController = TextEditingController();
  final _gioController = TextEditingController();
  final _giangVienController = TextEditingController();

  @override
  void dispose() {
    _maSVController.dispose();
    _thuController.dispose();
    _thuTuController.dispose();
    _monController.dispose();
    _phongController.dispose();
    _gioController.dispose();
    _giangVienController.dispose();
    super.dispose();
  }

  Future<void> _themLichHoc() async {
    if (_formKey.currentState!.validate()) {
      final success = await DatabaseService().addLichHoc(
        maSV: _maSVController.text,
        thu: _thuController.text,
        ordinal: int.parse(_thuTuController.text),
        mon: _monController.text,
        phong: _phongController.text,
        gio: _gioController.text,
        giangVien: _giangVienController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Thêm lịch học thành công')),
        );
        _formKey.currentState!.reset();
        _maSVController.clear();
        _thuController.clear();
        _thuTuController.clear();
        _monController.clear();
        _phongController.clear();
        _gioController.clear();
        _giangVienController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Thêm lịch học thất bại')),
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
          'QUẢN LÝ LỊCH HỌC',
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
                'Thêm lịch học mới',
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
                controller: _thuController,
                decoration: const InputDecoration(
                  labelText: 'Thứ (Thứ 2, Thứ 3,...)',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập thứ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _thuTuController,
                decoration: const InputDecoration(
                  labelText: 'Thứ tự (1-7)',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập thứ tự';
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
                controller: _phongController,
                decoration: const InputDecoration(
                  labelText: 'Phòng học',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập phòng học';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _gioController,
                decoration: const InputDecoration(
                  labelText: 'Giờ học (VD: 07:30 - 09:30)',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập giờ học';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _giangVienController,
                decoration: const InputDecoration(
                  labelText: 'Giảng viên',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên giảng viên';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _themLichHoc,
                  child: const Text(
                    'Thêm lịch học',
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
                'Danh sách lịch học',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: DatabaseService().getAllLichHoc(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final lichHocList = snapshot.data ?? [];
                  if (lichHocList.isEmpty) {
                    return const Center(
                      child: Text('Chưa có lịch học nào'),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lichHocList.length,
                    itemBuilder: (context, index) {
                      final lichHoc = lichHocList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text('${lichHoc['mon'] ?? 'N/A'}'),
                          subtitle: Text(
                            '${lichHoc['maSV']} - ${lichHoc['thu']} (${lichHoc['gio']})',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              DatabaseService().deleteLichHoc(lichHoc['id']);
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('✅ Đã xóa lịch học'),
                                ),
                              );
                            },
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
