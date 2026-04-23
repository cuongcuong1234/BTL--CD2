import 'package:flutter/material.dart';
import 'services/database_service.dart';

class LichHocSVScreen extends StatefulWidget {
  final String? maSV;

  const LichHocSVScreen({super.key, this.maSV});

  @override
  State<LichHocSVScreen> createState() => _LichHocSVScreenState();
}

class _LichHocSVScreenState extends State<LichHocSVScreen> {
  late Future<List<Map<String, dynamic>>> _lichHocFuture;

  @override
  void initState() {
    super.initState();
    // Nếu có maSV, lấy lịch học từ database; nếu không, dùng dữ liệu mẫu
    if (widget.maSV != null) {
      _lichHocFuture = DatabaseService().getLichHocSV(widget.maSV!);
    } else {
      _lichHocFuture = Future.value(DatabaseService().danhSachLichHocMau);
    }
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
          'LỊCH HỌC CỦA TÔI',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _lichHocFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final danhSachLichHoc = snapshot.data ?? [];
          
          if (danhSachLichHoc.isEmpty) {
            return const Center(
              child: Text('Không có lịch học',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: danhSachLichHoc.length,
            itemBuilder: (context, index) {
              final tiet = danhSachLichHoc[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.blue[900]!, width: 5)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      '${tiet['mon'] ?? 'N/A'}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text('${tiet['thu'] ?? 'N/A'} | ${tiet['gio'] ?? 'N/A'}', 
                              style: TextStyle(color: Colors.grey[800])),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Colors.red),
                            const SizedBox(width: 8),
                            Text('Phòng: ${tiet['phong'] ?? 'N/A'}', 
                              style: TextStyle(color: Colors.grey[800])),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.person, size: 16, color: Colors.blue),
                            const SizedBox(width: 8),
                            Text('GV: ${tiet['giangVien'] ?? 'N/A'}', 
                              style: const TextStyle(fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}