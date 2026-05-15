import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  // Sample data để test
  final List<Map<String, dynamic>> sampleData = [
    {
      'mon': 'Chuyên đề tốt nghiệp 3',
      'maLop': 'CDTN3.03.K13.05.LH.C04.1_LT.1_TH',
      'gio': '07:00 - 09:30 (Tiết 1-3)',
      'phong': 'VNB 505',
      'giangVien': 'Lưu Thị Thảo',
      'thu': 'Thứ 2',
      'thuTu': 2,
      'siSo': 30,
      'id': '1',
    },
    {
      'mon': 'Chuyên đề tốt nghiệp 3',
      'maLop': 'CDTN3.03.K13.05.LH.C04.1_LT.1_TH',
      'gio': '07:00 - 09:30 (Tiết 1-3)',
      'phong': 'VNB 505',
      'giangVien': 'Lưu Thị Thảo',
      'thu': 'Thứ 4',
      'thuTu': 4,
      'siSo': 30,
      'id': '2',
    },
    {
      'mon': 'Chuyên đề tốt nghiệp 2',
      'maLop': 'CDTN2.03.K13.08.LH.C04.1_LT.1_TH',
      'gio': '13:00 - 15:30 (Tiết 7-9)',
      'phong': 'Có mặt VNB 504',
      'giangVien': 'Đặng Khánh Trung',
      'thu': 'Thứ 3',
      'thuTu': 3,
      'siSo': 28,
      'id': '3',
    },
    {
      'mon': 'Chuyên đề tốt nghiệp 2',
      'maLop': 'CDTN2.03.K13.08.LH.C04.1_LT.1_TH',
      'gio': '13:00 - 15:30 (Tiết 7-9)',
      'phong': 'Có mặt VNB 504',
      'giangVien': 'Đặng Khánh Trung',
      'thu': 'Thứ 5',
      'thuTu': 5,
      'siSo': 28,
      'id': '4',
    },
  ];

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
        // Admin: Lấy lịch dạy hoặc dùng sample data
        final schedule = await _databaseService.getAllLichDay();
        setState(() {
          lichDay = schedule.isNotEmpty ? schedule : sampleData;
          isLoading = false;
        });
      } else {
        // Sinh viên: Lấy thời khóa biểu hoặc dùng sample data
        try {
          final studentInfo = await _databaseService.getStudent(widget.userId);
          String maLop = studentInfo?['maLop'] ?? widget.userClass ?? '001';
          final schedule = await _databaseService.getThoiKhoaBieuWithId(maLop);
          setState(() {
            thoiKhoaBieu = schedule.isNotEmpty ? schedule : sampleData;
            isLoading = false;
          });
        } catch (e) {
          debugPrint('Lỗi load dữ liệu: $e');
          setState(() {
            thoiKhoaBieu = sampleData;
            isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint('❌ Lỗi load dữ liệu: $e');
      setState(() {
        thoiKhoaBieu = sampleData;
        isLoading = false;
      });
    }
  }

  // Lấy giờ học từ chuỗi "07:00-09:30"
  int _getStartHour(String timeStr) {
    try {
      return int.parse(timeStr.split('-')[0].split(':')[0]);
    } catch (e) {
      return 7;
    }
  }

  // Danh sách thứ trong tuần
  final List<String> thuTrongTuan = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];

  void showAddLichDayForm() {
    final TextEditingController monController = TextEditingController();
    final TextEditingController phongController = TextEditingController();
    final TextEditingController gioController = TextEditingController();
    final TextEditingController giangVienController = TextEditingController();
    final TextEditingController maLopController = TextEditingController();
    final TextEditingController siSoController = TextEditingController();
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
                initialValue: selectedThu,
                items: thuTrongTuan
                    .map((thu) => DropdownMenuItem(value: thu, child: Text(thu)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    selectedThu = val;
                  }
                },
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
                decoration: const InputDecoration(labelText: 'Giờ (VD: 07:00-09:30)'),
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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await _databaseService.addLichDay(
                  thu: selectedThu,
                  thuTu: thuTrongTuan.indexOf(selectedThu) + 2,
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
                debugPrint('❌ Lỗi lưu: $e');
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void showEditLichDayForm(Map<String, dynamic> lich) {
    final TextEditingController monController = TextEditingController(text: lich['mon'] ?? '');
    final TextEditingController phongController = TextEditingController(text: lich['phong'] ?? '');
    final TextEditingController gioController = TextEditingController(text: lich['gio'] ?? '');
    final TextEditingController giangVienController = TextEditingController(text: lich['giangVien'] ?? '');
    final TextEditingController maLopController = TextEditingController(text: lich['maLop'] ?? '');
    final TextEditingController siSoController = TextEditingController(text: '${lich['siSo'] ?? 0}');
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
                initialValue: selectedThu,
                items: thuTrongTuan
                    .map((thu) => DropdownMenuItem(value: thu, child: Text(thu)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    selectedThu = val;
                  }
                },
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
                decoration: const InputDecoration(labelText: 'Giờ (VD: 07:00-09:30)'),
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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await _databaseService.updateLichDay(lich['id'], {
                  'thu': selectedThu,
                  'thuTu': thuTrongTuan.indexOf(selectedThu) + 2,
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
                debugPrint('❌ Lỗi lưu: $e');
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void deleteLichDay(String docId) async {
    try {
      await _databaseService.deleteLichDay(docId);
      _loadData();
    } catch (e) {
      debugPrint('❌ Lỗi xóa: $e');
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
              onPressed: () => showAddLichDayForm(),
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
              : buildWeeklySchedule(displayData),
    );
  }

  // Xây dựng lịch theo tuần dạng grid
  Widget buildWeeklySchedule(List<Map<String, dynamic>> scheduleData) {
    final List<String> dayOrder = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];

    // Tính ngày thực tế bắt đầu từ thứ 2 tuần này
    DateTime now = DateTime.now();
    int daysToMonday = (now.weekday - 1) % 7; // 0 = Mon, 6 = Sun
    if (now.weekday == DateTime.sunday) {
      daysToMonday = 6;
    }
    DateTime weekStart = now.subtract(Duration(days: daysToMonday));

    // Tính ngày cho mỗi tuần
    final List<String> weekDates = List.generate(6, (index) {
      DateTime date = weekStart.add(Duration(days: index));
      return DateFormat('dd/MM/yyyy').format(date);
    });

    return Column(
      children: [
        // Header hiển thị tuần và ngày
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(
                width: 60,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.access_time, size: 24, color: Colors.grey),
                ),
              ),
              ...List.generate(6, (index) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayOrder[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          weekDates[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        
        // Lưới hiển thị các tiết học
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.grey[100],
              child: Column(
                children: List.generate(
                  13, // 13 tiết học trong ngày (7:00 - 19:00)
                  (hourIndex) {
                    int startHour = 7 + (hourIndex ~/ 2);
                    String timeLabel = '${startHour.toString().padLeft(2, '0')}:00';
                    
                    return SizedBox(
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Cột giờ
                          Container(
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!, width: 0.5),
                              color: Colors.grey[50],
                            ),
                            child: Center(
                              child: Text(
                                timeLabel,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          // Các cột ngày
                          ...List.generate(6, (dayIndex) {
                            String day = dayOrder[dayIndex];
                            
                            // Tìm lịch học cho ngày và giờ này
                            final Map<String, dynamic> lesson = scheduleData.firstWhere(
                              (item) {
                                if (item['thu'] != day) return false;
                                String gio = item['gio'] ?? '';
                                if (!gio.contains('-')) return false;
                                int itemHour = _getStartHour(gio);
                                return itemHour == startHour;
                              },
                              orElse: () => {},
                            );

                            bool hasLesson = lesson.isNotEmpty;

                            return Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!, width: 0.5),
                                ),
                                child: hasLesson
                                    ? buildLessonCard(lesson)
                                    : const SizedBox(),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Build lesson card
  Widget buildLessonCard(Map<String, dynamic> lesson) {
    Color cardColor = lesson['mon']?.toString().contains('3') == true 
        ? const Color(0xFF3B5998) 
        : const Color(0xFFF4A460);

    return GestureDetector(
      onTap: () => showLessonDetails(lesson),
      child: Container(
        color: cardColor,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                lesson['mon'] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: Text(
                '${lesson['gio'] ?? ''} - ${lesson['giangVien'] ?? ''}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Nút + và -
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.remove_circle, color: Colors.white, size: 12),
                  ),
                  const SizedBox(width: 2),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.check, color: Colors.white, size: 8),
                    ),
                  ),
                  const SizedBox(width: 2),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.add_circle, color: Colors.white, size: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLessonDetails(Map<String, dynamic> lesson) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Chi tiết lịch học'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Môn: ${lesson['mon']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Mã lớp: ${lesson['maLop']}'),
            Text('Giáo viên: ${lesson['giangVien']}'),
            Text('Giờ: ${lesson['gio']}'),
            Text('Phòng: ${lesson['phong']}'),
            if (lesson['siSo'] != null) Text('Sĩ số: ${lesson['siSo']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
          if (widget.userRole == 'admin') ...[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showEditLichDayForm(lesson);
              },
              child: const Text('Sửa'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                deleteLichDay(lesson['id']);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Xóa', style: TextStyle(color: Colors.white)),
            ),
          ],
        ],
      ),
    );
  }
}
