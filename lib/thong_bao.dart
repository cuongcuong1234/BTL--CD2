import 'package:flutter/material.dart';

class ThongBaoScreen extends StatelessWidget {
  const ThongBaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu mẫu danh sách thông báo
    final List<Map<String, String>> danhSachThongBao = [
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
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: danhSachThongBao.length,
        itemBuilder: (context, index) {
          final item = danhSachThongBao[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () {
                // Xử lý khi nhấn vào để xem chi tiết
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTag(item['loai']!),
                        Text(item['ngay']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Hàm tạo nhãn phân loại dựa trên loại thông báo
  Widget _buildTag(String type) {
    Color bgColor;
    switch (type) {
      case 'Nghỉ lễ': bgColor = Colors.red[100]!; break;
      case 'Học bổng': bgColor = Colors.green[100]!; break;
      default: bgColor = Colors.blue[100]!;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(type, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}