import 'package:flutter/material.dart';

class XemDiemChiTietScreen extends StatefulWidget {
  final Map<String, String>? studentInfo;
  final String? maSV;
  final String userRole;
  const XemDiemChiTietScreen({
    super.key,
    this.studentInfo,
    this.maSV,
    this.userRole = 'admin',
  });

  @override
  State<XemDiemChiTietScreen> createState() => _XemDiemChiTietScreenState();
}

class _XemDiemChiTietScreenState extends State<XemDiemChiTietScreen> {
  // Thông tin sinh viên
  late Map<String, String> thongTinSV;

  // Danh sách môn học
  List<String> danhSachMonHoc = [
    'Lập trình OOP',
    'Lập trình Java',
    'Lập trình web',
    'Lập trình mạng',
    'Khoa học máy tính',
    'Xác suất thống kê',
  ];

  // Danh sách sinh viên để tìm thông tin
  final List<Map<String, String>> danhSachSinhVien = [
    {
      'maSV': '20224047',
      'tenSV': 'Nguyễn Gia Khánh',
      'email': 'nguyenkhanh@gmail.com',
      'maLop': '001',
      'tenNganh': 'CNTT',
      'avatar': 'assets/avatar1.png',
      'color': 'purple'
    },
    {
      'maSV': '20223882',
      'tenSV': 'Vũ Huy Khánh',
      'email': 'vukhanh@gmail.com',
      'maLop': '002',
      'tenNganh': 'KETOAN',
      'avatar': 'assets/avatar2.png',
      'color': 'grey'
    },
    {
      'maSV': '20224997',
      'tenSV': 'Ngô Mạnh Kiên',
      'email': 'Manhkien@gmail.com',
      'maLop': '003',
      'tenNganh': 'CNTT',
      'avatar': 'assets/avatar3.png',
      'color': 'grey'
    },
    {
      'maSV': '12345',
      'tenSV': 'Nguyễn Văn A',
      'email': 'van@gmail.com',
      'maLop': '001',
      'tenNganh': 'CNTT',
      'avatar': 'assets/avatar4.png',
      'color': 'grey'
    },
    {
      'maSV': '42222',
      'tenSV': 'Nguyễn Văn B',
      'email': 'vanb@gmail.com',
      'maLop': '002',
      'tenNganh': 'KETOAN',
      'avatar': 'assets/avatar5.png',
      'color': 'grey'
    },
  ];

  // Danh sách điểm chi tiết
  List<Map<String, String>> danhSachDiemChiTiet = [
    {'monHoc': 'Lập trình OOP', 'diem': '10.0'},
    {'monHoc': 'Lập trình Java', 'diem': '8.0'},
    {'monHoc': 'Lập trình web', 'diem': '7.0'},
    {'monHoc': 'Lập trình mạng', 'diem': '5.0'},
    {'monHoc': 'Khoa học máy tính', 'diem': '7.0'},
    {'monHoc': 'Xác suất thống kê', 'diem': '8.0'},
  ];

