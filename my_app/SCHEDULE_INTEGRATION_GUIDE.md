# 🔗 Hướng Dẫn Tích Hợp - Thêm Lịch Ca Nhân vào App

## 📍 Vị Trí Tích Hợp

Trang **Lịch Ca Nhân** (Thời Khóa Biểu) cần được thêm vào:
1. **Menu/Drawer** chính
2. **Home screen** (nếu có menu)
3. **Navigation tabs** (nếu dùng)

---

## 🔧 Các File Cần Sửa

### 1. Home Screen (home.dart)
Thêm ListTile hoặc Button để vào Lịch Ca Nhân

### 2. Main Navigation (main.dart)
(Đã có sẵn - không cần sửa)

### 3. User Info (Lưu trong variable)
Đảm bảo có:
- `currentUser['maTaiKhoan']` (ID)
- `currentUser['vaiTro']` (admin/teacher/student)
- `currentUser['maLop']` (Lớp của sinh viên)

---

## 📝 Code Examples

### Cách 1: Thêm vào Home Screen Menu

```dart
// Tại home.dart hoặc screen chính

import 'package:my_app/thoi_khoa_bieu.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trang Chủ')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Lịch Ca Nhân'),
            leading: Icon(Icons.schedule),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ThoiKhoaBieuScreen(
                    userRole: currentUser['vaiTro'],
                    userId: currentUser['maTaiKhoan'],
                    userClass: currentUser['maLop'],
                  ),
                ),
              );
            },
          ),
          // Các menu khác...
        ],
      ),
    );
  }
}
```

### Cách 2: Thêm vào Drawer

```dart
// Tại main.dart hoặc drawer.dart

import 'package:my_app/thoi_khoa_bieu.dart';

class AppDrawer extends StatelessWidget {
  final String userRole;
  final String userId;
  final String userClass;

  const AppDrawer({
    required this.userRole,
    required this.userId,
    required this.userClass,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Menu'),
          ),
          ListTile(
            title: Text('Lịch Ca Nhân'),
            leading: Icon(Icons.schedule),
            onTap: () {
              Navigator.pop(context); // Đóng drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ThoiKhoaBieuScreen(
                    userRole: userRole,
                    userId: userId,
                    userClass: userClass,
                  ),
                ),
              );
            },
          ),
          // Các item khác...
        ],
      ),
    );
  }
}
```

### Cách 3: Thêm vào BottomNavigationBar

```dart
// Tại main.dart hoặc screen quản lý navigation

import 'package:my_app/thoi_khoa_bieu.dart';

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  late String userRole;
  late String userId;
  late String userClass;

  @override
  void initState() {
    super.initState();
    // Load user info từ SharedPreferences hoặc Database
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    // TODO: Load từ database
    userRole = 'student';
    userId = '20224047';
    userClass = '001';
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(),
      ThoiKhoaBieuScreen(
        userRole: userRole,
        userId: userId,
        userClass: userClass,
      ),
      OtherScreen(),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang Chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Lịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            label: 'Khác',
          ),
        ],
      ),
    );
  }
}
```

### Cách 4: Thêm vào Class Quản Lý Route

```dart
// Tại route_manager.dart hoặc app_router.dart

import 'package:my_app/thoi_khoa_bieu.dart';

class RouteManager {
  static navigateToSchedule(
    BuildContext context, {
    required String userRole,
    required String userId,
    required String userClass,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ThoiKhoaBieuScreen(
          userRole: userRole,
          userId: userId,
          userClass: userClass,
        ),
      ),
    );
  }

  // Các route khác...
}

// Cách sử dụng:
// RouteManager.navigateToSchedule(
//   context,
//   userRole: user['vaiTro'],
//   userId: user['maTaiKhoan'],
//   userClass: user['maLop'],
// );
```

---

## ✅ Checklist Tích Hợp

- [ ] Import `ThoiKhoaBieuScreen` vào file
- [ ] Lấy thông tin user: `userRole`, `userId`, `userClass`
- [ ] Thêm navigation đến `ThoiKhoaBieuScreen`
- [ ] Pass đúng parameters
- [ ] Test: Mở Lịch Ca Nhân
- [ ] Test: Xem lịch
- [ ] Test: Thêm/sửa/xóa (nếu admin)
- [ ] Test: Chuyển tuần
- [ ] Kiểm tra không có lỗi

---

## 🐛 Debug

### Log thông tin user
```dart
print('User Role: ${currentUser['vaiTro']}');
print('User ID: ${currentUser['maTaiKhoan']}');
print('User Class: ${currentUser['maLop']}');
```

