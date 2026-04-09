import 'package:flutter/material.dart';

class XemDiemScreen extends StatefulWidget {
  const XemDiemScreen({super.key});

  @override
  State<XemDiemScreen> createState() => _XemDiemScreenState();
}

class _XemDiemScreenState extends State<XemDiemScreen> {
  // Danh sách điểm học tập
  List<Map<String, String>> danhSachDiem = [
    {
      'maSV': 'SV001',
      'tenSV': 'Nguyễn Văn A',
      'monHoc': 'Lập trình Flutter',
      'diemSo': '8.5',
      'diemChu': 'B+',
      'hocKy': 'I - 2024'
    },
    {
      'maSV': 'SV001',
      'tenSV': 'Nguyễn Văn A',
      'monHoc': 'Cấu trúc dữ liệu',
      'diemSo': '7.0',
      'diemChu': 'B',
      'hocKy': 'I - 2024'
    },
    {
      'maSV': 'SV001',
      'tenSV': 'Nguyễn Văn A',
      'monHoc': 'Cơ sở dữ liệu',
      'diemSo': '9.0',
      'diemChu': 'A',
      'hocKy': 'I - 2024'
    },
    {
      'maSV': 'SV001',
      'tenSV': 'Nguyễn Văn A',
      'monHoc': 'Mạng máy tính',
      'diemSo': '7.5',
      'diemChu': 'B+',
      'hocKy': 'I - 2024'
    },
    {
      'maSV': 'SV002',
      'tenSV': 'Trần Thị B',
      'monHoc': 'Lập trình Flutter',
      'diemSo': '9.5',
      'diemChu': 'A+',
      'hocKy': 'I - 2024'
    },
    {
      'maSV': 'SV002',
      'tenSV': 'Trần Thị B',
      'monHoc': 'Cấu trúc dữ liệu',
      'diemSo': '8.5',
      'diemChu': 'B+',
      'hocKy': 'I - 2024'
    },
  ];

  String _filterSinhVien = 'Tất cả';
  String _filterHocKy = 'Tất cả';

  List<Map<String, String>> get _diemDaLoc {
    return danhSachDiem.where((diem) {
      bool locSV = _filterSinhVien == 'Tất cả' || diem['maSV'] == _filterSinhVien;
      bool locHK = _filterHocKy == 'Tất cả' || diem['hocKy'] == _filterHocKy;
      return locSV && locHK;
    }).toList();
  }

  Set<String> get _danhSachSinhVien {
    return danhSachDiem.map((d) => '${d['maSV']} - ${d['tenSV']}').toSet();
  }

  Set<String> get _danhSachHocKy {
    return danhSachDiem.map((d) => d['hocKy']!).toSet();
  }

  Color _getDiemColor(double diem) {
    if (diem >= 8.5) return Colors.green;
    if (diem >= 7.0) return Colors.blue;
    if (diem >= 5.0) return Colors.orange;
    return Colors.red;
  }

  void _showForm(int? index) {
    final maSVController = TextEditingController(text: index != null ? danhSachDiem[index]['maSV'] : '');
    final tenSVController = TextEditingController(text: index != null ? danhSachDiem[index]['tenSV'] : '');
    final monController = TextEditingController(text: index != null ? danhSachDiem[index]['monHoc'] : '');
    final diemController = TextEditingController(text: index != null ? danhSachDiem[index]['diemSo'] : '');
    String selectedHocKy = index != null ? danhSachDiem[index]['hocKy']! : 'I - 2024';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Thêm Điểm' : 'Sửa Điểm'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: maSVController,
                decoration: const InputDecoration(labelText: 'Mã sinh viên'),
              ),
              TextField(
                controller: tenSVController,
                decoration: const InputDecoration(labelText: 'Tên sinh viên'),
              ),
              TextField(
                controller: monController,
                decoration: const InputDecoration(labelText: 'Môn học'),
              ),
              TextField(
                controller: diemController,
                decoration: const InputDecoration(labelText: 'Điểm số (0-10)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedHocKy,
                items: ['I - 2024', 'II - 2024', 'I - 2025', 'II - 2025']
                    .map((hk) => DropdownMenuItem(value: hk, child: Text(hk)))
                    .toList(),
                onChanged: (val) => selectedHocKy = val!,
                decoration: const InputDecoration(labelText: 'Học kỳ'),
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
              double? diem = double.tryParse(diemController.text);
              if (diem == null || diem < 0 || diem > 10) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Điểm phải từ 0 đến 10')),
                );
                return;
              }

              String diemChu;
              if (diem >= 9.0) diemChu = 'A+';
              else if (diem >= 8.5) diemChu = 'A';
              else if (diem >= 8.0) diemChu = 'B+';
              else if (diem >= 7.0) diemChu = 'B';
              else if (diem >= 6.0) diemChu = 'C+';
              else if (diem >= 5.0) diemChu = 'C';
              else diemChu = 'F';

              setState(() {
                final newDiem = {
                  'maSV': maSVController.text,
                  'tenSV': tenSVController.text,
                  'monHoc': monController.text,
                  'diemSo': diem.toString(),
                  'diemChu': diemChu,
                  'hocKy': selectedHocKy,
                };
                if (index == null) {
                  danhSachDiem.add(newDiem);
                } else {
                  danhSachDiem[index] = newDiem;
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

  void _deleteDiem(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text(
          'Bạn có chắc muốn xóa điểm của ${danhSachDiem[index]['tenSV']} '
          'môn ${danhSachDiem[index]['monHoc']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Không'),
          ),
          TextButton(
            onPressed: () {
              setState(() => danhSachDiem.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
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
          'QUẢN LÝ ĐIỂM HỌC TẬP',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: Column(
        children: [
          // Filters
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _filterSinhVien,
                    items: ['Tất cả', ..._danhSachSinhVien]
                        .map((sv) => DropdownMenuItem(value: sv, child: Text(sv, maxLines: 1, overflow: TextOverflow.ellipsis)))
                        .toList(),
                    onChanged: (val) => setState(() => _filterSinhVien = val!),
                    decoration: InputDecoration(
                      labelText: 'Sinh viên',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _filterHocKy,
                    items: ['Tất cả', ..._danhSachHocKy]
                        .map((hk) => DropdownMenuItem(value: hk, child: Text(hk)))
                        .toList(),
                    onChanged: (val) => setState(() => _filterHocKy = val!),
                    decoration: InputDecoration(
                      labelText: 'Học kỳ',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // List
          Expanded(
            child: _diemDaLoc.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assignment, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Không có dữ liệu',
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _diemDaLoc.length,
                    itemBuilder: (context, index) {
                      final diem = _diemDaLoc[index];
                      final diemSo = double.parse(diem['diemSo']!);
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        elevation: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border(
                              left: BorderSide(color: _getDiemColor(diemSo), width: 4),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              '${diem['tenSV']} (${diem['maSV']})',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text('Môn: ${diem['monHoc']}'),
                                Text('Học kỳ: ${diem['hocKy']}'),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getDiemColor(diemSo),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '${diem['diemSo']} (${diem['diemChu']})',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => Container(
                                  height: 120,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.edit, color: Colors.blue),
                                        title: const Text('Sửa'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _showForm(danhSachDiem.indexOf(diem));
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.delete, color: Colors.red),
                                        title: const Text('Xóa'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _deleteDiem(danhSachDiem.indexOf(diem));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add),
      ),
    );
  }
}
