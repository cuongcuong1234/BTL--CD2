import 'package:flutter/material.dart';
import 'xem_diem_chi_tiet.dart';

class QuanLySinhVienScreen extends StatefulWidget {
  final String userRole;
  const QuanLySinhVienScreen({super.key, this.userRole = 'admin'});

  @override
  State<QuanLySinhVienScreen> createState() => _QuanLySinhVienScreenState();
}

class _QuanLySinhVienScreenState extends State<QuanLySinhVienScreen> {
  final searchController = TextEditingController();
  
  // Danh sách sinh viên
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

  List<Map<String, String>> filteredSinhVien = [];

  @override
  void initState() {
    super.initState();
    filteredSinhVien = danhSachSinhVien;
  }

  void searchSinhVien(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSinhVien = danhSachSinhVien;
      } else {
        filteredSinhVien = danhSachSinhVien
            .where((sv) =>
                sv['tenSV']!.toLowerCase().contains(query.toLowerCase()) ||
                sv['maSV']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showForm(int? index) {
    final maSVController = TextEditingController(
      text: index != null ? danhSachSinhVien[index]['maSV'] : '',
    );
    final tenSVController = TextEditingController(
      text: index != null ? danhSachSinhVien[index]['tenSV'] : '',
    );
    final emailController = TextEditingController(
      text: index != null ? danhSachSinhVien[index]['email'] : '',
    );
    final maLopController = TextEditingController(
      text: index != null ? danhSachSinhVien[index]['maLop'] : '',
    );
    final tenNganhController = TextEditingController(
      text: index != null ? danhSachSinhVien[index]['tenNganh'] : '',
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Thêm Sinh Viên' : 'Sửa Sinh Viên'),
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
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: maLopController,
                decoration: const InputDecoration(labelText: 'Mã lớp'),
              ),
              TextField(
                controller: tenNganhController,
                decoration: const InputDecoration(labelText: 'Tên ngành'),
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
              if (maSVController.text.isEmpty ||
                  tenSVController.text.isEmpty ||
                  emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
                );
                return;
              }

              setState(() {
                final newSV = {
                  'maSV': maSVController.text,
                  'tenSV': tenSVController.text,
                  'email': emailController.text,
                  'maLop': maLopController.text,
                  'tenNganh': tenNganhController.text,
                  'avatar': 'assets/avatar1.png',
                  'color': 'grey',
                };
                if (index == null) {
                  danhSachSinhVien.add(newSV);
                } else {
                  danhSachSinhVien[index] = newSV;
                }
                filteredSinhVien = danhSachSinhVien;
              });
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _deleteSinhVien(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content:
            Text('Bạn có chắc muốn xóa sinh viên ${danhSachSinhVien[index]['tenSV']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Không'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                danhSachSinhVien.removeAt(index);
                filteredSinhVien = danhSachSinhVien;
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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber[400], size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'DANH SÁCH SINH VIÊN',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nhập tên cần tìm kiếm',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: searchController,
                  onChanged: searchSinhVien,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm sinh viên...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
                    ),
                    suffixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
          // List Section
          Expanded(
            child: filteredSinhVien.isEmpty
                ? Center(
                    child: Text(
                      'Không tìm thấy sinh viên nào',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredSinhVien.length,
                    itemBuilder: (context, index) {
                      final sv = filteredSinhVien[index];
                      final actualIndex = danhSachSinhVien.indexOf(sv);
                      return _buildSinhVienItem(sv, actualIndex);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: widget.userRole != 'student'
          ? FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: () => _showForm(null),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : null,
    );
  }

  Widget _buildSinhVienItem(Map<String, String> sv, int index) {
    Color avatarColor = Colors.grey;
    if (sv['color'] == 'purple') {
      avatarColor = Colors.purple;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => XemDiemChiTietScreen(
              studentInfo: sv,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: avatarColor,
                  ),
                  child: Image.asset(
                    sv['avatar']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: avatarColor,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            // Sinh viên info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Mã',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        '  :  ',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                      Text(
                        sv['maSV']!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Text(
                        'Tên',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        '  :  ',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                      Expanded(
                        child: Text(
                          sv['tenSV']!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        '  :  ',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                      Expanded(
                        child: Text(
                          sv['email']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Text(
                        'Mã lớp',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        '  :  ',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                      Text(
                        sv['maLop']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Text(
                        'Tên ngành',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        '  :  ',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                      Text(
                        sv['tenNganh']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Action Buttons
            if (widget.userRole != 'student')
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey[600], size: 20),
                    onPressed: () => _showForm(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey[600], size: 20),
                    onPressed: () => _deleteSinhVien(index),
                  ),
                ],
              ),
          ],
        ),
      ),
    ));
  }
}
