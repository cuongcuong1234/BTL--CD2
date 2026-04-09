# 📱 Hệ Thống Quản Lý Điểm - Tích Hợp Firebase Database

## ✨ Những Thay Đổi Đã Thực Hiện

### 1. **Thêm Firebase Dependencies** 
   - `firebase_core: ^3.0.0`
   - `firebase_auth: ^5.1.0`
   - `cloud_firestore: ^5.0.0`

### 2. **Tạo Database Service** (`lib/services/database_service.dart`)
   Cung cấp các hàm quản lý tài khoản:
   - ✅ `checkLogin()` - Kiểm tra đăng nhập
   - ✅ `getAllStudents()` - Lấy danh sách sinh viên
   - ✅ `getStudent()` - Lấy thông tin sinh viên
   - ✅ `addAccount()` - Thêm tài khoản mới
   - ✅ `updateAccount()` - Cập nhật tài khoản
   - ✅ `deleteAccount()` - Xóa tài khoản
   - ✅ `changePassword()` - Đổi mật khẩu
   - ✅ `searchAccounts()` - Tìm kiếm tài khoản
   - ✅ `initializeDefaultAccounts()` - Khởi tạo dữ liệu mặc định

### 3. **Lập trình Firebase Initialization** (`lib/firebase_options.dart`)
   - Cấu hình cho Android, iOS, Web, Windows
   - Placeholder cho các khóa API (cần thay thế)

### 4. **Cập nhật Main App** (`lib/main.dart`)
   - Khởi tạo Firebase khi ứng dụng khởi động
   - Tự động tạo tài khoản mặc định
   - Chuyển trang đầu tiên đến `DangNhapScreen`

### 5. **Cập nhật Trang Đăng Nhập** (`lib/dang_nhap.dart`)
   - Thay hardcoded data bằng Firebase queries
   - Thêm loading indicator khi đang kiểm tra
   - Xử lý lỗi kết nối Firebase
   - Async/await cho hoạt động database

### 6. **Tạo Trang Quản Lý Tài Khoản** (`lib/quan_ly_tai_khoan.dart`)
   - Bản khung để quản lý tài khoản (sẽ cập nhật sau)

## 🚀 Bắt Đầu Nhanh

### Yêu cầu
- Flutter SDK ≥ 3.11.3
- Android SDK hoặc iOS SDK
- Firebase Project

### Cài Đặt

#### 1️⃣ Cấu Hình Firebase

**Cách 1: Sử dụng FlutterFire CLI (Khuyến nghị)**
```bash
# Cài đặt FlutterFire CLI
flutter pub global activate flutterfire_cli

# Chạy cấu hình
flutterfire configure --project=YOUR_FIREBASE_PROJECT_ID
```

**Cách 2: Thủ công**
- Vào [Firebase Console](https://console.firebase.google.com/)
- Tạo hoặc chọn project
- Thêm các ứng dụng (Android, iOS, v.v.)
- Sao chép cấu hình vào `lib/firebase_options.dart`

#### 2️⃣ Tải Dependencies
```bash
flutter pub get
```

#### 3️⃣ Chạy Ứng Dụng
```bash
flutter run
```

## 📊 Cơ Sở Dữ Liệu Firestore

### Collection: `tai_khoan`

Mỗi tài khoản là một document với ID = mã người dùng:

```
Tài Khoản Admin:
{
  "maTaiKhoan": "20224282",
  "matKhau": "123456",
  "vaiTro": "admin",
  "ngayTao": Timestamp
}

Tài Khoản Sinh Viên:
{
  "maTaiKhoan": "20224047",
  "tenSV": "Nguyễn Gia Khánh",
  "matKhau": "123456",
  "vaiTro": "student",
  "email": "nguyenkhanh@gmail.com",
  "maLop": "001",
  "tenNganh": "CNTT",
  "avatar": "assets/avatar1.png",
  "ngayTao": Timestamp
}
```

## 🔐 Tài Khoản Mặc Định

| Mã Tài Khoản | Tên | Mật Khẩu | Vai Trò |
|---|---|---|---|
| 20224282 | Admin | 123456 | Admin |
| 20224047 | Nguyễn Gia Khánh | 123456 | Student |
| 20223882 | Vũ Huy Khánh | 123456 | Student |
| 20224997 | Ngô Mạnh Kiên | 123456 | Student |
| 12345 | Nguyễn Văn A | 123456 | Student |
| 42222 | Nguyễn Văn B | 123456 | Student |

## 📖 Hướng Dẫn Chi Tiết

Xem [SETUP_FIREBASE.md](./SETUP_FIREBASE.md) để có hướng dẫn cấu hình chi tiết

## 🎯 Tính Năng Tiếp Theo

- [ ] Quản lý tài khoản (add/edit/delete)
- [ ] Đổi mật khẩu tài khoản
- [ ] Tìm kiếm/lọc tài khoản
- [ ] Backup/Restore dữ liệu
- [ ] Nhân bản tài khoản

## 🐛 Khắc Phục Sự Cố

### Lỗi: "firebase_core not found"
→ Chạy `flutter pub get`

### Lỗi: "Firestore not initialized"
→ Kiểm tra `Firebase.initializeApp()` trong `main.dart`

### Lỗi: "Permission denied" khi đăng nhập
→ Kiểm tra Firestore Rules trong Firebase Console

### Lỗi: "Platform exception"
→ Xóa build cũ: `flutter clean` và chạy `flutter pub get` lại

## 📚 Tài Liệu

- [FirebaseFlutter.dev](https://firebase.flutter.dev)
- [Firestore Documentation](https://firebase.google.com/docs/firestore)
- [Firebase Security Rules](https://firebase.google.com/docs/firestore/security/start)

---

**✅ Database đã được tích hợp thành công!**
Giờ đây ứng dụng của bạn sử dụng Firebase Firestore thực thụ thay vì dữ liệu hardcoded.
