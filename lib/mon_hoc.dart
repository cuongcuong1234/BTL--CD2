import 'package:flutter/material.dart';

class MonHocScreen extends StatefulWidget {
  const MonHocScreen({super.key});

  @override
  State<MonHocScreen> createState() => _MonHocScreenState();
}

class _MonHocScreenState extends State<MonHocScreen> {
  // Chuyển danh sách sang biến state để có thể thay đổi dữ liệu
  List<Map<String, String>> danhSachMonHoc = [
    {'maMH': 'IT101', 'tenMH': 'Lập trình Flutter', 'tinChi': '3'},
    {'maMH': 'IT102', 'tenMH': 'Cấu trúc dữ liệu', 'tinChi': '4'},
    {'maMH': 'IT103', 'tenMH': 'Cơ sở dữ liệu', 'tinChi': '3'},
    {'maMH': 'IT104', 'tenMH': 'Mạng máy tính', 'tinChi': '3'},
    {'maMH': 'IT105', 'tenMH': 'Thiết kế hệ thống', 'tinChi': '3'},
  ];

  // Hàm hiển thị Dialog để Thêm hoặc Sửa
  void _showForm(int? index) {
    final tenMHController = TextEditingController();
    final maMHController = TextEditingController();
    final tinChiController = TextEditingController();

    if (index != null) {
      tenMHController.text = danhSachMonHoc[index]['tenMH']!;
      maMHController.text = danhSachMonHoc[index]['maMH']!;
      tinChiController.text = danhSachMonHoc[index]['tinChi']!;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Thêm Môn Học' : 'Sửa Môn Học'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: maMHController, decoration: const InputDecoration(labelText: 'Mã môn')),
            TextField(controller: tenMHController, decoration: const InputDecoration(labelText: 'Tên môn')),
            TextField(controller: tinChiController, decoration: const InputDecoration(labelText: 'Số tín chỉ'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final newMH = {
                  'maMH': maMHController.text,
                  'tenMH': tenMHController.text,
                  'tinChi': tinChiController.text,
                };
                if (index == null) {
                  danhSachMonHoc.add(newMH);
                } else {
                  danhSachMonHoc[index] = newMH;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  // Hàm xóa môn học
  void _deleteMonHoc(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc muốn xóa môn ${danhSachMonHoc[index]['tenMH']}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Không')),
          TextButton(
            onPressed: () {
              setState(() => danhSachMonHoc.removeAt(index));
              Navigator.pop(context);
            }, 
            child: const Text('Xóa', style: TextStyle(color: Colors.red))
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Đồng bộ màu header
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber[400], size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('QUẢN LÝ MÔN HỌC', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: danhSachMonHoc.length,
        itemBuilder: (context, index) {
          final mon = danhSachMonHoc[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[900],
                child: Text(mon['tinChi']!, style: const TextStyle(color: Colors.white)),
              ),
              title: Text(mon['tenMH']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Mã môn: ${mon['maMH']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showForm(index)),
                  IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteMonHoc(index)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () => _showForm(null), // Mở form thêm mới
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}