import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';

Future<void> addLecturersToDatabase() async {
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 10 tài khoản giảng viên
  final List<Map<String, dynamic>> lecturers = [
    {
      'tenDangNhap': 'gv001',
      'matKhau': 'password123',
      'vaiTro': 'lecturer',
      'hoTen': 'Thầy Nguyễn Văn A',
      'email': 'nguyenvana@eaut.edu.vn',
      'khoa': 'Khoa Công Nghệ Thông Tin',
      'ngayTao': DateTime.now(),
    },
    {
      'tenDangNhap': 'gv002',
      'matKhau': 'password123',
      'vaiTro': 'lecturer',
      'hoTen': 'Cô Trần Thị B',
      'email': 'tranthib@eaut.edu.vn',
      'khoa': 'Khoa Quản Trị Kinh Doanh',
      'ngayTao': DateTime.now(),
    },
    {
      'tenDangNhap': 'gv003',
      'matKhau': 'password123',
      'vaiTro': 'lecturer',
      'hoTen': 'Thầy Hoàng Văn C',
      'email': 'hoangvanc@eaut.edu.vn',
      'khoa': 'Khoa Công Nghệ Thông Tin',
      'ngayTao': DateTime.now(),
    },
    {
      'tenDangNhap': 'gv004',
      'matKhau': 'password123',
      'vaiTro': 'lecturer',
      'hoTen': 'Cô Phạm Thị D',
      'email': 'phamthid@eaut.edu.vn',
      'khoa': 'Khoa Giao Thông Vận Tải',
      'ngayTao': DateTime.now(),
    },
    {
      'tenDangNhap': 'gv005',
      'matKhau': 'password123',
      'vaiTro': 'lecturer',
      'hoTen': 'Thầy Vũ Văn E',
      'email': 'vuvane@eaut.edu.vn',
      'khoa': 'Khoa Công Nghệ Thông Tin',
      'ngayTao': DateTime.now(),
    },
    {
      'tenDangNhap': 'gv006',
      'matKhau': 'password123',
      'vaiTro': 'lecturer',
      'hoTen': 'Cô Đặng Thị F',
      'email': 'dangthif@eaut.edu.vn',
      'khoa': 'Khoa Quản Trị Kinh Doanh',
      'ngayTao': DateTime.now(),
    },
    {
      'tenDangNhap': 'gv007',
      'matKhau': 'password123',
      'vaiTro': 'lecturer',
      'hoTen': 'Thầy Lê Văn G',
      'email': 'levang@eaut.edu.vn',
      'khoa': 'Khoa Giao Thông Vận Tải',
      'ngayTao': DateTime.now(),
    },
    {
      'tenDangNhap': 'gv008',
      'matKhau': 'password123',
      'vaiTro': 'lecturer',
      'hoTen': 'Cô Bùi Thị H',
      'email': 'buithih@eaut.edu.vn',
      'khoa': 'Khoa Công Nghệ Thông Tin',
      'ngayTao': DateTime.now(),
    },
    {
      'tenDangNhap': 'gv009',
      'matKhau': 'password123',
      'vaiTro': 'lecturer',
      'hoTen': 'Thầy Dương Văn I',
      'email': 'duongvani@eaut.edu.vn',
      'khoa': 'Khoa Quản Trị Kinh Doanh',
      'ngayTao': DateTime.now(),
    },
    {
      'tenDangNhap': 'gv010',
      'matKhau': 'password123',
      'vaiTro': 'lecturer',
      'hoTen': 'Cô Nhan Thị J',
      'email': 'nanthij@eaut.edu.vn',
      'khoa': 'Khoa Giao Thông Vận Tải',
      'ngayTao': DateTime.now(),
    },
  ];

  // Thêm từng giảng viên vào collection 'users'
  for (var lecturer in lecturers) {
    try {
      await firestore.collection('users').add(lecturer);
      print('✅ Đã thêm: ${lecturer['hoTen']} (${lecturer['tenDangNhap']})');
    } catch (e) {
      print('❌ Lỗi thêm ${lecturer['hoTen']}: $e');
    }
  }

  print('\n✅ Hoàn thành! Đã thêm 10 tài khoản giảng viên.');
}

void main() async {
  await addLecturersToDatabase();
}
