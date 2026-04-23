# 📱 Hướng Dẫn Firebase Database cho Trang Hồ Sơ Cá Nhân

## 🎯 Mục Đích
Hệ thống lưu trữ thông tin hồ sơ cá nhân của sinh viên trên Firebase Firestore. Sau khi đăng nhập, trang hồ sơ sẽ tự động lấy dữ liệu từ database và hiển thị thông tin cho từng tài khoản.

---

## 📊 Cấu Trúc Database

### 1. **Collection: `tai_khoan` (Tài Khoản)**
Lưu trữ thông tin đăng nhập và vai trò của người dùng.

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
  │   ├── matKhau: "123456"
  │   ├── tenSV: "Nguyễn Gia Khánh"
  │   ├── email: "nguyenkhanh@gmail.com"
  │   ├── maLop: "001"
  │   ├── tenNganh: "CNTT"
  │   ├── vaiTro: "student"
  │   └── ngayTao: timestamp
```

### 2. **Collection: `ho_so` (Hồ Sơ Cá Nhân)**
Lưu trữ **thông tin chi tiết của sinh viên** (điểm, liên hệ, giấy tờ, v.v.)

```
ho_so/
  ├── 20224047
  │   ├── maSV: "20224047"
  │   ├── tenSV: "Nguyễn Gia Khánh"
  │   ├── ngaySinh: "15/05/2005"
  │   ├── gioiTinh: "Nữ"
  │   ├── queQuan: "Hà Nội"
  │   ├── sdt: "0912345678"
  │   ├── email: "nguyenkhanh@gmail.com"
  │   ├── diaChi: "123 Đường A, Quận 1, TP.HCM"
  │   ├── danToc: "Kinh"
  │   ├── tonGiao: "Không"
  │   ├── cmnd: "123456789"
  │   └── ngayCapCmnd: "01/01/2023"
  │
  ├── 20223882
  │   ├── maSV: "20223882"
  │   ├── tenSV: "Vũ Huy Khánh"
  │   └── ... (các trường tương tự)
```

### 3. **Collection: `diem` (Điểm Số)**
Lưu trữ điểm của sinh viên theo môn học

```
diem/
  ├── doc1
  │   ├── maSV: "20224047"
  │   ├── mon: "Lập trình Flutter"
  │   ├── diem: 8.5
  │   ├── hocKy: "HK1-2026"
  │   └── namHoc: "2025-2026"
  │
  ├── doc2
  │   ├── maSV: "20224047"
  │   ├── mon: "Cấu trúc dữ liệu"
  │   ├── diem: 8.2
  │   └── ...
```

### 4. **Collection: `lich_hoc` (Lịch Học)**
Lưu trữ lịch học của sinh viên

```
lich_hoc/
  ├── doc1
  │   ├── maSV: "20224047"
  │   ├── thu: "Thứ 2"
  │   ├── thứTự: 2
  │   ├── mon: "Lập trình Flutter"
  │   ├── phong: "P.402"
  │   ├── gio: "07:30 - 09:30"
  │   └── giangVien: "Thầy Nguyễn Văn A"
```

### 5. **Collection: `thoi_khoa_bieu` (Thời Khóa Biểu)**
Lưu trữ thời khóa biểu của lớp

```
thoi_khoa_bieu/
  ├── doc1
  │   ├── maLop: "001"
  │   ├── thu: "Thứ 2"
  │   ├── thứTự: 2
  │   ├── mon: "Lập trình Flutter"
  │   ├── phong: "P.402"
  │   ├── gio: "07:30-09:30"
  │   └── giangVien: "Thầy Nguyễn Văn A"
