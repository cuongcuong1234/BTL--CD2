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

### Collection: `tai_khoan` - Quản Lý Tài Khoản

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

### Collection: `ho_so` - Hồ Sơ Cá Nhân Sinh Viên

**Mỗi tài khoản sinh viên có 1 hồ sơ cá nhân riêng** với ID = mã sinh viên (maSV):

```json
{
  "maSV": "20224047",
  "tenSV": "Nguyễn Gia Khánh",
  "ngaySinh": "15/05/2005",
  "gioiTinh": "Nữ",
  "queQuan": "Hà Nội",
  "sdt": "0912345678",
  "email": "nguyenkhanh@gmail.com",
  "diaChi": "123 Đường A, Quận 1, TP.HCM",
  "danToc": "Kinh",
  "tonGiao": "Không",
  "cmnd": "123456789",
  "ngayCapCmnd": "01/01/2023"
}
```

#### 📋 Các Phương Thức Quản Lý Hồ Sơ

| Phương Thức | Mô Tả | Cách Sử Dụng |
|---|---|---|
| `getHoSoSV(maSV)` | Lấy hồ sơ của một sinh viên | `var profile = await DatabaseService().getHoSoSV('20224047');` |
| `addOrUpdateHoSo({...})` | Thêm/cập nhật hồ sơ | `await DatabaseService().addOrUpdateHoSo(maSV: '20224047', tenSV: 'Tên mới', ...);` |
| `getAllHoSo()` | Lấy tất cả hồ sơ | `var allProfiles = await DatabaseService().getAllHoSo();` |
| `deleteHoSo(maSV)` | Xóa hồ sơ | `await DatabaseService().deleteHoSo('20224047');` |

#### 💻 Ví Dụ Code

**Lấy hồ sơ của một sinh viên:**
```dart
final hoSo = await DatabaseService().getHoSoSV('20224047');
if (hoSo != null) {
  print('Tên: ${hoSo['tenSV']}');
  print('Ngày sinh: ${hoSo['ngaySinh']}');
  print('Email: ${hoSo['email']}');
}
```

**Tạo/Cập nhật hồ sơ:**
```dart
bool success = await DatabaseService().addOrUpdateHoSo(
  maSV: '20224047',
  tenSV: 'Nguyễn Gia Khánh',
  ngaySinh: '15/05/2005',
  gioiTinh: 'Nữ',
  email: 'nguyenkhanh@gmail.com',
  sdt: '0912345678',
  diaChi: '123 Đường A, Quận 1, TP.HCM',
);
```

**Lấy tất cả hồ sơ:**
```dart
final allProfiles = await DatabaseService().getAllHoSo();
for (var profile in allProfiles) {
  print('${profile['tenSV']} - ${profile['email']}');
}
```

**Xóa hồ sơ:**
```dart
bool deleted = await DatabaseService().deleteHoSo('20224047');
```

### Collection: `diem` - Quản Lý Điểm

Lưu trữ điểm của từng sinh viên, tự động tạo khi khởi tạo app:

```json
{
  "maSV": "20224047",
  "mon": "Lập trình Flutter",
  "diem": 8.5,
  "hocKy": "HK1-2026",
  "namHoc": "2025-2026"
}
```

### Collection: `lich_hoc` - Lịch Học Sinh Viên

Lưu lịch học của từng sinh viên theo thứ trong tuần:

```json
{
  "maSV": "20224047",
  "thu": "Thứ 2",
  "thứTự": 2,
  "mon": "Lập trình Flutter",
  "phong": "P.402",
  "gio": "07:30 - 09:30",
  "giangVien": "Thầy Nguyễn Văn A"
}
```

### Collection: `thoi_khoa_bieu` - Thời Khóa Biểu Lớp

Lưu thời khóa biểu của từng lớp học:

```json
{
  "maLop": "001",
  "thu": "Thứ 2",
  "thứTự": 2,
  "mon": "Lập trình Flutter",
  "phong": "P.402",
  "gio": "07:30-09:30",
  "giangVien": "Thầy Nguyễn Văn A"
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

## 🎯 Tính Năng Hiện Có

- [x] Quản lý tài khoản (add/edit/delete) - `addAccount()`, `updateAccount()`, `deleteAccount()`
- [x] **Quản lý hồ sơ cá nhân** (add/edit/delete) - `addOrUpdateHoSo()`, `getHoSoSV()`, `getAllHoSo()`, `deleteHoSo()` ✨
- [x] Quản lý điểm - `getDiemSV()`, `addDiem()`, `getAllDiem()`
- [x] Quản lý lịch học - `getLichHocSV()`, `addLichHoc()`, `updateLichHoc()`, `deleteLichHoc()`, `getAllLichHoc()`
- [x] Quản lý thời khóa biểu - `getThoiKhoaBieu()`, `addThoiKhoaBieu()`, `getAllThoiKhoaBieu()`
- [x] Đổi mật khẩu - `changePassword()`
- [x] Tìm kiếm tài khoản - `searchAccounts()`

## 🎯 Tính Năng Cần Phát Triển

- [ ] Backup/Restore dữ liệu
- [ ] Nhân bản tài khoản
- [ ] Lịch sử hoạt động (Activity Log)
- [ ] Quản lý phân quyền (Roles & Permissions)

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
