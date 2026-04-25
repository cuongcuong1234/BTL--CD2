import 'package:flutter/material.dart';
import 'services/database_service.dart';

class ThoiKhoaBieuScreen extends StatefulWidget {
  final String userRole;
  final String userId;
  final String? userClass;

  const ThoiKhoaBieuScreen({
    super.key,
    this.userRole = 'admin',
    this.userId = '20224047',
    this.userClass,
  });

  @override
  State<ThoiKhoaBieuScreen> createState() => _ThoiKhoaBieuScreenState();
}

class _ThoiKhoaBieuScreenState extends State<ThoiKhoaBieuScreen> {
  late DatabaseService _databaseService;
  List<Map<String, dynamic>> thoiKhoaBieu = [];
  List<Map<String, dynamic>> lichDay = [];
  bool isLoading = true;
  DateTime _selectedWeekStart = DateTime.now();

  @override
  void initState() {
    super.initState();
    _databaseService = DatabaseService();
    _loadData();
  }

  void _loadData() async {
    try {
      setState(() => isLoading = true);

      if (widget.userRole == 'admin') {
        // Admin: Lấy lịch dạy
        final schedule = await _databaseService.getAllLichDay();
        setState(() {
          lichDay = schedule;
          isLoading = false;
        });
      } else {
        // Sinh viên: Lấy thời khóa biểu
        final studentInfo = await _databaseService.getStudent(widget.userId);
        String maLop = studentInfo?['maLop'] ?? widget.userClass ?? '001';

        final schedule = await _databaseService.getThoiKhoaBieuWithId(maLop);

        setState(() {
          thoiKhoaBieu = schedule;
          isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Lỗi load dữ liệu: $e');
      setState(() => isLoading = false);
    }
  }

  // Lấy giờ học từ chuỗi "07:30-09:30"
  int _getStartHour(String timeStr) {
    try {
      return int.parse(timeStr.split('-')[0].split(':')[0]);
    } catch (e) {
      return 7;
    }
  }

  // Danh sách thứ trong tuần
  final List<String> _thuTrongTuan = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];

  void _showAddLichDayForm() {
    final monController = TextEditingController();
    final phongController = TextEditingController();
    final gioController = TextEditingController();
    final giangVienController = TextEditingController();
    final maLopController = TextEditingController();
    final siSoController = TextEditingController();
    String selectedThu = 'Thứ 2';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thêm Lịch Dạy'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedThu,
                items: _thuTrongTuan
                    .map((thu) => DropdownMenuItem(value: thu, child: Text(thu)))
                    .toList(),
                onChanged: (val) => selectedThu = val!,
                decoration: const InputDecoration(labelText: 'Thứ'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: monController,
                decoration: const InputDecoration(labelText: 'Môn học'),
              ),
              TextField(
                controller: maLopController,
                decoration: const InputDecoration(labelText: 'Mã lớp'),
              ),
              TextField(
                controller: phongController,
                decoration: const InputDecoration(labelText: 'Phòng'),
              ),
              TextField(
                controller: gioController,
                decoration: const InputDecoration(labelText: 'Giờ (VD: 07:30-09:30)'),
              ),
              TextField(
                controller: giangVienController,
                decoration: const InputDecoration(labelText: 'Giảng viên'),
              ),
              TextField(
                controller: siSoController,
                decoration: const InputDecoration(labelText: 'Sĩ số'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () async {
              try {
                await _databaseService.addLichDay(
                  thu: selectedThu,
                  thuTu: _thuTrongTuan.indexOf(selectedThu) + 2,
                  mon: monController.text,
                  maLop: maLopController.text,
                  phong: phongController.text,
                  gio: gioController.text,
                  giangVien: giangVienController.text,
                  siSo: int.tryParse(siSoController.text) ?? 0,
                );

                if (mounted) {
                  Navigator.pop(context);
                  _loadData();
                }
              } catch (e) {
                print('❌ Lỗi lưu: $e');
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _showEditLichDayForm(Map<String, dynamic> lich) {
    final monController = TextEditingController(text: lich['mon'] ?? '');
    final phongController = TextEditingController(text: lich['phong'] ?? '');
    final gioController = TextEditingController(text: lich['gio'] ?? '');
    final giangVienController = TextEditingController(text: lich['giangVien'] ?? '');
    final maLopController = TextEditingController(text: lich['maLop'] ?? '');
    final siSoController = TextEditingController(text: '${lich['siSo'] ?? 0}');
    String selectedThu = lich['thu'] ?? 'Thứ 2';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sửa Lịch Dạy'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedThu,
                items: _thuTrongTuan
                    .map((thu) => DropdownMenuItem(value: thu, child: Text(thu)))
                    .toList(),
                onChanged: (val) => selectedThu = val!,
                decoration: const InputDecoration(labelText: 'Thứ'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: monController,
                decoration: const InputDecoration(labelText: 'Môn học'),
              ),
              TextField(
                controller: maLopController,
                decoration: const InputDecoration(labelText: 'Mã lớp'),
              ),
              TextField(
                controller: phongController,
                decoration: const InputDecoration(labelText: 'Phòng'),
              ),
              TextField(
                controller: gioController,
                decoration: const InputDecoration(labelText: 'Giờ (VD: 07:30-09:30)'),
              ),
              TextField(
                controller: giangVienController,
                decoration: const InputDecoration(labelText: 'Giảng viên'),
              ),
              TextField(
                controller: siSoController,
                decoration: const InputDecoration(labelText: 'Sĩ số'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () async {
              try {
                await _databaseService.updateLichDay(lich['id'], {
                  'thu': selectedThu,
                  'thuTu': _thuTrongTuan.indexOf(selectedThu) + 2,
                  'mon': monController.text,
                  'maLop': maLopController.text,
                  'phong': phongController.text,
                  'gio': gioController.text,
                  'giangVien': giangVienController.text,
                  'siSo': int.tryParse(siSoController.text) ?? 0,
                });

                if (mounted) {
                  Navigator.pop(context);
                  _loadData();
                }
              } catch (e) {
                print('❌ Lỗi lưu: $e');
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _deleteLichDay(String docId) async {
    try {
      await _databaseService.deleteLichDay(docId);
      _loadData();
    } catch (e) {
      print('❌ Lỗi xóa: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.userRole == 'admin' ? 'LỊCH DẠY' : 'LỊCH CA NHÂN';
    List<Map<String, dynamic>> displayData = widget.userRole == 'admin' ? lichDay : thoiKhoaBieu;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a3a52),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.amber, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          if (widget.userRole == 'admin')
            IconButton(
              icon: const Icon(Icons.add, color: Colors.amber),
              onPressed: () => _showAddLichDayForm(),
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : displayData.isEmpty
              ? Center(
                  child: Text(
                    widget.userRole == 'admin' 
                        ? 'Không có lịch dạy nào' 
                        : 'Không có lịch học nào',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : widget.userRole == 'admin'
                  ? _buildLichDayForAdmin()
                  : _buildThoiKhoaBieuForStudent(),
    );
  }

  // Hiển thị Lịch Dạy cho Admin
  Widget _buildLichDayForAdmin() {
    final days = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: days.map((day) {
        final lichTrongNgay = lichDay.where((item) => item['thu'] == day).toList();
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 3,
          child: ExpansionTile(
            leading: Icon(Icons.schedule, color: Colors.blue[900]),
            title: Text(
              '$day (${lichTrongNgay.length} lịch)',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            children: lichTrongNgay.isEmpty
                ? [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Không có lịch dạy'),
                    )
                  ]
                : lichTrongNgay.map((lich) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[900],
                        child: const Icon(Icons.class_, color: Colors.white),
                      ),
                      title: Text(lich['mon'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        '${lich['maLop'] ?? 'N/A'} | ${lich['gio'] ?? 'N/A'} | ${lich['phong'] ?? 'N/A'}',
                      ),
                      trailing: Chip(
                        label: Text('${lich['siSo'] ?? 0} SV'),
                        backgroundColor: Colors.amber[100],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Chi tiết lịch dạy'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Môn: ${lich['mon']}'),
                                Text('Lớp: ${lich['maLop']}'),
                                Text('Giáo viên: ${lich['giangVien']}'),
                                Text('Giờ: ${lich['gio']}'),
                                Text('Phòng: ${lich['phong']}'),
                                Text('Sĩ số: ${lich['siSo']}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Đóng'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showEditLichDayForm(lich);
                                },
                                child: const Text('Sửa'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _deleteLichDay(lich['id']);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('Xóa', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
          ),
        );
      }).toList(),
    );
  }

  // Hiển thị Thời Khóa Biểu cho Sinh Viên
  Widget _buildThoiKhoaBieuForStudent() {
    final days = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: days.map((day) {
        final thoiKhoaTrongNgay = thoiKhoaBieu.where((item) => item['thu'] == day).toList();
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 3,
          child: ExpansionTile(
            leading: Icon(Icons.schedule, color: Colors.blue[900]),
            title: Text(
              '$day (${thoiKhoaTrongNgay.length} môn)',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            children: thoiKhoaTrongNgay.isEmpty
                ? [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Không có môn học'),
                    )
                  ]
                : thoiKhoaTrongNgay.map((tkb) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[900],
                        child: const Icon(Icons.school, color: Colors.white),
                      ),
                      title: Text(tkb['mon'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        '${tkb['gio'] ?? 'N/A'} | ${tkb['phong'] ?? 'N/A'}',
                      ),
                      trailing: Chip(
                        label: Text(tkb['giangVien']?.split(' ').last ?? 'N/A'),
                        backgroundColor: Colors.amber[100],
                      ),
                    );
                  }).toList(),
          ),
        );
      }).toList(),
    );
  }
}