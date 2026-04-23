import 'package:flutter/material.dart';

class QuanLyTaiKhoanScreen extends StatefulWidget {
  final String userRole;

  const QuanLyTaiKhoanScreen({super.key, required this.userRole});

  @override
  State<QuanLyTaiKhoanScreen> createState() => _QuanLyTaiKhoanScreenState();
}

class _QuanLyTaiKhoanScreenState extends State<QuanLyTaiKhoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản Lý Tài Khoản'),
        backgroundColor: Colors.blue[900],
      ),
      body: const Center(
        child: Text('Quản lý tài khoản sẽ được cập nhật'),
      ),
    );
  }
}
