import 'package:flutter/material.dart';
import 'home.dart';
import 'dang_ki.dart';
import 'services/database_service.dart';

class DangNhapScreen extends StatefulWidget {
  final bool isFromHome;
  const DangNhapScreen({super.key, this.isFromHome = false});

  @override
  State<DangNhapScreen> createState() => _DangNhapScreenState();
}

class _DangNhapScreenState extends State<DangNhapScreen> {
  bool luuThongTin = false;
  final tenNguoidungController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;
  bool isLoading = false;

  final DatabaseService _databaseService = DatabaseService();

  @override
  void dispose() {
    tenNguoidungController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    String username = tenNguoidungController.text.trim();
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập tên người dùng và mật khẩu')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Kiểm tra đăng nhập thông qua Firebase
      final user = await _databaseService.checkLogin(username, password);

      if (!mounted) return;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tên người dùng hoặc mật khẩu không chính xác')),
        );
        setState(() => isLoading = false);
        return;
      }

      // Đăng nhập thành công - lấy vai trò từ database
      final userRole = user['vaiTro'] ?? 'student';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => home(
            userRole: userRole,
            username: username,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.blue[900],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.isFromHome)
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.blue[900],
                          ),
                        )
                      else
                        const SizedBox(width: 48),
                      Expanded(
                        child: Text(
                          'Hệ thống quản lý sinh viên',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Icon(
                    Icons.school_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            // Content Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'ĐĂNG NHẬP',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Username TextField
                  _buildTextField(
                    controller: tenNguoidungController,
                    label: 'Nhập tên người dùng 👤',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  // Password TextField
                  _buildPasswordField(
                    controller: passwordController,
                    label: 'Nhập password 🔑',
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 16),
                  // Remember me checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: luuThongTin,
                        onChanged: (val) => setState(() => luuThongTin = val ?? false),
                      ),
                      const Text('Lưu thông tin đăng nhập'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Login & Register Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text(
                                  'ĐĂNG NHẬP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DangKiScreen(isFromHome: true),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'ĐĂNG KÝ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      enabled: !isLoading,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => showPassword = !showPassword),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      enabled: !isLoading,
    );
  }
}

