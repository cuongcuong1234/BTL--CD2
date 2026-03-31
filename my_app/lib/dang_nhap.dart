import 'package:flutter/material.dart';

class DangNhapScreen extends StatefulWidget {
  const DangNhapScreen({super.key});

  @override
  State<DangNhapScreen> createState() => _DangNhapScreenState();
}

class _DangNhapScreenState extends State<DangNhapScreen> {
  bool luuThongTin = false;
  final tenNguoidungController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;

  @override
  void dispose() {
    tenNguoidungController.dispose();
    passwordController.dispose();
    super.dispose();
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.school, 
                              color: Colors.blue, 
                              size: 24,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'ỨNG DỤNG QUẢN LÝ SINH VIÊN',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Body Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                children: [
                  // University Logo
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue[900]!,
                        width: 3,
                      ),
                    ),
                    child: Image.asset(
                      'assets/university_logo.png',
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[900],
                          ),
                          child: const Icon(
                            Icons.school,
                            size: 100,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Login Title
                  const Text(
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
                  const SizedBox(height: 20),
                  // Remember Me Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: luuThongTin,
                        onChanged: (value) {
                          setState(() {
                            luuThongTin = value ?? false;
                          });
                        },
                        activeColor: Colors.blue[900],
                      ),
                      Text(
                        'Lưu thông tin',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Login and Register Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Xử lý đăng nhập
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
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
                            // Xử lý đăng ký
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
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900, width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          child: Icon(
            showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey[600],
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900, width: 2),
        ),
      ),
    );
  }
}