```

---

## 🔐 Firestore Security Rules

Để cho phép ứng dụng đọc/ghi dữ liệu, bạn cần cấu hình Firestore Rules như sau:

### ✅ **Cho Env Development/Test** (KHÔNG DÙNG TRONG PRODUCTION)

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Cho phép tất cả mọi người đọc và ghi
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

### ✅ **Recommended Rules** (Bảo mật hơn)

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Cho phép đọc tất cả collections
    match /{collection}/{document=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
    
    // Sinh viên chỉ có thể cập nhật hồ sơ của chính mình
    match /ho_so/{userId} {
      allow read: if true;
      allow update, delete: if request.auth.uid == userId;
      allow create: if request.auth.uid != null;
    }
  }
}
```

### 📍 **Cách thiết lập Rules trên Firebase Console:**

1. Truy cập [Firebase Console](https://console.firebase.google.com)
2. Chọn project của bạn
3. Đi đến **Firestore Database** → **Rules**
4. Xoá rules cũ và paste rules ở trên
5. Click **Publish**

---

## 🚀 Các Hàm Database Service

### **1. Lấy hồ sơ sinh viên**
```dart
Future<Map<String, dynamic>?> getHoSoSV(String maSV)
```
- **Tham số:** `maSV` - Mã số sinh viên (username đăng nhập)
- **Trả về:** Map chứa thông tin hồ sơ hoặc null nếu không tìm thấy
- **Ví dụ:** `DatabaseService().getHoSoSV('20224047')`

### **2. Cập nhật hồ sơ sinh viên**
```dart
Future<bool> updateHoSoSV(String maSV, Map<String, dynamic> data)
```
- **Tham số:** 
  - `maSV` - Mã số sinh viên
  - `data` - Map các trường cần cập nhật
- **Trả về:** `true` nếu thành công, `false` nếu thất bại
- **Ví dụ:**
```dart
await DatabaseService().updateHoSoSV('20224047', {
  'email': 'newemail@example.com',
  'sdt': '0987654321',
  'diaChi': 'Địa chỉ mới'
});
```

### **3. Tạo hồ sơ sinh viên mới**
```dart
Future<bool> createHoSoSV(String maSV, Map<String, dynamic> data)
```
- **Tham số:** 
  - `maSV` - Mã số sinh viên (Primary Key)
  - `data` - Map chứa toàn bộ thông tin hồ sơ
- **Trả về:** `true` nếu thành công, `false` nếu thất bại

---

## 📱 Cách Dữ Liệu Được Tạo

### **Khi ứng dụng khởi động (main.dart):**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1️⃣ Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // 2️⃣ Tạo tài khoản mặc định
  await DatabaseService().initializeDefaultAccounts();
  
  // 3️⃣ Tạo dữ liệu mẫu (hồ sơ, điểm, lịch học)
  await DatabaseService().initializeDefaultData();
  
  // 4️⃣ Tạo lại dữ liệu thời khóa biểu
  await DatabaseService().reinitializeScheduleData();
  
  runApp(const MyApp());
}
```

### **Tài khoản mặc định:**

| Mã Tài Khoản | Mật khẩu | Vai trò | Tên           |
|-------------|----------|--------|---------------|
| 20224282    | 123456   | admin  | Admin         |
| 20224047    | 123456   | student| Nguyễn Gia Khánh |
| 20223882    | 123456   | student| Vũ Huy Khánh |
| 20224997    | 123456   | student| Ngô Mạnh Kiên |
| 12345       | 123456   | student| Nguyễn Văn A |
| 42222       | 123456   | student| Nguyễn Văn B |

---

## 🎯 Quy Trình Hoạt Động

### **1. Đăng Nhập**
```
Người dùng nhập username & password
           ↓
DatabaseService.checkLogin(username, password, role)
           ↓
Kiểm tra trong collection 'tai_khoan'
           ↓
Nếu đúng → Chuyển đến trang Home
Nếu sai → Hiển thị lỗi
```

### **2. Xem Hồ Sơ Cá Nhân**
```
Người dùng click "Hồ Sơ"
           ↓
HoSoCaNhanScreen khởi tạo
           ↓
gọi DatabaseService().getHoSoSV(username)
           ↓
Lấy dữ liệu từ collection 'ho_so' bằng maSV = username
           ↓
