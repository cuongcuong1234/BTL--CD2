import 'package:flutter/material.dart';
import 'dang_nhap.dart';
import 'danh_sach_lop.dart';
import 'quan_ly_sv.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Section
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[900]!, Colors.blue[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // Background pattern
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white30, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  // Main content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'ADMIN',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Have a good day text
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: const Text(
                      '🌐 Have a good day',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Grid Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMenuItem(
                    context: context,
                    icon: Icons.person_outline,
                    label: 'Quản Lý\nLớp Học',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DanhSachLopScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.school_outlined,
                    label: 'Quản Lý\nSinh Viên',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuanLySinhVienScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.note_outlined,
                    label: 'Quản Lý\nNgành',
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.book_outlined,
                    label: 'Môn học',
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.language_outlined,
                    label: 'Website',
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.calendar_month_outlined,
                    label: 'Sự Kiện',
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.info_outlined,
                    label: 'Thông Tin',
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.login_outlined,
                    label: 'Đăng Nhập',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DangNhapScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.call_outlined,
                    label: 'Liên Hệ',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.blue[800],
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
