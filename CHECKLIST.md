# 📋 Danh Sách Kiểm Tra Cấu Hình Firebase

## ✅ Các File Đã Tạo/Sửa

- [x] **pubspec.yaml** - Thêm Firebase dependencies
- [x] **lib/firebase_options.dart** - Cấu hình Firebase (placeholder)
- [x] **lib/main.dart** - Khởi tạo Firebase
- [x] **lib/dang_nhap.dart** - Sử dụng DatabaseService
- [x] **lib/services/database_service.dart** - Định nghĩa DatabaseService
- [x] **lib/quan_ly_tai_khoan.dart** - Trang quản lý tài khoản
- [x] **DATABASE_README.md** - Hướng dẫn sử dụng database
- [x] **SETUP_FIREBASE.md** - Hướng dẫn chi tiết cấu hình

## 🔧 Các Bước Cần Làm

### 1. Cấu Hình Firebase Project

**[ ] Bước 1a:**
```bash
flutter pub global activate flutterfire_cli
```

**[ ] Bước 1b:**
```bash
flutterfire configure --project=YOUR_PROJECT_ID
```
Hoặc thủ công cập nhật `firebase_options.dart` với khóa API từ Firebase Console

**[ ] Bước 1c:**
Kiểm tra file `google-services.json` tồn tại trong `android/app/`

### 2. Kích Hoạt Firestore Database

**[ ]** Đăng nhập [Firebase Console](https://console.firebase.google.com)  
**[ ]** Chọn project  
**[ ]** Vào "Build" → "Firestore Database"  
**[ ]** Tạo database - Chọn "Start in test mode"  
**[ ]** Chọn vị trí (asia-southeast1)  
**[ ]** Sao chép Firestore Rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /tai_khoan/{document=**} {
      allow read, write: if true;  // Test mode
    }
  }
}
```

### 3. Cài Đặt Dependencies

**[ ]** Chạy:
```bash
flutter pub get
flutter clean
```

### 4. Kiểm Tra Build

**[ ]** Chạy:
```bash
flutter run
```

**[ ]** Kiểm tra:
- Ứng dụng khởi động thành công
- Không có lỗi Firebase
- Tài khoản mặc định được tạo tại Firestore
- Đăng nhập bằng: `20224047` / `123456` (sinh viên)
- Đăng nhập bằng: `20224282` / `123456` (admin)

## 📦 Cơ Sở Dữ Liệu Được Tạo Tự Động

Khi ứng dụng khởi chạy lần đầu, nó sẽ tự động tạo:

```
Firestore Collection: tai_khoan
├── Document "20224282" (Admin)
├── Document "20224047" (Student - Nguyễn Gia Khánh)
├── Document "20223882" (Student - Vũ Huy Khánh)
├── Document "20224997" (Student - Ngô Mạnh Kiên)
├── Document "12345" (Student - Nguyễn Văn A)
└── Document "42222" (Student - Nguyễn Văn B)
```

## 🔄 Thay Đổi Cần Lưu Ý

### Android
- `google-services.json` cần được đặt tại `android/app/`
- File này tự động tải khi chạy `flutterfire configure`

### iOS
- `GoogleService-Info.plist` cần được thêm vào Xcode project
- Thực hiện bằng Xcode

### Web (nếu sử dụng)
- Cần cập nhật các khóa API trong `firebase_options.dart`

## 💡 Mẹo

- 🔐 Để production, thay đổi Firestore Rules thành:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /tai_khoan/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == request.resource.data.uid;
    }
  }
}
```

- 📊 Xem dữ liệu trong Firestore: Firebase Console → Firestore Database → Collections

- 🧪 Test đăng nhập bằng cách:
  - Mở app
  - Chọn vai trò "Admin" hoặc "Student"
  - Nhập tên tài khoản và mật khẩu từ bảng tài khoản mặc định

## 🆘 Lỗi Thường Gặp & Giải Pháp

| Lỗi | Nguyên Nhân | Giải Pháp |
|---|---|---|
| `PlatformException: 22, The project ID ... is invalid` | Cấu hình Firebase sai | Chạy `flutterfire configure` lại |
| `MissingPluginException` | Gradle/Pod chưa build | Chạy `flutter clean` & `flutter pub get` |
| `Firestore not initialized` | `Firebase.initializeApp()` chưa chạy | Kiểm tra `main.dart` |
| `Permission denied` | Firestore Rules sai | Cập nhật Rules trong Firebase Console |
| `Connection timeout` | Không kết nối internet | Kiểm tra internet |

## 📈 Tương Lai

- [ ] Cấu hình Firebase Authentication (thay vì lưu mật khẩu)
- [ ] Mã hóa mật khẩu
- [ ] Backup database
- [ ] Phân quyền người dùng
- [ ] Audit log

---

**Sau khi hoàn tất tất cả các bước trên, ứng dụng sẽ hoàn toàn sử dụng Firebase Firestore!**
