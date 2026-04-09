import 'package:flutter/material.dart';

class DanhSachLopScreen extends StatefulWidget {
  final String userRole;
  const DanhSachLopScreen({super.key, this.userRole = 'admin'});

  @override
  State<DanhSachLopScreen> createState() => _DanhSachLopScreenState();
}

class _DanhSachLopScreenState extends State<DanhSachLopScreen> {
  final searchController = TextEditingController();
  
  // Danh sách lớp học
  final List<Map<String, String>> danhSachLop = [
    {'maLop': '001', 'tenLop': 'DCCNTT13.10.21'},
    {'maLop': '002', 'tenLop': 'DCCNPT13.10.10'},
    {'maLop': '003', 'tenLop': 'DCCNPT13.10.5'},
    {'maLop': '004', 'tenLop': 'DCCNPT13.10.18'},
    {'maLop': '005', 'tenLop': 'DCCNPT14.10.2'},
    {'maLop': '006', 'tenLop': 'DCCNPT14.10.8'},
  ];

  List<Map<String, String>> filteredLop = [];

  @override
  void initState() {
    super.initState();
    filteredLop = danhSachLop;
  }

  void searchLop(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredLop = danhSachLop;
      } else {
        filteredLop = danhSachLop
            .where((lop) =>
                lop['tenLop']!.toLowerCase().contains(query.toLowerCase()) ||
                lop['maLop']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showForm(int? index) {
    final maLopController = TextEditingController(
      text: index != null ? danhSachLop[index]['maLop'] : '',
    );
    final tenLopController = TextEditingController(
      text: index != null ? danhSachLop[index]['tenLop'] : '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Thêm Lớp Mới' : 'Chỉnh Sửa Lớp'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: maLopController,
                decoration: InputDecoration(
                  labelText: 'Mã Lớp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: tenLopController,
                decoration: InputDecoration(
                  labelText: 'Tên Lớp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Huỷ'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (index == null) {
                  danhSachLop.add({
                    'maLop': maLopController.text,
                    'tenLop': tenLopController.text,
                  });
                } else {
                  danhSachLop[index]['maLop'] = maLopController.text;
                  danhSachLop[index]['tenLop'] = tenLopController.text;
                }
                searchLop(searchController.text);
              });
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _deleteLop(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa Lớp'),
        content: const Text('Bạn chắc chắn muốn xóa lớp này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Huỷ'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                danhSachLop.removeAt(index);
                searchLop(searchController.text);
              });
              Navigator.pop(context);
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
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
          'DANH SÁCH LỚP',
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
                  'Nhập tên lớp cần tìm',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: searchController,
                  onChanged: searchLop,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm lớp...',
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
            child: filteredLop.isEmpty
                ? Center(
                    child: Text(
                      'Không tìm thấy lớp nào',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredLop.length,
                    itemBuilder: (context, index) {
                      final lop = filteredLop[index];
                      final actualIndex = danhSachLop.indexOf(lop);
                      return _buildLopItem(lop, actualIndex);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: widget.userRole != 'student'
          ? FloatingActionButton(
              backgroundColor: Colors.blue[900],
              onPressed: () {
                _showForm(null);
              },
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : null,
    );
  }

  Widget _buildLopItem(Map<String, String> lop, int actualIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Logo trường (vòng tròn)
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue[900]!, width: 2),
              ),
              child: Image.asset(
                'assets/logo.png',
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue[900],
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // Mã lớp và tên lớp
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mã lớp : ${lop['maLop']}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tên lớp : ${lop['tenLop']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Action Buttons
            if (widget.userRole != 'student')
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey[600], size: 20),
                    onPressed: () {
                      _showForm(actualIndex);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey[600], size: 20),
                    onPressed: () {
                      _deleteLop(actualIndex);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
