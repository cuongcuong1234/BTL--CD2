import 'package:flutter/material.dart';

class ChuongTrinhDaoTaoScreen extends StatefulWidget {
  const ChuongTrinhDaoTaoScreen({super.key});

  @override
  State<ChuongTrinhDaoTaoScreen> createState() => _ChuongTrinhDaoTaoScreenState();
}

class _ChuongTrinhDaoTaoScreenState extends State<ChuongTrinhDaoTaoScreen> {
  late Map<String, List<Map<String, String>>> data;
  late TextEditingController tenMonController;
  late TextEditingController tinChiController;
  String? selectedHocKy;
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    data = {
      'Học kỳ 1': [
        {'mon': 'Tin học đại cương', 'tin': '3'},
        {'mon': 'Giải tích 1', 'tin': '3'},
        {'mon': 'Tiếng Anh cơ bản 1', 'tin': '2'},
      ],
      'Học kỳ 2': [
        {'mon': 'Lập trình C/C++', 'tin': '4'},
        {'mon': 'Đại số tuyến tính', 'tin': '3'},
        {'mon': 'Triết học Mác-Lênin', 'tin': '3'},
      ],
      'Học kỳ 3': [
        {'mon': 'Cấu trúc dữ liệu và giải thuật', 'tin': '4'},
        {'mon': 'Cơ sở dữ liệu', 'tin': '3'},
        {'mon': 'Lập trình hướng đối tượng', 'tin': '3'},
      ],
      'Học kỳ 4': [
        {'mon': 'Lập trình Flutter', 'tin': '3'},
        {'mon': 'Mạng máy tính', 'tin': '3'},
        {'mon': 'Hệ điều hành', 'tin': '3'},
      ],
    };
    tenMonController = TextEditingController();
    tinChiController = TextEditingController();
  }

  @override
  void dispose() {
    tenMonController.dispose();
    tinChiController.dispose();
    super.dispose();
  }

  void _showNotification(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _resetForm() {
    tenMonController.clear();
    tinChiController.clear();
    editingIndex = null;
  }

  void _showAddEditDialog({required String hocKy, int? index}) {
    selectedHocKy = hocKy;
    if (index != null) {
      final item = data[hocKy]![index];
      tenMonController.text = item['mon']!;
      tinChiController.text = item['tin']!;
      editingIndex = index;
    } else {
      _resetForm();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Thêm môn học' : 'Sửa môn học'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tenMonController,
                decoration: const InputDecoration(labelText: 'Tên môn học'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: tinChiController,
                decoration: const InputDecoration(labelText: 'Tín chỉ'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (tenMonController.text.isEmpty || tinChiController.text.isEmpty) {
                _showNotification('Vui lòng điền đầy đủ thông tin!', isError: true);
                return;
              }

              if (editingIndex == null) {
                data[selectedHocKy]!.add({
                  'mon': tenMonController.text,
                  'tin': tinChiController.text,
                });
                _showNotification('Thêm môn học thành công!');
              } else {
                data[selectedHocKy]![editingIndex!] = {
                  'mon': tenMonController.text,
                  'tin': tinChiController.text,
                };
                _showNotification('Cập nhật môn học thành công!');
              }

              _resetForm();
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _deleteMonHoc(String hocKy, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc muốn xóa môn học này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              data[hocKy]!.removeAt(index);
              _showNotification('Xóa môn học thành công!');
              setState(() {});
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
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
          icon: const Icon(Icons.arrow_back, color: Colors.amber, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'CHƯƠNG TRÌNH ĐÀO TẠO',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: data.keys.map((hocKy) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ExpansionTile(
              leading: Icon(Icons.school, color: Colors.blue[900]),
              title: Text(
                hocKy,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text('${data[hocKy]!.length} môn học'),
              children: [
                ...data[hocKy]!.asMap().entries.map((entry) {
                  int index = entry.key;
                  final mon = entry.value;
                  return ListTile(
                    title: Text(mon['mon']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text('${mon['tin']} tín chỉ',
                              style: TextStyle(color: Colors.blue[900], fontSize: 12)),
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: const Row(
                                children: [
                                  Icon(Icons.edit, size: 18),
                                  SizedBox(width: 8),
                                  Text('Sửa'),
                                ],
                              ),
                              onTap: () => _showAddEditDialog(hocKy: hocKy, index: index),
                            ),
                            PopupMenuItem(
                              child: const Row(
                                children: [
                                  Icon(Icons.delete, size: 18, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Xóa', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                              onTap: () => _deleteMonHoc(hocKy, index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () => _showAddEditDialog(hocKy: hocKy),
                    icon: const Icon(Icons.add),
                    label: const Text('Thêm môn học'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}