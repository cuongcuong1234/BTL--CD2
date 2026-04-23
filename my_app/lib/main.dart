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
  
  print('🔄 Đang khởi tạo dữ liệu...');
  
  // Khởi tạo các tài khoản mặc định
  try {
    await DatabaseService().initializeDefaultAccounts();
    print('✅ Tài khoản initialized');
  } catch (e) {
    print('❌ Lỗi tài khoản: $e');
  }
  
  // Khởi tạo dữ liệu mẫu
  try {
    await DatabaseService().initializeDefaultData();
    print('✅ Dữ liệu mẫu (hồ sơ, điểm, lịch học) initialized');
  } catch (e) {
    print('❌ Lỗi dữ liệu mẫu: $e');
  }
  
  // Khởi tạo thời khóa biểu
  try {
    await DatabaseService().reinitializeScheduleData();
    print('✅ Thời khóa biểu initialized');
  } catch (e) {
    print('❌ Lỗi thời khóa biểu: $e');
  }
  
  print('🎉 Khởi tạo xong!');
  
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
