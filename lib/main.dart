import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dang_nhap.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Khởi tạo các tài khoản mặc định
  await DatabaseService().initializeDefaultAccounts();
  
  // Khởi tạo dữ liệu mẫu (bỏ qua nếu gặp lỗi permission)
  try {
    await DatabaseService().initializeDefaultData();
    await DatabaseService().reinitializeScheduleData();
  } catch (e) {
    print('⚠️  Bỏ qua khởi tạo dữ liệu: $e');
    print('💡 Hãy cập nhật Firestore Rules để cho phép ghi dữ liệu');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educational Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DangNhapScreen(),
    );
  }
}
