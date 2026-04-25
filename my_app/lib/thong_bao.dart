import 'package:flutter/material.dart';

class ThongBaoScreen extends StatefulWidget {
  const ThongBaoScreen({super.key});

  @override
  State<ThongBaoScreen> createState() => _ThongBaoScreenState();
}

class _ThongBaoScreenState extends State<ThongBaoScreen> {
  late List<Map<String, String>> danhSachThongBao;
  late TextEditingController tieuDeController;
  late TextEditingController noiDungController;
  late TextEditingController ngayController;
  String selectedLoai = 'Thông báo chung';
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    danhSachThongBao = [
      {
        'tieuDe': 'Thông báo nghỉ lễ Giỗ Tổ Hùng Vương',
        'ngay': '05/04/2026',
        'loai': 'Nghỉ lễ',
        'noiDung': 'Toàn thể sinh viên được nghỉ từ ngày 10/04 đến hết ngày 12/04.'
      },
      {
        'tieuDe': 'Danh sách học bổng học kỳ 1 - 2026',
        'ngay': '02/04/2026',
        'loai': 'Học bổng',
        'noiDung': 'Chúc mừng các bạn sinh viên có tên trong danh sách nhận học bổng khuyến khích.'
      },
      {
        'tieuDe': 'Hội thảo: Lập trình Flutter và Cơ hội nghề nghiệp',
        'ngay': '30/03/2026',
        'loai': 'Sự kiện',
        'noiDung': 'Diễn ra vào 8:30 sáng Thứ 7 tuần này tại Hội trường lớn.'
      },
    ];
    tieuDeController = TextEditingController();
    noiDungController = TextEditingController();
    ngayController = TextEditingController();
  }

  @override
  void dispose() {
    tieuDeController.dispose();
    noiDungController.dispose();
    ngayController.dispose();
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
    tieuDeController.clear();
    noiDungController.clear();
    ngayController.clear();
    selectedLoai = 'Thông báo chung';
    editingIndex = null;
  }

  void _showAddEditDialog({int? index}) {
    if (index != null) {
      final item = danhSachThongBao[index];
      tieuDeController.text = item['tieuDe']!;
      noiDungController.text = item['noiDung']!;
      ngayController.text = item['ngay']!;
      selectedLoai = item['loai']!;
      editingIndex = index;
    } else {
      _resetForm();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Thêm thông báo' : 'Sửa thông báo'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tieuDeController,
                decoration: const InputDecoration(labelText: 'Tiêu đề'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noiDungController,
                decoration: const InputDecoration(labelText: 'Nội dung'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ngayController,
                decoration: const InputDecoration(labelText: 'Ngày (dd/MM/yyyy)'),
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: selectedLoai,
                isExpanded: true,
                items: ['Nghỉ lễ', 'Học bổng', 'Sự kiện', 'Thông báo chung']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedLoai = value!);
                },
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
              if (tieuDeController.text.isEmpty ||
                  noiDungController.text.isEmpty ||
                  ngayController.text.isEmpty) {
                _showNotification('Vui lòng điền đầy đủ thông tin!', isError: true);
                return;
              }

              if (editingIndex == null) {
                danhSachThongBao.add({
                  'tieuDe': tieuDeController.text,
                  'noiDung': noiDungController.text,
                  'ngay': ngayController.text,
                  'loai': selectedLoai,
                });
                _showNotification('Thêm thông báo thành công!');
              } else {
                danhSachThongBao[editingIndex!] = {
                  'tieuDe': tieuDeController.text,
                  'noiDung': noiDungController.text,
                  'ngay': ngayController.text,
                  'loai': selectedLoai,
                };
                _showNotification('Cập nhật thông báo thành công!');
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

  void _deleteNotification(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc muốn xóa thông báo này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              danhSachThongBao.removeAt(index);
              _showNotification('Xóa thông báo thành công!');
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
          'THÔNG BÁO CHUNG',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.amber, size: 28),
            onPressed: () => _showAddEditDialog(),
          ),
        ],
      ),
      body: danhSachThongBao.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Không có thông báo nào',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: danhSachThongBao.length,
              itemBuilder: (context, index) {
                final item = danhSachThongBao[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTag(item['loai']!),
                            Row(
                              children: [
                                Text(item['ngay']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                const SizedBox(width: 8),
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
                                      onTap: () => _showAddEditDialog(index: index),
                                    ),
                                    PopupMenuItem(
                                      child: const Row(
                                        children: [
                                          Icon(Icons.delete, size: 18, color: Colors.red),
                                          SizedBox(width: 8),
                                          Text('Xóa', style: TextStyle(color: Colors.red)),
                                        ],
                                      ),
                                      onTap: () => _deleteNotification(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['tieuDe']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['noiDung']!,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildTag(String type) {
    Color bgColor;
    Color textColor;
    switch (type) {
      case 'Nghỉ lễ':
        bgColor = Colors.red[100]!;
        textColor = Colors.red[700]!;
        break;
      case 'Học bổng':
        bgColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        break;
      case 'Sự kiện':
        bgColor = Colors.orange[100]!;
        textColor = Colors.orange[700]!;
        break;
      default:
        bgColor = Colors.blue[100]!;
        textColor = Colors.blue[700]!;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(type, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor)),
    );
  }
}