Hiển thị thông tin trong FutureBuilder
```

### **3. Chỉnh Sửa Hồ Sơ**
```
Người dùng click nút "Edit"
           ↓
Hiển thị các TextField với dữ liệu hiện tại
           ↓
Người dùng thay đổi thông tin
           ↓
Click "Lưu"
           ↓
gọi DatabaseService().updateHoSoSV(username, updateData)
           ↓
Cập nhật thông tin trong collection 'ho_so'
           ↓
Hiển thị thông báo thành công
           ↓
Quay lại chế độ xem
```

---

## ⚠️ Troubleshooting

### **❌ Lỗi: "Permission denied"**
- **Nguyên nhân:** Firestore Rules chưa được cấu hình
- **Giải pháp:** Cập nhật Rules theo hướng dẫn ở trên

### **❌ Lỗi: "Không tìm thấy dữ liệu hồ sơ"**
- **Nguyên nhân:** Dữ liệu chưa được khởi tạo hoặc username không khớp
- **Giải pháp:** 
  1. Kiểm tra Firebase Console xem có collection `ho_so` không
  2. Đảm bảo tài khoản đã được tạo trong `tai_khoan` collection
  3. Chạy lại ứng dụng để trigger initialization

### **❌ Lỗi: "Không thể cập nhật hồ sơ"**
- **Nguyên nhân:** Rules không cho phép ghi dữ liệu
- **Giải pháp:** Cấu hình Rules để cho phép ghi

### **✅ Lỗi khác?**
- Kiểm tra Firebase Console Console logs
- Xem debug output trong terminal Flutter: `flutter logs`
- Kiểm tra Firestore Rules và Network connectivity

---

## 📚 Các Fields Trong Collection `ho_so`

| Field | Type | Mô Tả | Ví dụ |
|-------|------|-------|-------|
| maSV | String | Mã số sinh viên (Primary Key) | 20224047 |
| tenSV | String | Tên sinh viên | Nguyễn Gia Khánh |
| ngaySinh | String | Ngày sinh | 15/05/2005 |
| gioiTinh | String | Giới tính | Nữ / Nam |
| queQuan | String | Quê quán | Hà Nội |
| sdt | String | Số điện thoại | 0912345678 |
| email | String | Email | nguyenkhanh@gmail.com |
| diaChi | String | Địa chỉ | 123 Đường A, Quận 1 |
| danToc | String | Dân tộc | Kinh |
| tonGiao | String | Tôn giáo | Không |
| cmnd | String | CMND/CCCD | 123456789 |
| ngayCapCmnd | String | Ngày cấp CMND | 01/01/2023 |

---

## 🔄 Cách Quản Lý Dữ Liệu

### **Thêm sinh viên mới:**
```dart
await DatabaseService().addAccount(
  maTaiKhoan: '12346',
  matKhau: '123456',
  vaiTro: 'student',
  tenSV: 'Tên Mới',
  email: 'email@example.com',
);

// Rồi tạo hồ sơ
await DatabaseService().createHoSoSV('12346', {
  'maSV': '12346',
  'tenSV': 'Tên Mới',
  'email': 'email@example.com',
  // ... các trường khác
});
```

### **Cập nhật thông tin:**
```dart
await DatabaseService().updateHoSoSV('20224047', {
  'sdt': '0987654321',
  'email': 'newemail@gmail.com',
});
```

### **Xóa tài khoản:**
```dart
await DatabaseService().deleteAccount('20224047');
```

---

## 📞 Support

Nếu gặp vấn đề:
1. Kiểm tra console đầu ra trong Flutter
2. Kiểm tra Firestore Rules còn hiệu lực không
3. Xoá và tạo lại project nếu cần thiết
4. Kiểm tra internet connection

---

**✅ Hoàn tất! Bây giờ bạn đã có một hệ thống quản lý hồ sơ cá nhân hoàn chỉnh trên Firebase!**