### Log khi mở Lịch
```dart
onTap: () {
  print('Mở Lịch Ca Nhân...');
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ThoiKhoaBieuScreen(
        userRole: userRole,
        userId: userId,
        userClass: userClass,
      ),
    ),
  );
}
```

---

## 🔐 Bảo Mật

✅ **Làm tốt**
- Kiểm tra `userRole` trước khi cho phép sửa/xóa
- Validate `userId` và `userClass`
- Sử dụng Firestore Rules để kiểm tra quyền

❌ **Tránh**
- Không hardcode `userId` hoặc `userRole`
- Không cho phép user thay đổi role của họ
- Không load user data vào widget constructor (nên load từ DB)

---

## 📦 Kết Hợp với Các Trang Khác

```dart
// home.dart - Trang chủ
// ├── ListTile: Lịch Ca Nhân → ThoiKhoaBieuScreen ✅
// ├── ListTile: Điểm → XemDiemScreen
// ├── ListTile: Hồ Sơ → HoSoScreen
// └── ...

// drawer.dart - Sidebar
// ├── ListTile: Lịch Ca Nhân → ThoiKhoaBieuScreen ✅
// ├── ListTile: Quản Lý Sinh Viên → QuanLySVScreen
// └── ListTile: Đăng Xuất

// bottom_nav.dart - Tab bar
// ├── Tab 1: Trang Chủ (HomeScreen)
// ├── Tab 2: Lịch Ca Nhân (ThoiKhoaBieuScreen) ✅
// └── Tab 3: Người Dùng (UserScreen)
```

---

## 🎯 Lưu Ý Quan Trọng

1. **User Info**: Phải lấy từ database hoặc SharedPreferences
   ```dart
   // ❌ Sai
   userId = '20224047'; // Hardcode
   
   // ✅ Đúng
   userId = await getCurrentUserId();
   ```

2. **Navigation**: Luôn pass đúng parameters
   ```dart
   // ❌ Sai
   ThoiKhoaBieuScreen()
   
   // ✅ Đúng
   ThoiKhoaBieuScreen(
     userRole: userRole,
     userId: userId,
     userClass: userClass,
   )
   ```

3. **Role Checking**: Kiểm tra role trước khi show buttons
   ```dart
   // ❌ Sai
   FloatingActionButton(...) // Luôn hiển thị
   
   // ✅ Đúng
   if (widget.userRole != 'student')
     FloatingActionButton(...) // Chỉ admin/teacher
   ```

---

## 📞 Ví Dụ Thực Tế

### Ví Dụ 1: Tích Hợp vào Home
```dart
// home.dart

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trang Chủ')),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ThoiKhoaBieuScreen(
                    userRole: user['vaiTro'],
                    userId: user['maTaiKhoan'],
                    userClass: user['maLop'],
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.schedule, size: 48),
                  Text('Lịch Ca Nhân'),
                ],
              ),
            ),
          ),
          // Các card khác...
        ],
      ),
    );
  }
}
```

### Ví Dụ 2: Tích Hợp vào Provider
```dart
// Nếu dùng Provider để quản lý state

class UserProvider extends ChangeNotifier {
  Map<String, dynamic>? _user;
  
  Map<String, dynamic>? get user => _user;

  void openSchedule(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ThoiKhoaBieuScreen(
          userRole: _user!['vaiTro'],
          userId: _user!['maTaiKhoan'],
          userClass: _user!['maLop'],
        ),
      ),
    );
  }
}

// Sử dụng:
// Provider.of<UserProvider>(context, listen: false)
//   .openSchedule(context);
```

---

## 🚀 Deployment

Trước khi deploy:
1. ✅ Kiểm tra import đúng
2. ✅ Kiểm tra user info được load đúng
3. ✅ Test tất cả routes
4. ✅ Test quản lý lịch (admin)
5. ✅ Kiểm tra không có hardcode value
6. ✅ Review Firestore Rules
7. ✅ Build release version
8. ✅ Test trên device thực

---

## 📚 Tài Liệu Liên Quan

- [README_SCHEDULE.md](./README_SCHEDULE.md) - Tổng quan
- [SCHEDULE_QUICKSTART.md](./SCHEDULE_QUICKSTART.md) - Bắt đầu nhanh
- [SCHEDULE_SUMMARY.md](./SCHEDULE_SUMMARY.md) - Tóm tắt toàn bộ

---

**Bây giờ bạn đã sẵn sàng tích hợp Lịch Ca Nhân vào app!** 🎉
