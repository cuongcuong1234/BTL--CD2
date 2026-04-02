import 'package:flutter/material.dart';

class QuanLyNganhScreen extends StatefulWidget {
  const QuanLyNganhScreen({Key? key}) : super(key: key);

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
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xFF6366d1),
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Chỉnh sửa: ${major['code']}'),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Xác nhận xóa'),
                                        content: Text(
                                          'Bạn có chắc chắn muốn xóa ${major['code']}?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Hủy'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                majors.remove(major);
                                                filteredMajors.remove(major);
                                              });
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Đã xóa ${major['code']}',
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text('Xóa'),
                                          ),
                                        ],
                                      ),
                                    );
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1e3a5f),
        onPressed: () {
          final codeController = TextEditingController();
          final nameController = TextEditingController();

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Thêm chuyên ngành mới'),
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
                    codeController.dispose();
                    nameController.dispose();
                    Navigator.pop(context);
                  },
                  child: const Text('Hủy'),
                ),
                TextButton(
                  onPressed: () {
                    if (codeController.text.isNotEmpty &&
                        nameController.text.isNotEmpty) {
                      setState(() {
                        majors.add({
                          'code': codeController.text,
                          'name': nameController.text,
                        });
                        filteredMajors = majors;
                      });
                      codeController.dispose();
                      nameController.dispose();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Thêm ${codeController.text} thành công'),
                        ),
                      );
                    }
                  },
                  child: const Text('Thêm'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
