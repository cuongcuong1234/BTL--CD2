import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection names
  static const String accountsCollection = 'tai_khoan';
  static const String scheduleCollection = 'thoi_khoa_bieu';

  // Dữ liệu mẫu lịch học
  final List<Map<String, dynamic>> danhSachLichHocMau = [
    {'thu': 'Thứ 2', 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
    {'thu': 'Thứ 3', 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
    {'thu': 'Thứ 4', 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '13:30 - 15:30', 'giangVien': 'Cô Trần Thị B'},
    {'thu': 'Thứ 5', 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
    {'thu': 'Thứ 6', 'mon': 'Mạng máy tính', 'phong': 'P.305', 'gio': '08:00 - 10:00', 'giangVien': 'Thầy Lê Văn C'},
    {'thu': 'Thứ 7', 'mon': 'Mạng máy tính', 'phong': 'P.305', 'gio': '08:00 - 10:00', 'giangVien': 'Thầy Lê Văn C'},
  ];

  /// Tạo tài khoản admin mặc định (gọi một lần khi khởi tạo)
  Future<void> initializeDefaultAccounts() async {
    try {
      final adminSnap = await _firestore.collection(accountsCollection).doc('20224282').get();
      if (!adminSnap.exists) {
        // Tạo tài khoản admin mặc định
        await _firestore.collection(accountsCollection).doc('20224282').set({
          'maTaiKhoan': '20224282',
          'matKhau': '123456',
          'vaiTro': 'admin',
          'ngayTao': FieldValue.serverTimestamp(),
        });

        // Tạo các tài khoản sinh viên mặc định
        final studentsData = [
          {
            'maTaiKhoan': '20224047',
            'tenSV': 'Nguyễn Gia Khánh',
            'email': 'nguyenkhanh@gmail.com',
            'maLop': '001',
            'tenNganh': 'CNTT',
            'avatar': 'assets/avatar1.png',
            'color': 'purple'
          },
          {
            'maTaiKhoan': '20223882',
            'tenSV': 'Vũ Huy Khánh',
            'email': 'vukhanh@gmail.com',
            'maLop': '002',
            'tenNganh': 'KETOAN',
            'avatar': 'assets/avatar2.png',
            'color': 'grey'
          },
          {
            'maTaiKhoan': '20224997',
            'tenSV': 'Ngô Mạnh Kiên',
            'email': 'Manhkien@gmail.com',
            'maLop': '003',
            'tenNganh': 'CNTT',
            'avatar': 'assets/avatar3.png',
            'color': 'grey'
          },
          {
            'maTaiKhoan': '12345',
            'tenSV': 'Nguyễn Văn A',
            'email': 'van@gmail.com',
            'maLop': '001',
            'tenNganh': 'CNTT',
            'avatar': 'assets/avatar4.png',
            'color': 'grey'
          },
          {
            'maTaiKhoan': '42222',
            'tenSV': 'Nguyễn Văn B',
            'email': 'vanb@gmail.com',
            'maLop': '002',
            'tenNganh': 'KETOAN',
            'avatar': 'assets/avatar5.png',
            'color': 'grey'
          },
        ];

        for (var student in studentsData) {
          await _firestore
              .collection(accountsCollection)
              .doc(student['maTaiKhoan'] as String)
              .set({
                ...student,
                'matKhau': '123456',
                'vaiTro': 'student',
                'ngayTao': FieldValue.serverTimestamp(),
              });
        }

        print('✅ Đã tạo tài khoản mặc định');

        // ===== TẠO DỮ LIỆU THỜI KHÓA BIỂU MẶC ĐỊNH =====
        final thoiKhoaBieuDefaults = [
          // Lớp 001 (Nguyễn Gia Khánh, Nguyễn Văn A)
          {
            'maLop': '001',
            'thu': 'Thứ 2',
            'thuTu': 2,
            'mon': 'Lập trình Flutter',
            'phong': 'P.402',
            'gio': '07:30-09:30',
            'giangVien': 'Thầy Nguyễn Văn A'
          },
          {
            'maLop': '001',
            'thu': 'Thứ 3',
            'thuTu': 3,
            'mon': 'Lập trình Flutter',
            'phong': 'P.402',
            'gio': '07:30-09:30',
            'giangVien': 'Thầy Nguyễn Văn A'
          },
          {
            'maLop': '001',
            'thu': 'Thứ 4',
            'thuTu': 4,
            'mon': 'Cấu trúc dữ liệu',
            'phong': 'Lab 01',
            'gio': '13:30-15:30',
            'giangVien': 'Cô Trần Thị B'
          },
          {
            'maLop': '001',
            'thu': 'Thứ 5',
            'thuTu': 5,
            'mon': 'Cơ sở dữ liệu',
            'phong': 'P.305',
            'gio': '10:00-12:00',
            'giangVien': 'Thầy Lê Văn C'
          },
          {
            'maLop': '001',
            'thu': 'Thứ 7',
            'thuTu': 7,
            'mon': 'Mạng máy tính',
            'phong': 'P.410',
            'gio': '08:00-10:00',
            'giangVien': 'Thầy Hoàng Văn D'
          },

          // Lớp 002 (Vũ Huy Khánh, Nguyễn Văn B)
          {
            'maLop': '002',
            'thu': 'Thứ 2',
            'thuTu': 2,
            'mon': 'Cơ sở dữ liệu',
            'phong': 'P.305',
            'gio': '08:00-10:00',
            'giangVien': 'Thầy Lê Văn C'
          },
          {
            'maLop': '002',
            'thu': 'Thứ 3',
            'thuTu': 3,
            'mon': 'Mạng máy tính',
            'phong': 'P.410',
            'gio': '10:00-12:00',
            'giangVien': 'Thầy Hoàng Văn D'
          },
          {
            'maLop': '002',
            'thu': 'Thứ 4',
            'thuTu': 4,
            'mon': 'Lập trình C++',
            'phong': 'Lab 02',
            'gio': '07:30-09:30',
            'giangVien': 'Cô Ngô Thị E'
          },
          {
            'maLop': '002',
            'thu': 'Thứ 5',
            'thuTu': 5,
            'mon': 'Lập trình Flutter',
            'phong': 'P.402',
            'gio': '13:30-15:30',
            'giangVien': 'Thầy Nguyễn Văn A'
          },
          {
            'maLop': '002',
            'thu': 'Thứ 6',
            'thuTu': 6,
            'mon': 'Cấu trúc dữ liệu',
            'phong': 'Lab 01',
            'gio': '08:00-10:00',
            'giangVien': 'Cô Trần Thị B'
          },

          // Lớp 003 (Ngô Mạnh Kiên)
          {
            'maLop': '003',
            'thu': 'Thứ 2',
            'thuTu': 2,
            'mon': 'Lập trình Flutter',
            'phong': 'P.402',
            'gio': '10:00-12:00',
            'giangVien': 'Thầy Nguyễn Văn A'
          },
          {
            'maLop': '003',
            'thu': 'Thứ 3',
            'thuTu': 3,
            'mon': 'Cơ sở dữ liệu',
            'phong': 'P.305',
            'gio': '13:30-15:30',
            'giangVien': 'Thầy Lê Văn C'
          },
          {
            'maLop': '003',
            'thu': 'Thứ 4',
            'thuTu': 4,
            'mon': 'Mạng máy tính',
            'phong': 'P.410',
            'gio': '08:00-10:00',
            'giangVien': 'Thầy Hoàng Văn D'
          },
          {
            'maLop': '003',
            'thu': 'Thứ 5',
            'thuTu': 5,
            'mon': 'Cấu trúc dữ liệu',
            'phong': 'Lab 01',
            'gio': '10:00-12:00',
            'giangVien': 'Cô Trần Thị B'
          },
          {
            'maLop': '003',
            'thu': 'Thứ 6',
            'thuTu': 6,
            'mon': 'Lập trình C++',
            'phong': 'Lab 02',
            'gio': '13:30-15:30',
            'giangVien': 'Cô Ngô Thị E'
          },
        ];

        for (var item in thoiKhoaBieuDefaults) {
          await _firestore.collection(scheduleCollection).add(item);
        }

        print('✅ Đã tạo thời khóa biểu mặc định');
      }
    } catch (e) {
      print('❌ Lỗi khởi tạo tài khoản: $e');
    }
  }

  /// Kiểm tra đăng nhập
  Future<Map<String, dynamic>?> checkLogin(
    String username,
    String password,
  ) async {
    try {
      final docSnap =
          await _firestore.collection(accountsCollection).doc(username).get();

      if (!docSnap.exists) {
        return null;
      }

      final data = docSnap.data();

      // Kiểm tra mật khẩu
      if (data?['matKhau'] != password) {
        return null;
      }

      return data;
    } catch (e) {
      print('❌ Lỗi kiểm tra đăng nhập: $e');
      return null;
    }
  }

  /// Lấy danh sách tất cả sinh viên
  Future<List<Map<String, dynamic>>> getAllStudents() async {
    try {
      final querySnap = await _firestore
          .collection(accountsCollection)
          .where('vaiTro', isEqualTo: 'student')
          .get();

      return querySnap.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('❌ Lỗi lấy danh sách sinh viên: $e');
      return [];
    }
  }

  /// Lấy thông tin một sinh viên
  Future<Map<String, dynamic>?> getStudent(String studentId) async {
    try {
      final docSnap =
          await _firestore.collection(accountsCollection).doc(studentId).get();

      return docSnap.data();
    } catch (e) {
      print('❌ Lỗi lấy thông tin sinh viên: $e');
      return null;
    }
  }

  /// Thêm tài khoản mới
  Future<bool> addAccount({
    required String maTaiKhoan,
    required String matKhau,
    required String vaiTro,
    String? tenSV,
    String? email,
    String? maLop,
    String? tenNganh,
  }) async {
    try {
      // Kiểm tra tài khoản đã tồn tại
      final existing =
          await _firestore.collection(accountsCollection).doc(maTaiKhoan).get();
      if (existing.exists) {
        return false;
      }

      await _firestore.collection(accountsCollection).doc(maTaiKhoan).set({
        'maTaiKhoan': maTaiKhoan,
        'matKhau': matKhau,
        'vaiTro': vaiTro,
        if (tenSV != null) 'tenSV': tenSV,
        if (email != null) 'email': email,
        if (maLop != null) 'maLop': maLop,
        if (tenNganh != null) 'tenNganh': tenNganh,
        'ngayTao': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      print('❌ Lỗi thêm tài khoản: $e');
      return false;
    }
  }

  /// Cập nhật tài khoản
  Future<bool> updateAccount(
    String maTaiKhoan,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore
          .collection(accountsCollection)
          .doc(maTaiKhoan)
          .update(data);

      return true;
    } catch (e) {
      print('❌ Lỗi cập nhật tài khoản: $e');
      return false;
    }
  }

  /// Xóa tài khoản
  Future<bool> deleteAccount(String maTaiKhoan) async {
    try {
      // Không cho phép xóa tài khoản admin
      if (maTaiKhoan == '20224282') {
        return false;
      }

      await _firestore.collection(accountsCollection).doc(maTaiKhoan).delete();

      return true;
    } catch (e) {
      print('❌ Lỗi xóa tài khoản: $e');
      return false;
    }
  }

  /// Đổi mật khẩu
  Future<bool> changePassword(
    String maTaiKhoan,
    String matKhauCu,
    String matKhauMoi,
  ) async {
    try {
      final docSnap =
          await _firestore.collection(accountsCollection).doc(maTaiKhoan).get();

      if (!docSnap.exists) {
        return false;
      }

      if (docSnap.data()?['matKhau'] != matKhauCu) {
        return false;
      }

      await _firestore
          .collection(accountsCollection)
          .doc(maTaiKhoan)
          .update({'matKhau': matKhauMoi});

      return true;
    } catch (e) {
      print('❌ Lỗi đổi mật khẩu: $e');
      return false;
    }
  }

  /// Tìm kiếm tài khoản
  Future<List<Map<String, dynamic>>> searchAccounts(String keyword) async {
    try {
      final querySnap = await _firestore
          .collection(accountsCollection)
          .where('maTaiKhoan', isGreaterThanOrEqualTo: keyword)
          .where('maTaiKhoan', isLessThanOrEqualTo: '$keyword\uf8ff')
          .get();

      return querySnap.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('❌ Lỗi tìm kiếm tài khoản: $e');
      return [];
    }
  }

  /// ==================== ĐIỂM SỐ ====================
  /// Lấy điểm của một sinh viên
  Future<List<Map<String, dynamic>>> getDiemSV(String maSV) async {
    try {
      final querySnap = await _firestore
          .collection('diem')
          .where('maSV', isEqualTo: maSV)
          .get();
      return querySnap.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('❌ Lỗi lấy điểm: $e');
      return [];
    }
  }

  /// ==================== LỊCH HỌC ====================
  /// Lấy lịch học của sinh viên
  Future<List<Map<String, dynamic>>> getLichHocSV(String maSV) async {
    try {
      final querySnap = await _firestore
          .collection('lich_hoc')
          .where('maSV', isEqualTo: maSV)
          .get();
      
      // Sắp xếp dữ liệu theo thuTu trong Dart
      final lichHocList = querySnap.docs.map((doc) => doc.data()).toList();
      lichHocList.sort((a, b) => (a['thuTu'] as int).compareTo(b['thuTu'] as int));
      
      return lichHocList;
    } catch (e) {
      print('❌ Lỗi lấy lịch học: $e');
      return [];
    }
  }

  /// ==================== HỒ SƠ SINH VIÊN ====================
  /// Lấy hồ sơ sinh viên
  Future<Map<String, dynamic>?> getHoSoSV(String maSV) async {
    try {
      final docSnap = await _firestore.collection('ho_so').doc(maSV).get();
      return docSnap.data();
    } catch (e) {
      print('❌ Lỗi lấy hồ sơ: $e');
      return null;
    }
  }

  /// Cập nhật hồ sơ sinh viên
  Future<bool> updateHoSoSV(
    String maSV,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore
          .collection('ho_so')
          .doc(maSV)
          .update(data);

      print('✅ Đã cập nhật hồ sơ sinh viên');
      return true;
    } catch (e) {
      print('❌ Lỗi cập nhật hồ sơ: $e');
      return false;
    }
  }

  /// Tạo hồ sơ sinh viên mới
  Future<bool> createHoSoSV(
    String maSV,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore
          .collection('ho_so')
          .doc(maSV)
          .set(data);

      print('✅ Đã tạo hồ sơ sinh viên mới');
      return true;
    } catch (e) {
      print('❌ Lỗi tạo hồ sơ: $e');
      return false;
    }
  }

  /// ==================== THỜI KHÓA BIỂU ====================
  /// Lấy thời khóa biểu của lớp (với docId)
  Future<List<Map<String, dynamic>>> getThoiKhoaBieuWithId(String maLop) async {
    try {
      final querySnap = await _firestore
          .collection('thoi_khoa_bieu')
          .where('maLop', isEqualTo: maLop)
          .orderBy('thuTu')
          .get();
      return querySnap.docs
          .map((doc) => {...doc.data(), 'id': doc.id})
          .toList();
    } catch (e) {
      print('❌ Lỗi lấy thời khóa biểu: $e');
      return [];
    }
  }

  /// Lấy thời khóa biểu của lớp
  Future<List<Map<String, dynamic>>> getThoiKhoaBieu(String maLop) async {
    try {
      final querySnap = await _firestore
          .collection('thoi_khoa_bieu')
          .where('maLop', isEqualTo: maLop)
          .orderBy('thuTu')
          .get();
      return querySnap.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('❌ Lỗi lấy thời khóa biểu: $e');
      return [];
    }
  }

  /// Xóa lớp học từ thời khóa biểu
  Future<bool> deleteThoiKhoaBieu(String docId) async {
    try {
      await _firestore.collection('thoi_khoa_bieu').doc(docId).delete();
      print('✅ Đã xóa thời khóa biểu');
      return true;
    } catch (e) {
      print('❌ Lỗi xóa thời khóa biểu: $e');
      return false;
    }
  }

  /// Cập nhật lớp học trong thời khóa biểu
  Future<bool> updateThoiKhoaBieu(
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection('thoi_khoa_bieu').doc(docId).update(data);
      print('✅ Đã cập nhật thời khóa biểu');
      return true;
    } catch (e) {
      print('❌ Lỗi cập nhật thời khóa biểu: $e');
      return false;
    }
  }

  /// ==================== KHỞI TẠO DỮ LIỆU MẪU ====================
  /// Tạo dữ liệu mẫu cho điểm, lịch học, hồ sơ, thời khóa biểu
  Future<void> initializeDefaultData() async {
    try {
      // Kiểm tra xem đã tạo dữ liệu chưa
      final diemSnap = await _firestore.collection('diem').limit(1).get();
      if (diemSnap.docs.isNotEmpty) return;

      // ===== DỮ LIỆU ĐIỂM (Khác nhau cho mỗi sinh viên) =====
      final diemTheoSV = {
        '20224047': [
          {'mon': 'Lập trình Flutter', 'diem': 8.5},
          {'mon': 'Cấu trúc dữ liệu', 'diem': 8.2},
          {'mon': 'Cơ sở dữ liệu', 'diem': 7.9},
          {'mon': 'Mạng máy tính', 'diem': 8.0},
          {'mon': 'Lập trình C++', 'diem': 7.8},
        ],
        '20223882': [
          {'mon': 'Lập trình Flutter', 'diem': 7.5},
          {'mon': 'Cấu trúc dữ liệu', 'diem': 8.8},
          {'mon': 'Cơ sở dữ liệu', 'diem': 8.5},
          {'mon': 'Mạng máy tính', 'diem': 9.0},
          {'mon': 'Lập trình C++', 'diem': 8.3},
        ],
        '20224997': [
          {'mon': 'Lập trình Flutter', 'diem': 9.0},
          {'mon': 'Cấu trúc dữ liệu', 'diem': 7.5},
          {'mon': 'Cơ sở dữ liệu', 'diem': 8.0},
          {'mon': 'Mạng máy tính', 'diem': 7.8},
          {'mon': 'Lập trình C++', 'diem': 8.2},
        ],
        '12345': [
          {'mon': 'Lập trình Flutter', 'diem': 6.5},
          {'mon': 'Cấu trúc dữ liệu', 'diem': 7.0},
          {'mon': 'Cơ sở dữ liệu', 'diem': 7.2},
          {'mon': 'Mạng máy tính', 'diem': 6.8},
          {'mon': 'Lập trình C++', 'diem': 7.5},
        ],
        '42222': [
          {'mon': 'Lập trình Flutter', 'diem': 8.8},
          {'mon': 'Cấu trúc dữ liệu', 'diem': 8.5},
          {'mon': 'Cơ sở dữ liệu', 'diem': 9.0},
          {'mon': 'Mạng máy tính', 'diem': 8.5},
          {'mon': 'Lập trình C++', 'diem': 8.0},
        ],
      };

      for (var maSV in diemTheoSV.keys) {
        for (var subject in diemTheoSV[maSV]!) {
          await _firestore.collection('diem').add({
            'maSV': maSV,
            'mon': subject['mon'],
            'diem': subject['diem'],
            'hocKy': 'HK1-2026',
            'namHoc': '2025-2026',
          });
        }
      }

      // ===== DỮ LIỆU HỒ SƠ =====
      final studentProfiles = [
        {
          'maSV': '20224047',
          'tenSV': 'Nguyễn Gia Khánh',
          'ngaySinh': '15/05/2005',
          'gioiTinh': 'Nữ',
          'queQuan': 'Hà Nội',
          'sdt': '0912345678',
          'email': 'nguyenkhanh@gmail.com',
          'diaChi': '123 Đường A, Quận 1, TP.HCM',
          'danToc': 'Kinh',
          'tonGiao': 'Không',
          'cmnd': '123456789',
          'ngayCapCmnd': '01/01/2023',
        },
        {
          'maSV': '20223882',
          'tenSV': 'Vũ Huy Khánh',
          'ngaySinh': '22/08/2004',
          'gioiTinh': 'Nam',
          'queQuan': 'Hà Nam',
          'sdt': '0987654321',
          'email': 'vukhanh@gmail.com',
          'diaChi': '456 Đường B, Quận 2, TP.HCM',
          'danToc': 'Kinh',
          'tonGiao': 'Không',
          'cmnd': '987654321',
          'ngayCapCmnd': '15/06/2023',
        },
        {
          'maSV': '20224997',
          'tenSV': 'Ngô Mạnh Kiên',
          'ngaySinh': '10/12/2005',
          'gioiTinh': 'Nam',
          'queQuan': 'Bắc Ninh',
          'sdt': '0911111111',
          'email': 'Manhkien@gmail.com',
          'diaChi': '789 Đường C, Quận 3, TP.HCM',
          'danToc': 'Kinh',
          'tonGiao': 'Không',
          'cmnd': '111111111',
          'ngayCapCmnd': '20/09/2023',
        },
        {
          'maSV': '12345',
          'tenSV': 'Nguyễn Văn A',
          'ngaySinh': '03/07/2005',
          'gioiTinh': 'Nam',
          'queQuan': 'Sài Gòn',
          'sdt': '0922222222',
          'email': 'van@gmail.com',
          'diaChi': '321 Đường D, Quận 4, TP.HCM',
          'danToc': 'Kinh',
          'tonGiao': 'Không',
          'cmnd': '222222222',
          'ngayCapCmnd': '10/03/2023',
        },
        {
          'maSV': '42222',
          'tenSV': 'Nguyễn Văn B',
          'ngaySinh': '18/11/2004',
          'gioiTinh': 'Nam',
          'queQuan': 'Đồng Nai',
          'sdt': '0933333333',
          'email': 'vanb@gmail.com',
          'diaChi': '654 Đường E, Quận 5, TP.HCM',
          'danToc': 'Kinh',
          'tonGiao': 'Không',
          'cmnd': '333333333',
          'ngayCapCmnd': '25/07/2023',
        },
      ];

      for (var profile in studentProfiles) {
        await _firestore.collection('ho_so').doc(profile['maSV'] as String).set(profile);
      }

      // ===== DỮ LIỆU LỊCH HỌC =====
      final lichHoc = [
        // Lịch học für sinh viên 20224047
        {'maSV': '20224047', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '20224047', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '20224047', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '13:30 - 15:30', 'giangVien': 'Cô Trần Thị B'},
        {'maSV': '20224047', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '10:00 - 12:00', 'giangVien': 'Thầy Lê Văn C'},
        {'maSV': '20224047', 'thu': 'Thứ 6', 'thuTu': 6, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '14:00 - 16:00', 'giangVien': 'Thầy Hoàng Văn D'},
        
        // Lịch học cho sinh viên 20223882
        {'maSV': '20223882', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '08:00 - 10:00', 'giangVien': 'Thầy Lê Văn C'},
        {'maSV': '20223882', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '10:00 - 12:00', 'giangVien': 'Thầy Hoàng Văn D'},
        {'maSV': '20223882', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Lập trình C++', 'phong': 'Lab 02', 'gio': '07:30 - 09:30', 'giangVien': 'Cô Ngô Thị E'},
        {'maSV': '20223882', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '13:30 - 15:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '20223882', 'thu': 'Thứ 7', 'thuTu': 7, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '08:00 - 10:00', 'giangVien': 'Cô Trần Thị B'},
        
        // Lịch học cho sinh viên 20224997
        {'maSV': '20224997', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '10:00 - 12:00', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '20224997', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '13:30 - 15:30', 'giangVien': 'Thầy Lê Văn C'},
        {'maSV': '20224997', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '08:00 - 10:00', 'giangVien': 'Thầy Hoàng Văn D'},
        {'maSV': '20224997', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '10:00 - 12:00', 'giangVien': 'Cô Trần Thị B'},
        {'maSV': '20224997', 'thu': 'Thứ 6', 'thuTu': 6, 'mon': 'Lập trình C++', 'phong': 'Lab 02', 'gio': '13:30 - 15:30', 'giangVien': 'Cô Ngô Thị E'},
        
        // Lịch học cho sinh viên 12345
        {'maSV': '12345', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Hoàng Văn D'},
        {'maSV': '12345', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Lập trình C++', 'phong': 'Lab 02', 'gio': '10:00 - 12:00', 'giangVien': 'Cô Ngô Thị E'},
        {'maSV': '12345', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '13:30 - 15:30', 'giangVien': 'Thầy Lê Văn C'},
        {'maSV': '12345', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '12345', 'thu': 'Thứ 6', 'thuTu': 6, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '10:00 - 12:00', 'giangVien': 'Cô Trần Thị B'},
        
        // Lịch học cho sinh viên 42222
        {'maSV': '42222', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '08:00 - 10:00', 'giangVien': 'Cô Trần Thị B'},
        {'maSV': '42222', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '10:00 - 12:00', 'giangVien': 'Thầy Hoàng Văn D'},
        {'maSV': '42222', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '13:30 - 15:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '42222', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Lập trình C++', 'phong': 'Lab 02', 'gio': '07:30 - 09:30', 'giangVien': 'Cô Ngô Thị E'},
        {'maSV': '42222', 'thu': 'Thứ 7', 'thuTu': 7, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '10:00 - 12:00', 'giangVien': 'Thầy Lê Văn C'},
      ];

      for (var item in lichHoc) {
        await _firestore.collection('lich_hoc').add(item);
      }

      // ===== DỮ LIỆU THỜI KHÓA BIỂU (Khác nhau cho mỗi lớp) =====
      final thoiKhoaBieu = [
        // Lớp 001 (Nguyễn Gia Khánh, Nguyễn Văn A)
        {'maLop': '001', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30-09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maLop': '001', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30-09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maLop': '001', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '13:30-15:30', 'giangVien': 'Cô Trần Thị B'},
        {'maLop': '001', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '10:00-12:00', 'giangVien': 'Thầy Lê Văn C'},
        {'maLop': '001', 'thu': 'Thứ 7', 'thuTu': 7, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '08:00-10:00', 'giangVien': 'Thầy Hoàng Văn D'},
        
        // Lớp 002 (Vũ Huy Khánh, Nguyễn Văn B)
        {'maLop': '002', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '08:00-10:00', 'giangVien': 'Thầy Lê Văn C'},
        {'maLop': '002', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '10:00-12:00', 'giangVien': 'Thầy Hoàng Văn D'},
        {'maLop': '002', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Lập trình C++', 'phong': 'Lab 02', 'gio': '07:30-09:30', 'giangVien': 'Cô Ngô Thị E'},
        {'maLop': '002', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '13:30-15:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maLop': '002', 'thu': 'Thứ 6', 'thuTu': 6, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '08:00-10:00', 'giangVien': 'Cô Trần Thị B'},
        
        // Lớp 003 (Ngô Mạnh Kiên)
        {'maLop': '003', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '10:00-12:00', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maLop': '003', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '13:30-15:30', 'giangVien': 'Thầy Lê Văn C'},
        {'maLop': '003', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '08:00-10:00', 'giangVien': 'Thầy Hoàng Văn D'},
        {'maLop': '003', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '10:00-12:00', 'giangVien': 'Cô Trần Thị B'},
        {'maLop': '003', 'thu': 'Thứ 6', 'thuTu': 6, 'mon': 'Lập trình C++', 'phong': 'Lab 02', 'gio': '13:30-15:30', 'giangVien': 'Cô Ngô Thị E'},
      ];

      for (var item in thoiKhoaBieu) {
        await _firestore.collection('thoi_khoa_bieu').add(item);
      }

      print('✅ Đã tạo dữ liệu mẫu');
    } catch (e) {
      print('❌ Lỗi tạo dữ liệu mẫu: $e');
    }
  }

  /// Xoá và tạo lại dữ liệu (điểm, lịch học, thời khóa biểu) cho tất cả sinh viên
  Future<void> reinitializeScheduleData() async {
    try {
      // Xoá tất cả dữ liệu cũ
      final collections = ['diem', 'lich_hoc', 'thoi_khoa_bieu'];
      for (var collection in collections) {
        final oldDocs = await _firestore.collection(collection).get();
        for (var doc in oldDocs.docs) {
          await doc.reference.delete();
        }
      }
      print('✅ Đã xoá dữ liệu cũ');

      // ===== TẠO LẠI DỮ LIỆU ĐIỂM =====
      final diemTheoSV = {
        '20224047': [
          {'mon': 'Lập trình Flutter', 'diem': 8.5},
          {'mon': 'Cấu trúc dữ liệu', 'diem': 8.2},
          {'mon': 'Cơ sở dữ liệu', 'diem': 7.9},
          {'mon': 'Mạng máy tính', 'diem': 8.0},
          {'mon': 'Lập trình C++', 'diem': 7.8},
        ],
        '20223882': [
          {'mon': 'Lập trình Flutter', 'diem': 7.5},
          {'mon': 'Cấu trúc dữ liệu', 'diem': 8.8},
          {'mon': 'Cơ sở dữ liệu', 'diem': 8.5},
          {'mon': 'Mạng máy tính', 'diem': 9.0},
          {'mon': 'Lập trình C++', 'diem': 8.3},
        ],
        '20224997': [
          {'mon': 'Lập trình Flutter', 'diem': 9.0},
          {'mon': 'Cấu trúc dữ liệu', 'diem': 7.5},
          {'mon': 'Cơ sở dữ liệu', 'diem': 8.0},
          {'mon': 'Mạng máy tính', 'diem': 7.8},
          {'mon': 'Lập trình C++', 'diem': 8.2},
        ],
        '12345': [
          {'mon': 'Lập trình Flutter', 'diem': 6.5},
          {'mon': 'Cấu trúc dữ liệu', 'diem': 7.0},
          {'mon': 'Cơ sở dữ liệu', 'diem': 7.2},
          {'mon': 'Mạng máy tính', 'diem': 6.8},
          {'mon': 'Lập trình C++', 'diem': 7.5},
        ],
        '42222': [
          {'mon': 'Lập trình Flutter', 'diem': 8.8},
          {'mon': 'Cấu trúc dữ liệu', 'diem': 8.5},
          {'mon': 'Cơ sở dữ liệu', 'diem': 9.0},
          {'mon': 'Mạng máy tính', 'diem': 8.5},
          {'mon': 'Lập trình C++', 'diem': 8.0},
        ],
      };

      for (var maSV in diemTheoSV.keys) {
        for (var subject in diemTheoSV[maSV]!) {
          await _firestore.collection('diem').add({
            'maSV': maSV,
            'mon': subject['mon'],
            'diem': subject['diem'],
            'hocKy': 'HK1-2026',
            'namHoc': '2025-2026',
          });
        }
      }
      print('✅ Đã tạo dữ liệu điểm mới');

      // ===== TẠO LẠI DỮ LIỆU LỊCH HỌC =====
      final lichHoc = [
        // Lịch học cho sinh viên 20224047 (Lớp 001)
        {'maSV': '20224047', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '20224047', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '20224047', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '13:30 - 15:30', 'giangVien': 'Cô Trần Thị B'},
        {'maSV': '20224047', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '10:00 - 12:00', 'giangVien': 'Thầy Lê Văn C'},
        {'maSV': '20224047', 'thu': 'Thứ 7', 'thuTu': 7, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '08:00 - 10:00', 'giangVien': 'Thầy Hoàng Văn D'},
        
        // Lịch học cho sinh viên 20223882 (Lớp 002)
        {'maSV': '20223882', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '08:00 - 10:00', 'giangVien': 'Thầy Lê Văn C'},
        {'maSV': '20223882', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '10:00 - 12:00', 'giangVien': 'Thầy Hoàng Văn D'},
        {'maSV': '20223882', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Lập trình C++', 'phong': 'Lab 02', 'gio': '07:30 - 09:30', 'giangVien': 'Cô Ngô Thị E'},
        {'maSV': '20223882', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '13:30 - 15:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '20223882', 'thu': 'Thứ 6', 'thuTu': 6, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '08:00 - 10:00', 'giangVien': 'Cô Trần Thị B'},
        
        // Lịch học cho sinh viên 20224997 (Lớp 003)
        {'maSV': '20224997', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '10:00 - 12:00', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '20224997', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '13:30 - 15:30', 'giangVien': 'Thầy Lê Văn C'},
        {'maSV': '20224997', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '08:00 - 10:00', 'giangVien': 'Thầy Hoàng Văn D'},
        {'maSV': '20224997', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '10:00 - 12:00', 'giangVien': 'Cô Trần Thị B'},
        {'maSV': '20224997', 'thu': 'Thứ 6', 'thuTu': 6, 'mon': 'Lập trình C++', 'phong': 'Lab 02', 'gio': '13:30 - 15:30', 'giangVien': 'Cô Ngô Thị E'},
        
        // Lịch học cho sinh viên 12345 (Lớp 001)
        {'maSV': '12345', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '12345', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30 - 09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '12345', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '13:30 - 15:30', 'giangVien': 'Cô Trần Thị B'},
        {'maSV': '12345', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '10:00 - 12:00', 'giangVien': 'Thầy Lê Văn C'},
        {'maSV': '12345', 'thu': 'Thứ 7', 'thuTu': 7, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '08:00 - 10:00', 'giangVien': 'Thầy Hoàng Văn D'},
        
        // Lịch học cho sinh viên 42222 (Lớp 002)
        {'maSV': '42222', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '08:00 - 10:00', 'giangVien': 'Thầy Lê Văn C'},
        {'maSV': '42222', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '10:00 - 12:00', 'giangVien': 'Thầy Hoàng Văn D'},
        {'maSV': '42222', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Lập trình C++', 'phong': 'Lab 02', 'gio': '07:30 - 09:30', 'giangVien': 'Cô Ngô Thị E'},
        {'maSV': '42222', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '13:30 - 15:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maSV': '42222', 'thu': 'Thứ 6', 'thuTu': 6, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '08:00 - 10:00', 'giangVien': 'Cô Trần Thị B'},
      ];

      for (var item in lichHoc) {
        await _firestore.collection('lich_hoc').add(item);
      }
      print('✅ Đã tạo dữ liệu lịch học mới');

      // ===== TẠO LẠI DỮ LIỆU THỜI KHÓA BIỂU (20 MẪU) =====
      final thoiKhoaBieu = [
        // Lớp 001 - Thứ 2 (5 môn)
        {'maLop': '001', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Lập trình Flutter', 'phong': 'P.402', 'gio': '07:30-09:30', 'giangVien': 'Thầy Nguyễn Văn A'},
        {'maLop': '001', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Cấu trúc dữ liệu', 'phong': 'Lab 01', 'gio': '09:45-11:45', 'giangVien': 'Cô Trần Thị B'},
        {'maLop': '001', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Cơ sở dữ liệu', 'phong': 'P.305', 'gio': '13:00-15:00', 'giangVien': 'Thầy Lê Văn C'},
        {'maLop': '001', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Mạng máy tính', 'phong': 'P.410', 'gio': '15:15-17:15', 'giangVien': 'Thầy Hoàng Văn D'},
        {'maLop': '001', 'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Lập trình C++', 'phong': 'Lab 02', 'gio': '17:30-19:30', 'giangVien': 'Cô Ngô Thị E'},
        
        // Lớp 002 - Thứ 3 (5 môn)
        {'maLop': '002', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Hệ điều hành', 'phong': 'P.405', 'gio': '07:30-09:30', 'giangVien': 'Thầy Phạm Văn F'},
        {'maLop': '002', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Phát triển web', 'phong': 'P.407', 'gio': '09:45-11:45', 'giangVien': 'Cô Dương Thị G'},
        {'maLop': '002', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'An ninh thông tin', 'phong': 'P.301', 'gio': '13:00-15:00', 'giangVien': 'Thầy Tô Văn H'},
        {'maLop': '002', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Thiết kế cơ sở dữ liệu', 'phong': 'Lab 03', 'gio': '15:15-17:15', 'giangVien': 'Cô Vũ Thị I'},
        {'maLop': '002', 'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Tương tác người dùng', 'phong': 'P.408', 'gio': '17:30-19:30', 'giangVien': 'Thầy Bùi Văn K'},
        
        // Lớp 003 - Thứ 4 (5 môn)
        {'maLop': '003', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Trí tuệ nhân tạo', 'phong': 'P.501', 'gio': '07:30-09:30', 'giangVien': 'Thầy Đặng Văn L'},
        {'maLop': '003', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Khoa học dữ liệu', 'phong': 'Lab 04', 'gio': '09:45-11:45', 'giangVien': 'Cô Lâm Thị M'},
        {'maLop': '003', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Máy học', 'phong': 'P.502', 'gio': '13:00-15:00', 'giangVien': 'Thầy Trương Văn N'},
        {'maLop': '003', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Xử lý ảnh kỹ thuật số', 'phong': 'Lab 05', 'gio': '15:15-17:15', 'giangVien': 'Cô Trịnh Thị O'},
        {'maLop': '003', 'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Đồ họa máy tính', 'phong': 'P.503', 'gio': '17:30-19:30', 'giangVien': 'Thầy Đoàn Văn P'},
        
        // Lớp 001 - Thứ 5 (5 môn)
        {'maLop': '001', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Kiến trúc máy tính', 'phong': 'P.404', 'gio': '07:30-09:30', 'giangVien': 'Thầy Giang Văn Q'},
        {'maLop': '001', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Lập trình song song', 'phong': 'Lab 06', 'gio': '09:45-11:45', 'giangVien': 'Cô Hà Thị R'},
        {'maLop': '001', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Điện toán đám mây', 'phong': 'P.504', 'gio': '13:00-15:00', 'giangVien': 'Thầy Hoàng Văn S'},
        {'maLop': '001', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Lập trình mobile', 'phong': 'P.406', 'gio': '15:15-17:15', 'giangVien': 'Cô Thảo Thị T'},
        {'maLop': '001', 'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Quản lý dự án phần mềm', 'phong': 'P.505', 'gio': '17:30-19:30', 'giangVien': 'Thầy Vinh Văn U'},
      ];

      for (var item in thoiKhoaBieu) {
        await _firestore.collection('thoi_khoa_bieu').add(item);
      }

      print('✅ Đã tạo dữ liệu thời khóa biểu mới');

      // ===== TẠO LẠI DỮ LIỆU LỊCH DẠY (20 MẪU - CHO ADMIN) =====
      final lichDay = [
        // Thứ 2 (4 lịch dạy)
        {'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Lập trình Flutter', 'maLop': '001', 'phong': 'P.402', 'gio': '07:30-09:30', 'giangVien': 'Thầy Nguyễn Văn A', 'siSo': 45},
        {'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Cấu trúc dữ liệu', 'maLop': '001', 'phong': 'Lab 01', 'gio': '09:45-11:45', 'giangVien': 'Cô Trần Thị B', 'siSo': 30},
        {'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'Hệ điều hành', 'maLop': '002', 'phong': 'P.405', 'gio': '13:00-15:00', 'giangVien': 'Thầy Phạm Văn F', 'siSo': 50},
        {'thu': 'Thứ 2', 'thuTu': 2, 'mon': 'An ninh thông tin', 'maLop': '003', 'phong': 'P.301', 'gio': '15:15-17:15', 'giangVien': 'Thầy Tô Văn H', 'siSo': 40},
        
        // Thứ 3 (4 lịch dạy)
        {'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Cơ sở dữ liệu', 'maLop': '001', 'phong': 'P.305', 'gio': '07:30-09:30', 'giangVien': 'Thầy Lê Văn C', 'siSo': 45},
        {'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Phát triển web', 'maLop': '002', 'phong': 'P.407', 'gio': '09:45-11:45', 'giangVien': 'Cô Dương Thị G', 'siSo': 42},
        {'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Khoa học dữ liệu', 'maLop': '003', 'phong': 'Lab 04', 'gio': '13:00-15:00', 'giangVien': 'Cô Lâm Thị M', 'siSo': 35},
        {'thu': 'Thứ 3', 'thuTu': 3, 'mon': 'Tương tác người dùng', 'maLop': '002', 'phong': 'P.408', 'gio': '17:30-19:30', 'giangVien': 'Thầy Bùi Văn K', 'siSo': 48},
        
        // Thứ 4 (4 lịch dạy)
        {'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Mạng máy tính', 'maLop': '001', 'phong': 'P.410', 'gio': '07:30-09:30', 'giangVien': 'Thầy Hoàng Văn D', 'siSo': 46},
        {'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Lập trình C++', 'maLop': '002', 'phong': 'Lab 02', 'gio': '09:45-11:45', 'giangVien': 'Cô Ngô Thị E', 'siSo': 32},
        {'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Trí tuệ nhân tạo', 'maLop': '003', 'phong': 'P.501', 'gio': '13:00-15:00', 'giangVien': 'Thầy Đặng Văn L', 'siSo': 38},
        {'thu': 'Thứ 4', 'thuTu': 4, 'mon': 'Xử lý ảnh kỹ thuật số', 'maLop': '003', 'phong': 'Lab 05', 'gio': '15:15-17:15', 'giangVien': 'Cô Trịnh Thị O', 'siSo': 28},
        
        // Thứ 5 (4 lịch dạy)
        {'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Lập trình Flutter', 'maLop': '002', 'phong': 'P.402', 'gio': '07:30-09:30', 'giangVien': 'Thầy Nguyễn Văn A', 'siSo': 44},
        {'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Thiết kế cơ sở dữ liệu', 'maLop': '002', 'phong': 'Lab 03', 'gio': '09:45-11:45', 'giangVien': 'Cô Vũ Thị I', 'siSo': 33},
        {'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Kiến trúc máy tính', 'maLop': '001', 'phong': 'P.404', 'gio': '13:00-15:00', 'giangVien': 'Thầy Giang Văn Q', 'siSo': 47},
        {'thu': 'Thứ 5', 'thuTu': 5, 'mon': 'Máy học', 'maLop': '003', 'phong': 'P.502', 'gio': '15:15-17:15', 'giangVien': 'Thầy Trương Văn N', 'siSo': 36},
        
        // Thứ 6 (2 lịch dạy)
        {'thu': 'Thứ 6', 'thuTu': 6, 'mon': 'Lập trình song song', 'maLop': '001', 'phong': 'Lab 06', 'gio': '07:30-09:30', 'giangVien': 'Cô Hà Thị R', 'siSo': 29},
        {'thu': 'Thứ 6', 'thuTu': 6, 'mon': 'Đồ họa máy tính', 'maLop': '003', 'phong': 'P.503', 'gio': '13:00-15:00', 'giangVien': 'Thầy Đoàn Văn P', 'siSo': 34},
      ];

      for (var item in lichDay) {
        await _firestore.collection('lich_day').add(item);
      }

      print('✅ Đã tạo dữ liệu lịch dạy mới');
    } catch (e) {
      print('❌ Lỗi tạo lại dữ liệu: $e');
    }
  }

  /// ==================== THÊMHDỮ LIỆU MỚI ====================
  /// Thêm lịch học mới
  Future<bool> addLichHoc({
    required String maSV,
    required String thu,
    required int ordinal,
    required String mon,
    required String phong,
    required String gio,
    required String giangVien,
  }) async {
    try {
      await _firestore.collection('lich_hoc').add({
        'maSV': maSV,
        'thu': thu,
        'thuTu': ordinal,
        'mon': mon,
        'phong': phong,
        'gio': gio,
        'giangVien': giangVien,
      });
      print('✅ Đã thêm lịch học mới');
      return true;
    } catch (e) {
      print('❌ Lỗi thêm lịch học: $e');
      return false;
    }
  }

  /// Thêm điểm mới
  Future<bool> addDiem({
    required String maSV,
    required String mon,
    required double diem,
    String hocKy = 'HK1-2026',
    String namHoc = '2025-2026',
  }) async {
    try {
      await _firestore.collection('diem').add({
        'maSV': maSV,
        'mon': mon,
        'diem': diem,
        'hocKy': hocKy,
        'namHoc': namHoc,
      });
      print('✅ Đã thêm điểm mới');
      return true;
    } catch (e) {
      print('❌ Lỗi thêm điểm: $e');
      return false;
    }
  }

  /// Thêm thời khóa biểu mới
  Future<bool> addThoiKhoaBieu({
    required String maLop,
    required String thu,
    required int ordinal,
    required String mon,
    required String phong,
    required String gio,
    required String giangVien,
  }) async {
    try {
      await _firestore.collection('thoi_khoa_bieu').add({
        'maLop': maLop,
        'thu': thu,
        'thuTu': ordinal,
        'mon': mon,
        'phong': phong,
        'gio': gio,
        'giangVien': giangVien,
      });
      print('✅ Đã thêm thời khóa biểu mới');
      return true;
    } catch (e) {
      print('❌ Lỗi thêm thời khóa biểu: $e');
      return false;
    }
  }

  /// Xóa lịch học
  Future<bool> deleteLichHoc(String docId) async {
    try {
      await _firestore.collection('lich_hoc').doc(docId).delete();
      print('✅ Đã xóa lịch học');
      return true;
    } catch (e) {
      print('❌ Lỗi xóa lịch học: $e');
      return false;
    }
  }

  /// Cập nhật lịch học
  Future<bool> updateLichHoc(
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection('lich_hoc').doc(docId).update(data);
      print('✅ Đã cập nhật lịch học');
      return true;
    } catch (e) {
      print('❌ Lỗi cập nhật lịch học: $e');
      return false;
    }
  }

  /// ==================== LỊCH DẠY (ADMIN) ====================
  /// Lấy lịch dạy theo ngày (Thứ)
  Future<List<Map<String, dynamic>>> getLichDayByDay(String thu) async {
    try {
      final querySnap = await _firestore
          .collection('lich_day')
          .where('thu', isEqualTo: thu)
          .orderBy('gio')
          .get();
      return querySnap.docs
          .map((doc) => {...doc.data(), 'id': doc.id})
          .toList();
    } catch (e) {
      print('❌ Lỗi lấy lịch dạy theo ngày: $e');
      return [];
    }
  }

  /// Lấy tất cả lịch dạy
  Future<List<Map<String, dynamic>>> getAllLichDay() async {
    try {
      final querySnap = await _firestore
          .collection('lich_day')
          .orderBy('thuTu')
          .get();
      return querySnap.docs
          .map((doc) => {...doc.data(), 'id': doc.id})
          .toList();
    } catch (e) {
      print('❌ Lỗi lấy tất cả lịch dạy: $e');
      return [];
    }
  }

  /// Lấy lịch dạy theo lớp
  Future<List<Map<String, dynamic>>> getLichDayByLop(String maLop) async {
    try {
      final querySnap = await _firestore
          .collection('lich_day')
          .where('maLop', isEqualTo: maLop)
          .orderBy('thuTu')
          .get();
      return querySnap.docs
          .map((doc) => {...doc.data(), 'id': doc.id})
          .toList();
    } catch (e) {
      print('❌ Lỗi lấy lịch dạy theo lớp: $e');
      return [];
    }
  }

  /// Thêm lịch dạy mới
  Future<bool> addLichDay({
    required String thu,
    required int thuTu,
    required String mon,
    required String maLop,
    required String phong,
    required String gio,
    required String giangVien,
    required int siSo,
  }) async {
    try {
      await _firestore.collection('lich_day').add({
        'thu': thu,
        'thuTu': thuTu,
        'mon': mon,
        'maLop': maLop,
        'phong': phong,
        'gio': gio,
        'giangVien': giangVien,
        'siSo': siSo,
      });
      print('✅ Đã thêm lịch dạy mới');
      return true;
    } catch (e) {
      print('❌ Lỗi thêm lịch dạy: $e');
      return false;
    }
  }

  /// Xóa lịch dạy
  Future<bool> deleteLichDay(String docId) async {
    try {
      await _firestore.collection('lich_day').doc(docId).delete();
      print('✅ Đã xóa lịch dạy');
      return true;
    } catch (e) {
      print('❌ Lỗi xóa lịch dạy: $e');
      return false;
    }
  }

  /// Cập nhật lịch dạy
  Future<bool> updateLichDay(
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection('lich_day').doc(docId).update(data);
      print('✅ Đã cập nhật lịch dạy');
      return true;
    } catch (e) {
      print('❌ Lỗi cập nhật lịch dạy: $e');
      return false;
    }
  }

  /// Lấy danh sách tất cả lịch học
  Future<List<Map<String, dynamic>>> getAllLichHoc() async {
    try {
      final querySnap = await _firestore.collection('lich_hoc').get();
      return querySnap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
    } catch (e) {
      print('❌ Lỗi lấy lịch học: $e');
      return [];
    }
  }

  /// Lấy danh sách tất cả điểm
  Future<List<Map<String, dynamic>>> getAllDiem() async {
    try {
      final querySnap = await _firestore.collection('diem').get();
      return querySnap.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
    } catch (e) {
      print('❌ Lỗi lấy điểm: $e');
      return [];
    }
  }

  /// Lấy danh sách tất cả thời khóa biểu
  Future<List<Map<String, dynamic>>> getAllThoiKhoaBieu() async {
    try {
      final querySnap = await _firestore.collection('thoi_khoa_bieu').get();
      return querySnap.docs
          .map((doc) => {...doc.data(), 'id': doc.id})
          .toList();
    } catch (e) {
      print('❌ Lỗi lấy thời khóa biểu: $e');
      return [];
    }
  }

  /// ==================== QUẢN LÝ HỒ SƠ SINH VIÊN ====================
  /// Thêm/cập nhật hồ sơ sinh viên
  Future<bool> addOrUpdateHoSo({
    required String maSV,
    required String tenSV,
    String? ngaySinh,
    String? gioiTinh,
    String? queQuan,
    String? sdt,
    String? email,
    String? diaChi,
    String? danToc,
    String? tonGiao,
    String? cmnd,
    String? ngayCapCmnd,
  }) async {
    try {
      await _firestore.collection('ho_so').doc(maSV).set({
        'maSV': maSV,
        'tenSV': tenSV,
        if (ngaySinh != null) 'ngaySinh': ngaySinh,
        if (gioiTinh != null) 'gioiTinh': gioiTinh,
        if (queQuan != null) 'queQuan': queQuan,
        if (sdt != null) 'sdt': sdt,
        if (email != null) 'email': email,
        if (diaChi != null) 'diaChi': diaChi,
        if (danToc != null) 'danToc': danToc,
        if (tonGiao != null) 'tonGiao': tonGiao,
        if (cmnd != null) 'cmnd': cmnd,
        if (ngayCapCmnd != null) 'ngayCapCmnd': ngayCapCmnd,
      }, SetOptions(merge: true));
      print('✅ Đã lưu hồ sơ sinh viên');
      return true;
    } catch (e) {
      print('❌ Lỗi lưu hồ sơ: $e');
      return false;
    }
  }

  /// Lấy toàn bộ hồ sơ
  Future<List<Map<String, dynamic>>> getAllHoSo() async {
    try {
      final querySnap = await _firestore.collection('ho_so').get();
      return querySnap.docs
          .map((doc) => {...doc.data(), 'id': doc.id})
          .toList();
    } catch (e) {
      print('❌ Lỗi lấy hồ sơ: $e');
      return [];
    }
  }

  /// Xóa hồ sơ
  Future<bool> deleteHoSo(String maSV) async {
    try {
      await _firestore.collection('ho_so').doc(maSV).delete();
      print('✅ Đã xóa hồ sơ');
      return true;
    } catch (e) {
      print('❌ Lỗi xóa hồ sơ: $e');
      return false;
    }
  }
}


