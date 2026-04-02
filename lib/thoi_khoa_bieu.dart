import 'package:flutter/material.dart';

class ThoiKhoaBieuScreen extends StatefulWidget {
  const ThoiKhoaBieuScreen({super.key});

  @override
  State<ThoiKhoaBieuScreen> createState() => _ThoiKhoaBieuScreenState();
}

class _ThoiKhoaBieuScreenState extends State<ThoiKhoaBieuScreen> {
  // 1. Danh sách dữ liệu (Dùng để hiển thị và thao tác)
  List<Map<String, String>> lichDay = [
    {
      'thu': 'Thứ 2',
      'mon': 'Lập trình Flutter',
      'lop': 'DCCNTT13.10.21',
      'phong': 'P.402',
      'gio': '07:30 - 09:30',
      'siSo': '45'
    },
    {
      'thu': 'Thứ 3',
      'mon': 'Cấu trúc dữ liệu',
      'lop': 'DCCNPT13.10.10',
      'phong': 'Lab 01',
      'gio': '13:30 - 15:30',
      'siSo': '38'
    },
    {
      'thu': 'Thứ 4',
      'mon': 'Cấu trúc dữ liệu',
      'lop': 'DCCNPT13.10.10',
      'phong': 'Lab 01',
      'gio': '13:30 - 15:30',
      'siSo': '38'
    },
    {
      'thu': 'Thứ 5',
      'mon': 'Cấu trúc dữ liệu',
      'lop': 'DCCNPT13.10.10',
      'phong': 'Lab 01',
      'gio': '13:30 - 15:30',
      'siSo': '38'
    },
    {
      'thu': 'Thứ 6',
      'mon': 'Cấu trúc dữ liệu',
      'lop': 'DCCNPT13.10.10',
      'phong': 'Lab 01',
      'gio': '13:30 - 15:30',
      'siSo': '38'
    },
  ];

  // 2. Hàm hiển thị Form (Thêm/Sửa)
  void _showForm(int? index) {
    final monController = TextEditingController(text: index != null ? lichDay[index]['mon'] : '');
    final lopController = TextEditingController(text: index != null ? lichDay[index]['lop'] : '');
    final phongController = TextEditingController(text: index != null ? lichDay[index]['phong'] : '');
    final gioController = TextEditingController(text: index != null ? lichDay[index]['gio'] : '');
    final siSoController = TextEditingController(text: index != null ? lichDay[index]['siSo'] : '');
    String selectedThu = index != null ? lichDay[index]['thu']! : 'Thứ 2';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Thêm Tiết Dạy' : 'Sửa Tiết Dạy'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedThu,
                items: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7']
                    .map((thu) => DropdownMenuItem(value: thu, child: Text(thu))).toList(),
                onChanged: (val) => selectedThu = val!,
                decoration: const InputDecoration(labelText: 'Thứ'),
              ),
              TextField(controller: monController, decoration: const InputDecoration(labelText: 'Môn học')),
              TextField(controller: lopController, decoration: const InputDecoration(labelText: 'Lớp')),
              TextField(controller: phongController, decoration: const InputDecoration(labelText: 'Phòng')),
              TextField(controller: gioController, decoration: const InputDecoration(labelText: 'Giờ học')),
              TextField(controller: siSoController, decoration: const InputDecoration(labelText: 'Sĩ số'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final data = {
                  'thu': selectedThu,
                  'mon': monController.text,
                  'lop': lopController.text,
                  'phong': phongController.text,
                  'gio': gioController.text,
                  'siSo': siSoController.text,
                };
                if (index == null) lichDay.add(data);
                else lichDay[index] = data;
              });
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber[400], size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'THỜI KHÓA BIỂU GIÁO VIÊN',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: lichDay.length,
        itemBuilder: (context, index) {
          final tiet = lichDay[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Khối hiển thị Thứ (Giữ nguyên giao diện của bạn)
                  Container(
                    width: 50,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tiet['thu']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Thông tin tiết dạy
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${tiet['mon']} - Lớp: ${tiet['lop']}', 
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 16, color: Colors.blue[300]),
                            const SizedBox(width: 4),
                            Text('${tiet['gio']} | ', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                            Icon(Icons.location_on, size: 16, color: Colors.red[300]),
                            const SizedBox(width: 4),
                            Text(tiet['phong']!, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.people, size: 16, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text('Sĩ số: ${tiet['siSo']} sinh viên', 
                              style: const TextStyle(color: Colors.blue, fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Cột nút Sửa & Xóa
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_note, color: Colors.orange),
                        onPressed: () => _showForm(index), // Sửa
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                        onPressed: () {
                          setState(() => lichDay.removeAt(index)); // Xóa
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Nút Thêm mới
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () => _showForm(null),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}