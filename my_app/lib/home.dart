import 'package:flutter/material.dart';
import 'dang_nhap.dart';
import 'danh_sach_lop.dart';
import 'quan_ly_sv.dart';
import 'quan_ly_nghanh.dart';
import 'mon_hoc.dart';
import 'thoi_khoa_bieu.dart';
import 'xem_diem_chi_tiet.dart';
import 'thong_bao.dart';
import 'hoc_phi.dart';
import 'chuong_trinh_dao_tao.dart';
import 'lich_hoc_sv.dart';
import 'ho_so_ca_nhan.dart';
import 'quan_ly_lich_hoc.dart';
import 'quan_ly_diem.dart';
import 'quan_ly_ho_so.dart';

class home extends StatelessWidget {
  final String userRole;
  final String username;
  const home({super.key, this.userRole = 'admin', this.username = 'Admin'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Hello, $username',
          style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const DangNhapScreen(isFromHome: true)),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout, color: Colors.amber),
              label: const Text('Logout', style: TextStyle(color: Colors.amber)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Section
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF1a3a52), const Color(0xFF0d2a42)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/banner.png'),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    // Fallback gradient if image not found
                  },
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Stack(
                  children: [
                    // Decorative background shapes
                    Positioned(
                      top: 30,
                      left: 20,
                      child: Opacity(
                        opacity: 0.08,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 30,
                      child: Opacity(
                        opacity: 0.08,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      right: 40,
                      child: Opacity(
                        opacity: 0.08,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      right: 60,
                      child: Opacity(
                        opacity: 0.08,
                        child: Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    // Main content - Top logo
                    Positioned(
                      top: 80,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/logo.png',
                              width: 95,
                              height: 95,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 95,
                                  height: 95,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.school,
                                    size: 50,
                                    color: Color(0xFF1a3a52),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Welcome text
                    Positioned(
                      top: 135,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                    // Admin text
                    Positioned(
                      top: 185,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    // Bottom text
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
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
                children: _buildMenuItems(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    List<Widget> allMenuItems = [
      // Chỉ hiển thị cho admin
      if (userRole == 'admin')
        _buildMenuItem(
          context: context,
          icon: Icons.person_outline,
          label: 'Quản Lý\nLớp Học',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DanhSachLopScreen(userRole: 'admin'),
              ),
            );
          },
        ),
      // Chỉ hiển thị cho admin
      if (userRole == 'admin')
        _buildMenuItem(
          context: context,
          icon: Icons.school_outlined,
          label: 'Quản Lý\nSinh Viên',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuanLySinhVienScreen(userRole: 'admin'),
              ),
            );
          },
        ),
      // Chỉ hiển thị cho admin
      if (userRole == 'admin')
        _buildMenuItem(
          context: context,
          icon: Icons.note_outlined,
          label: 'Quản Lý\nNgành',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuanLyNganhScreen(userRole: 'admin'),
              ),
            );
          },
        ),
      // Chỉ hiển thị cho admin
      if (userRole == 'admin')
        _buildMenuItem(
          context: context,
          icon: Icons.book_outlined,
          label: 'Môn học',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MonHocScreen(userRole: 'admin'),
              ),
            );
          },
        ),

      // Chỉ hiển thị cho student
      if (userRole == 'student')
        _buildMenuItem(
          context: context,
          icon: Icons.grade_outlined,
          label: 'Xem Điểm',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => XemDiemChiTietScreen(
                  maSV: username,
                  userRole: userRole,
                ),
              ),
            );
          },
        ),

      // Chỉ hiển thị cho student
      if (userRole == 'student')
        _buildMenuItem(
          context: context,
          icon: Icons.schedule_outlined,
          label: 'Lịch Học',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LichHocSVScreen(maSV: username),
              ),
            );
          },
        ),

      // Chỉ hiển thị cho student
      if (userRole == 'student')
        _buildMenuItem(
          context: context,
          icon: Icons.account_circle_outlined,
          label: 'Hồ Sơ',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HoSoCaNhanScreen(username: username, userRole: userRole),
              ),
            );
          },
        ),

      // Chỉ hiển thị cho student
      if (userRole == 'student')
        _buildMenuItem(
          context: context,
          icon: Icons.payment_outlined,
          label: 'Học Phí',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HocPhiScreen(),
              ),
            );
          },
        ),

      // Hiển thị cho tất cả
      _buildMenuItem(
        context: context,
        icon: Icons.calendar_month_outlined,
        label: 'Thời Khóa Biểu',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThoiKhoaBieuScreen(userRole: userRole),
            ),
          );
        },
      ),

      // Hiển thị cho tất cả
      _buildMenuItem(
        context: context,
        icon: Icons.notifications_outlined,
        label: 'Thông Báo',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ThongBaoScreen(),
            ),
          );
        },
      ),

      // Hiển thị cho tất cả
      _buildMenuItem(
        context: context,
        icon: Icons.school_outlined,
        label: 'CTĐT',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChuongTrinhDaoTaoScreen(),
            ),
          );
        },
      ),

      // Quản lý lịch học (Admin)
      if (userRole == 'admin')
        _buildMenuItem(
          context: context,
          icon: Icons.schedule,
          label: 'QL Lịch Học',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuanLyLichHocScreen(),
              ),
            );
          },
        ),

      // Quản lý điểm (Admin)
      if (userRole == 'admin')
        _buildMenuItem(
          context: context,
          icon: Icons.grade,
          label: 'QL Điểm',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuanLyDiemScreen(),
              ),
            );
          },
        ),

      // Quản lý hồ sơ (Admin)
      if (userRole == 'admin')
        _buildMenuItem(
          context: context,
          icon: Icons.person_4,
          label: 'QL Hồ Sơ',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuanLyHoSoScreen(),
              ),
            );
          },
        ),
    ];
    return allMenuItems;
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
