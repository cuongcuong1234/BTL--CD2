import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'home.dart';
import 'dang_ki.dart';
import 'services/database_service.dart';
import 'utils/responsive_helper.dart';

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
      if (!mounted) return;
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
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => home(
            userRole: userRole,
            username: username,
          ),
        ),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
      setState(() => isLoading = false);
    }
  }

  Future<void> _initializeLecturerAccounts() async {
    setState(() => isLoading = true);
    try {
      await _databaseService.initializeLecturerAccounts();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Đã khởi tạo 10 tài khoản giảng viên thành công!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Lỗi: $e')),
      );
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D4C4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 800;
              
              return SizedBox(
                width: constraints.maxWidth,
                child: isMobile
                    ? _buildMobileLayout(context)
                    : _buildDesktopLayout(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: _buildLoginForm(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Row(
        children: [
          // Left side - Image placeholder
          Expanded(
            child: Center(
              child: Icon(
                Icons.school_rounded,
                size: 200,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          const SizedBox(width: 60),
          // Right side - Form
          Expanded(
            child: _buildLoginForm(context),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username Field
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Tên đăng nhập',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: TextField(
              controller: tenNguoidungController,
              enabled: !isLoading,
              decoration: InputDecoration(
                hintText: '20224282',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF00A8E8),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF00A8E8),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF00A8E8),
                    width: 2.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          // Password Field
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Nhập mật khẩu',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextField(
              controller: passwordController,
              enabled: !isLoading,
              obscureText: !showPassword,
              decoration: InputDecoration(
                hintText: 'Nhập mật khẩu',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF00A8E8),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF00A8E8),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF00A8E8),
                    width: 2.5,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey[400],
                  ),
                  onPressed: () => setState(() => showPassword = !showPassword),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          // Remember me & Forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: luuThongTin,
                    onChanged: isLoading
                        ? null
                        : (val) => setState(() => luuThongTin = val ?? false),
                    activeColor: const Color(0xFF00A8E8),
                    side: const BorderSide(
                      color: Color(0xFF00A8E8),
                      width: 2,
                    ),
                  ),
                  Text(
                    'Ghi nhớ mật khẩu',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: isLoading
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Chức năng đặt lại mật khẩu sẽ được cập nhật'),
                          ),
                        );
                      },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Bạn quên mật khẩu của mình?',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          // Login Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A8E8),
                disabledBackgroundColor: Colors.grey[400],
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'ĐĂNG NHẬP',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          // Debug: Button to initialize lecturer accounts
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: isLoading ? null : _initializeLecturerAccounts,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFF00A8E8),
                  width: 1.5,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Khởi tạo tài khoản giảng viên',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00A8E8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

