import 'package:flutter/material.dart';

class HocPhiScreen extends StatelessWidget {
  const HocPhiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu mẫu học phí
    const String tongHocPhi = "12.500.000";
    const String daDong = "8.000.000";
    const String conNo = "4.500.000";

    final List<Map<String, String>> lichSuDongPhi = [
      {'ngay': '15/01/2026', 'soTien': '5.000.000', 'noiDung': 'Học phí đợt 1'},
      {'ngay': '20/02/2026', 'soTien': '3.000.000', 'noiDung': 'Học phí đợt 2'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.amber, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'THÔNG TIN HỌC PHÍ',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thẻ tóm tắt học phí
            _buildSummaryCard(tongHocPhi, daDong, conNo),
            const SizedBox(height: 24),
            const Text(
              'Lịch sử thanh toán',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 12),
            // Danh sách lịch sử
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lichSuDongPhi.length,
              itemBuilder: (context, index) {
                final item = lichSuDongPhi[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(item['noiDung']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Ngày: ${item['ngay']}'),
                    trailing: Text(
                      '+${item['soTien']}đ',
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String tong, String daDong, String no) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow('Tổng học phí:', '$tongđ', Colors.white),
          const Divider(color: Colors.white24),
          _buildInfoRow('Đã đóng:', '$daDongđ', Colors.greenAccent),
          const Divider(color: Colors.white24),
          _buildInfoRow('Còn nợ:', '$nođ', Colors.orangeAccent),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
          Text(value, style: TextStyle(color: valueColor, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}