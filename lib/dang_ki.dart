import 'package:flutter/material.dart';
import 'services/database_service.dart';

class DangKiScreen extends StatefulWidget {
  final bool isFromHome;
  const DangKiScreen({super.key, this.isFromHome = false});

  @override
  State<DangKiScreen> createState() => _DangKiScreenState();
}

class _DangKiScreenState extends State<DangKiScreen> {
  final maTaiKhoanController = TextEditingController();
  final matKhauController = TextEditingController();
  final xacNhanMatKhauController = TextEditingController();
  final tenSVController = TextEditingController();
  final emailController = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  String selectedRole = 'student';
  bool isLoading = false;

  final DatabaseService _databaseService = DatabaseService();

  @override
  void dispose() {
    maTaiKhoanController.dispose();
    matKhauController.dispose();
    xacNhanMatKhauController.dispose();
    tenSVController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    String username = maTaiKhoanController.text.trim();
    String password = matKhauController.text;
    String confirmPassword = xacNhanMatKhauController.text;
    String fullName = tenSVController.text.trim();
    String email = emailController.text.trim();

    // Kiểm tra điều kiện
    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar('Vui lòng nhập tất cả các trường bắt buộc');
      return;
    }

    if (password.length < 6) {
      _showSnackBar('Mật khẩu phải có ít nhất 6 ký tự');
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar('Mật khẩu không trùng khớp');
      return;
    }

    if (selectedRole == 'student' && fullName.isEmpty) {
      _showSnackBar('Sinh viên phải nhập họ tên');
      return;
    }

    if (selectedRole == 'student' && email.isEmpty) {
      _showSnackBar('Sinh viên phải nhập email');
      return;
    }

    setState(() => isLoading = true);

    try {
      bool success = await _databaseService.addAccount(
        maTaiKhoan: username,
        matKhau: password,
        vaiTro: selectedRole,
        tenSV: selectedRole == 'student' ? fullName : null,
        email: selectedRole == 'student' ? email : null,
      );

      if (!mounted) return;

      if (success) {
        _showSnackBar('Đăng ký thành công! 🎉');
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pop(context, true);
          }
        });
      } else {
        _showSnackBar('Tài khoản đã tồn tại, vui lòng chọn tên khác');
        setState(() => isLoading = false);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Lỗi: $e');
      setState(() => isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
                      ),
                      Expanded(
                        child: Text(
                          'Hệ thống quản lý điểm',
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
                    'ĐĂNG KÝ TÀI KHOẢN',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Chọn vai trò
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    items: const [
                      DropdownMenuItem(value: 'admin', child: Text('Admin')),
                      DropdownMenuItem(
                        value: 'student',
                        child: Text('Student (Sinh viên)'),
                      ),
                    ],
                    onChanged: (val) => setState(() => selectedRole = val!),
                    decoration: InputDecoration(
                      labelText: 'Chọn vai trò',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      prefixIcon: const Icon(Icons.person_sharp),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Mã tài khoản
                  _buildTextField(
                    controller: maTaiKhoanController,
                    label: 'Mã tài khoản 👤',
                    icon: Icons.badge,
                  ),
                  const SizedBox(height: 16),

                  // Tên sinh viên (hiển thị nếu là sinh viên)
                  if (selectedRole == 'student') ...[
                    _buildTextField(
                      controller: tenSVController,
                      label: 'Họ tên 📝',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    // Email
                    _buildTextField(
                      controller: emailController,
                      label: 'Email 📧',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Mật khẩu
                  _buildPasswordField(
                    controller: matKhauController,
                    label: 'Mật khẩu 🔑',
                    icon: Icons.lock,
                    showPassword: showPassword,
                    onToggle: () =>
                        setState(() => showPassword = !showPassword),
                  ),
                  const SizedBox(height: 16),

                  // Xác nhận mật khẩu
                  _buildPasswordField(
                    controller: xacNhanMatKhauController,
                    label: 'Xác nhận mật khẩu 🔑',
                    icon: Icons.lock,
                    showPassword: showConfirmPassword,
                    onToggle: () => setState(
                      () => showConfirmPassword = !showConfirmPassword,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Register Button
                  ElevatedButton(
                    onPressed: isLoading ? null : _handleRegister,
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
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'ĐĂNG KÝ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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
    required bool showPassword,
    required VoidCallback onToggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggle,
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
