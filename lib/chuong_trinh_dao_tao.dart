import 'package:flutter/material.dart';

class ChuongTrinhDaoTaoScreen extends StatelessWidget {
  const ChuongTrinhDaoTaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu mẫu chương trình đào tạo ngành CNTT
    final Map<String, List<Map<String, String>>> data = {
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
              children: data[hocKy]!.map((mon) {
                return ListTile(
                  title: Text(mon['mon']!),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('${mon['tin']} tín chỉ', 
                      style: TextStyle(color: Colors.blue[900], fontSize: 12)),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}