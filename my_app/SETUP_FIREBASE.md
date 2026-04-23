# 🔧 Hướng Dẫn Cấu Hình Firebase

## Bước 1: Tạo Firebase Project

1. Truy cập [Firebase Console](https://console.firebase.google.com/)
2. Nhấp **"Tạo project"** → Điền tên: `my_app`
3. Bỏ chọn "Enable Google Analytics" (tùy chọn)
4. Chọn **"Tiếp tục"** → **"Tạo project"**

## Bước 2: Thêm Các Ứng Dụng

### Android:
1. Trong Firebase Console, click **"Thêm ứng dụng"** → Chọn **Android**
2. Điền:
   - **Tên gói Android**: `com.example.my_app`
   - Tải `google-services.json` và đặt tại: `android/app/`
3. Click **"Tiếp tục"** để hoàn tất

### iOS (nếu cần):
1. Click **"Thêm ứng dụng"** → Chọn **iOS**
2. Điền **ID Bundle**: `com.example.my-app`
3. Tải file `GoogleService-Info.plist` và đặt vào Xcode project

### Web (nếu cần):
1. Click **"Thêm ứng dụng"** → Chọn **Web**
2. Sao chép cấu hình và thay vào `lib/firebase_options.dart`

### Windows (nếu cần):
1. Click **"Thêm ứng dụng"** → Chọn **Windows**
2. Sao chép cấu hình và thay vào `lib/firebase_options.dart`

## Bước 3: Kích Hoạt Firestore Database

1. Trong Firebase Console, chọn **"Build"** → **"Firestore Database"**
2. Nhấp **"Tạo database"**
3. Chọn **"Bắt đầu ở chế độ test"** (để phát triển)
4. Chọn vị trí: **"asia-southeast1"** (Singapore hoặc gần nhất)
5. Click **"Tạo"**

## Bước 4: Cấu Hình Quy Tắc Firestore

1. Trong Firestore, chọn tab **"Quy tắc"**
2. Thay thế bằng:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Cho phép đọc/ghi tài khoản admin
    match /tai_khoan/{document=**} {
      allow read, write: if request.auth != null;
      // Chế độ test - cho phép tất cả (chỉ sử dụng khi phát triển)
      // allow read, write: if true;
    }
  }
}
```

3. Click **"Xuất bản"**

## Bước 5: Tạo Tổng Hợp Cấu Hình

Chạy lệnh FlutterFire CLI (cách tốt nhất):

```bash
# Cài đặt FlutterFire CLI
flutter pub global activate flutterfire_cli

# Cấu hình Firebase (tự động tạo firebase_options.dart)
flutterfire configure --project=my-project-id
```

**Hoặc**: Sao chép cấu hình thủ công vào `lib/firebase_options.dart`:
- Vào Firebase Console → Cài đặt Project → Ứng dụng của bạn
- Sao chép các khóa JSON được cung cấp

## Bước 6: Cài Đặt Dependencies

```bash
flutter pub get
```

## Bước 7: Kiểm Tra Kết Nối

Chạy ứng dụng:

```bash
flutter run
```

Nếu không có lỗi, Firebase đã được cấu hình thành công! ✅

## 📊 Cơ Sở Dữ Liệu Firestore

### Cấu Trúc Collection: `tai_khoan`

```
tai_khoan/
├── 20224282 (Admin)
│   ├── maTaiKhoan: "20224282"
│   ├── matKhau: "123456"
│   ├── vaiTro: "admin"
│   └── ngayTao: timestamp
│
├── 20224047 (Student)
│   ├── maTaiKhoan: "20224047"
│   ├── tenSV: "Nguyễn Gia Khánh"
│   ├── matKhau: "123456"
│   ├── vaiTro: "student"
│   ├── email: "nguyenkhanh@gmail.com"
│   ├── maLop: "001"
│   ├── tenNganh: "CNTT"
│   └── ngayTao: timestamp
...
```

## 🔐 Lưu Ý Bảo Mật

- ⚠️ **Chỉ sử dụng chế độ Test cho phát triển**
- 🔒 Trước khi deploy, thay đổi Firestore Rules
- 🔑 Không để khóa API trong mã source
- ⚡ Sử dụng Firebase Authentication thay vì lưu mật khẩu

## 🐛 Troubleshooting

### Lỗi "PlatformException"
- Kiểm tra `google-services.json` có tồn tại
- Xóa build cũ: `flutter clean`

### Lỗi "Firebase not initialized"
- Chắc chắn gọi `Firebase.initializeApp()` trong `main()`

### Lỗi "Firestore không kết nối"
- Kiểm tra quy tắc Firestore (Rules)
- Đảm bảo đã kích hoạt Firestore Database

## 📚 Tài Liệu Tham Khảo

- [Firebase Flutter Documentation](https://firebase.flutter.dev)
- [Firestore Best Practices](https://firebase.google.com/docs/firestore/best-practices)