  String? _selectedMonHoc;
  TextEditingController _diemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Nếu có thông tin sinh viên từ parameter, sử dụng nó
    if (widget.studentInfo != null) {
      thongTinSV = widget.studentInfo!;
    } else if (widget.maSV != null) {
      // Tìm sinh viên trong danh sách dựa trên maSV
      final student = danhSachSinhVien.firstWhere(
        (sv) => sv['maSV'] == widget.maSV,
        orElse: () => {
          'maSV': widget.maSV!,
          'tenSV': 'Sinh viên',
          'email': 'unknown@gmail.com',
          'maLop': '---',
          'tenNganh': '---',
        },
      );
      thongTinSV = student;
    } else {
      // Nếu không, sử dụng thông tin mặc định
      thongTinSV = {
        'maSV': '20224047',
        'tenSV': 'Nguyễn Gia Khánh',
        'email': 'nguyenkhanh@gmail.com',
        'lop': 'DCCNTT13.10.21',
        'nganh': 'Công nghệ thông tin',
      };
    }
    _selectedMonHoc = danhSachMonHoc.first;
  }

  void _addDiem() {
    if (_diemController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập điểm')),
      );
      return;
    }

    double? diem = double.tryParse(_diemController.text);
    if (diem == null || diem < 0 || diem > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Điểm phải từ 0 đến 10')),
      );
      return;
    }

    // Kiểm tra xem môn học đã có điểm chưa
    int existingIndex = danhSachDiemChiTiet.indexWhere(
      (d) => d['monHoc'] == _selectedMonHoc,
    );

    setState(() {
      if (existingIndex != -1) {
        // Cập nhật điểm cũ
        danhSachDiemChiTiet[existingIndex] = {
          'monHoc': _selectedMonHoc!,
          'diem': diem.toString(),
        };
      } else {
        // Thêm điểm mới
        danhSachDiemChiTiet.add({
          'monHoc': _selectedMonHoc!,
          'diem': diem.toString(),
        });
      }
      _diemController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thêm/cập nhật điểm thành công')),
    );
  }

  void _editDiem(int index) {
    _diemController.text = danhSachDiemChiTiet[index]['diem']!;
    _selectedMonHoc = danhSachDiemChiTiet[index]['monHoc'];
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sửa Điểm'),
        content: TextField(
          controller: _diemController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Điểm số (0-10)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              double? diem = double.tryParse(_diemController.text);
              if (diem == null || diem < 0 || diem > 10) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Điểm phải từ 0 đến 10')),
                );
                return;
              }
              setState(() {
                danhSachDiemChiTiet[index]['diem'] = diem.toString();
              });
              _diemController.clear();
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
          'Bạn có chắc muốn xóa điểm của môn ${danhSachDiemChiTiet[index]['monHoc']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Không'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                danhSachDiemChiTiet.removeAt(index);
              });
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
          'ĐIỂM THÀNH PHẦN',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Title
            Center(
              child: Text(
                'THÔNG TIN ĐIỂM THÀNH PHẦN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Thông tin sinh viên
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mã sinh viên: ${thongTinSV['maSV'] ?? ''}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tên sinh viên: ${thongTinSV['tenSV'] ?? ''}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: ${thongTinSV['email'] ?? ''}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tên lớp: ${thongTinSV['maLop'] ?? thongTinSV['lop'] ?? ''}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tên ngành: ${thongTinSV['tenNganh'] ?? thongTinSV['nganh'] ?? ''}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Thêm điểm section - Chỉ hiển thị cho admin
            if (widget.userRole == 'admin') ...[
              Center(
                child: Text(
                  'THÊM ĐIỂM HỌC PHẦN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Dropdown chọn môn học
              DropdownButtonFormField<String>(
                value: _selectedMonHoc,
                items: danhSachMonHoc
                    .map((mon) => DropdownMenuItem(value: mon, child: Text(mon)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedMonHoc = val),
                decoration: InputDecoration(
                  labelText: 'Chọn học phần',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),

              // Nhập điểm và nút thêm
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _diemController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Nhập điểm',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _addDiem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    ),
                    child: const Text(
                      'THÊM',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],

            // Danh sách điểm
            Text(
              'HỌC PHẦN',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(thickness: 2),
            
            // Header bảng
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'HỌC PHẦN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'ĐIỂM',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  if (widget.userRole == 'admin')
                    Expanded(
                      child: Center(
                        child: Text(
                          'HÀNH ĐỘNG',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(thickness: 1),

            // Danh sách items
            ...List.generate(
              danhSachDiemChiTiet.length,
              (index) {
                final item = danhSachDiemChiTiet[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              item['monHoc']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                item['diem']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: widget.userRole == 'admin'
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () => _editDiem(index),
                                          icon: const Icon(Icons.edit, color: Colors.blue),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton(
                                          onPressed: () => _deleteDiem(index),
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 1),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _diemController.dispose();
    super.dispose();
  }
}
