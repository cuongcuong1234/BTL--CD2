import 'package:flutter/material.dart';

class QuanLyNganhScreen extends StatefulWidget {
  final String userRole;
  const QuanLyNganhScreen({Key? key, this.userRole = 'admin'}) : super(key: key);

  @override
  State<QuanLyNganhScreen> createState() => _QuanLyNganhScreenState();
}

class _QuanLyNganhScreenState extends State<QuanLyNganhScreen> {
  final TextEditingController searchController = TextEditingController();

  List<Map<String, String>> majors = [
    {
      'code': 'KETOAN',
      'name': 'Kế toán',
    },
    {
      'code': 'CNTT',
      'name': 'Công nghệ thông tin',
    },
    {
      'code': 'CNOTO',
      'name': 'Công nghệ kỹ thuật ô tô',
    },
    {
      'code': 'MARKETING',
      'name': 'Marketing',
    },
    {
      'code': 'KTXD',
      'name': 'Kỹ thuật xây dựng',
    },
    {
      'code': 'CNTP',
      'name': 'Công nghệ thực phẩm',
    },
  ];

  List<Map<String, String>> filteredMajors = [];

  @override
  void initState() {
    super.initState();
    filteredMajors = majors;
    searchController.addListener(_filterMajors);
  }

  void _filterMajors() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredMajors = majors
          .where((major) =>
              major['name']!.toLowerCase().contains(query) ||
              major['code']!.toLowerCase().contains(query))
          .toList();
    });
  }

  void _showForm(int? index) {
    final codeController = TextEditingController(
      text: index != null ? majors[index]['code'] : '',
    );
    final nameController = TextEditingController(
      text: index != null ? majors[index]['name'] : '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Thêm chuyên ngành mới' : 'Chỉnh sửa chuyên ngành'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Mã chuyên ngành',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Tên chuyên ngành',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (codeController.text.isNotEmpty &&
                  nameController.text.isNotEmpty) {
                setState(() {
                  if (index == null) {
                    majors.add({
                      'code': codeController.text,
                      'name': nameController.text,
                    });
                  } else {
                    majors[index]['code'] = codeController.text;
                    majors[index]['name'] = nameController.text;
                  }
                  _filterMajors();
                });
                Navigator.pop(context);
              }
            },
            child: Text(index == null ? 'Thêm' : 'Lưu'),
          ),
        ],
      ),
    );
  }

  void _deleteMajor(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa chuyên ngành'),
        content: Text('Bạn chắc chắn muốn xóa ${majors[index]['code']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                majors.removeAt(index);
                _filterMajors();
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
        backgroundColor: const Color(0xFF1e3a5f),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFB81C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'DANH SÁCH CHUYÊN NGÀNH',
          style: TextStyle(
            color: Color(0xFFFFB81C),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Field
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nhập tên ngành cần tìm',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6366d1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF6366d1)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // List
          Expanded(
            child: filteredMajors.isEmpty
                ? Center(
                    child: Text(
                      'Không tìm thấy chuyên ngành',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredMajors.length,
                    itemBuilder: (context, index) {
                      final major = filteredMajors[index];
                      final actualIndex = majors.indexOf(major);
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                // University Logo
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF1e3a5f),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Container(
                                      color: Colors.white,
                                      child: Icon(
                                        Icons.school,
                                        color: const Color(0xFF1e3a5f),
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Major Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mã chuyên ngành : ${major['code']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Tên chuyên ngành : ${major['name']}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Action Buttons
                                if (widget.userRole != 'student')
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Color(0xFF6366d1),
                                      size: 22,
                                    ),
                                    onPressed: () {
                                      _showForm(actualIndex);
                                    },
                                  ),
                                if (widget.userRole != 'student')
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                                    onPressed: () {
                                      _deleteMajor(actualIndex);
                                    },
                                  ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: widget.userRole != 'student'
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF1e3a5f),
              onPressed: () {
                _showForm(null);
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
