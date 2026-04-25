# 📅 Hệ Thống Thời Khóa Biểu - Tài Liệu Kỹ Thuật

## ✨ Tính Năng

### 1. **Giao Diện Lịch Tuần** (Giống hình ảnh yêu cầu)
- 📊 Hiển thị theo lịch tuần (Thứ 2 - Thứ 7)
- 🕐 Thang giờ từ 7:00 - 17:00
- 🎨 Mã màu cho từng môn học
- 📱 Responsive và dễ đọc
- ⏪ Navigation tuần trước/tuần sau

### 2. **Dữ Liệu Theo Từng Tài Khoản**
- ✅ Mỗi sinh viên xem thời khóa biểu của lớp mình
- ✅ Mỗi lớp có thời khóa biểu khác nhau trong Firestore
- ✅ Thông tin lớp lưu trong tài khoản sinh viên (maLop)
- ✅ Thời khóa biểu được query theo `maLop`

### 3. **Quản Lý (Cho Admin/Giáo Viên)**
- ➕ Thêm lớp học mới
- ✏️ Sửa thông tin lớp học (Long press trên ô)
- 🗑️ Xóa lớp học
- 💾 Tự động lưu vào Firestore

---

## 📊 Cơ Sở Dữ Liệu Firestore

### Collection: `thoi_khoa_bieu`
Mỗi tài khoản/lớp có thời khóa biểu riêng:

```
Document trong collection "thoi_khoa_bieu":
{
  "maLop": "001",           // Mã lớp (sinh viên xem theo lớp của họ)
  "thu": "Thứ 2",           // Thứ trong tuần
  "thứTự": 2,              // Sắp xếp
  "mon": "Lập trình Flutter",
  "phong": "P.402",
  "gio": "07:30-09:30",     // Format: HH:mm-HH:mm
  "giangVien": "Thầy Nguyễn Văn A"
}
```

### Collection: `tai_khoan` (Sinh viên)
```
{
  "maTaiKhoan": "20224047",
  "tenSV": "Nguyễn Gia Khánh",
  "maLop": "001",           // ⭐ Liên kết đến thời khóa biểu
  "matKhau": "123456",
  "vaiTro": "student",
  "email": "...",
  ...
}
```

---

## 🔧 Cách Sử Dụng

### 1. Load Thời Khóa Biểu
```dart
// Lấy lớp của sinh viên từ tài khoản
final studentInfo = await databaseService.getStudent(userId);
String maLop = studentInfo?['maLop'] ?? '001';

// Lấy thời khóa biểu của lớp
final schedule = await databaseService.getThoiKhoaBieu(maLop);
```

### 2. Thêm Lớp Học Mới
```dart
await databaseService.addThoiKhoaBieu(
  maLop: '001',
  thu: 'Thứ 2',
  ordinal: 2,
  mon: 'Lập trình Flutter',
  phong: 'P.402',
  gio: '07:30-09:30',
  giangVien: 'Thầy Nguyễn Văn A',
);
```

### 3. Sửa Lớp Học
```dart
await databaseService.updateLichHoc(docId, {
  'mon': 'Tên môn mới',
  'phong': 'Phòng mới',
  'gio': '08:00-10:00',
});
```

### 4. Xóa Lớp Học
```dart
await databaseService.deleteLichHoc(docId);
```

---

## 🎨 Mã Màu Môn Học

| Môn Học | Màu |
|---------|-----|
| Lập trình Flutter | 🔵 Blue |
| Cấu trúc dữ liệu | 🟠 Orange |
| Cơ sở dữ liệu | 🟣 Purple |
| Mạng máy tính | 🟡 Amber |
| Lập trình C++ | 🟢 Teal |

---

## 📱 Thông Tin Chi Tiết - Lớp Học Mẫu

### Lớp 001
- **Sinh viên**: Nguyễn Gia Khánh (20224047), Nguyễn Văn A (12345)
- **Thứ 2**: Lập trình Flutter (07:30-09:30) - P.402
- **Thứ 3**: Lập trình Flutter (07:30-09:30) - P.402
- **Thứ 4**: Cấu trúc dữ liệu (13:30-15:30) - Lab 01
- **Thứ 5**: Cơ sở dữ liệu (10:00-12:00) - P.305
- **Thứ 7**: Mạng máy tính (08:00-10:00) - P.410

### Lớp 002
- **Sinh viên**: Vũ Huy Khánh (20223882), Nguyễn Văn B (42222)
- **Thứ 2**: Cơ sở dữ liệu (08:00-10:00) - P.305
- **Thứ 3**: Mạng máy tính (10:00-12:00) - P.410
- **Thứ 4**: Lập trình C++ (07:30-09:30) - Lab 02
- **Thứ 5**: Lập trình Flutter (13:30-15:30) - P.402
- **Thứ 6**: Cấu trúc dữ liệu (08:00-10:00) - Lab 01

### Lớp 003
- **Sinh viên**: Ngô Mạnh Kiên (20224997)
- **Thứ 2**: Lập trình Flutter (10:00-12:00) - P.402
- **Thứ 3**: Cơ sở dữ liệu (13:30-15:30) - P.305
- **Thứ 4**: Mạng máy tính (08:00-10:00) - P.410
- **Thứ 5**: Cấu trúc dữ liệu (10:00-12:00) - Lab 01
- **Thứ 6**: Lập trình C++ (13:30-15:30) - Lab 02

---

## 🔐 Quyền Truy Cập

| Vai Trò | Xem | Thêm | Sửa | Xóa |
|---------|-----|------|-----|-----|
| **Student** | ✅ | ❌ | ❌ | ❌ |
| **Teacher** | ✅ | ✅ | ✅ | ✅ |
| **Admin** | ✅ | ✅ | ✅ | ✅ |

---

## 📝 Ghi Chú Quan Trọng

1. **Format giờ**: Sử dụng `HH:mm-HH:mm` (VD: `07:30-09:30`)
2. **Thứ trong tuần**: Thứ 2, Thứ 3, ..., Thứ 7 (không có Chủ Nhật)
3. **Mã lớp**: Liên kết giữa `tai_khoan` và `thoi_khoa_bieu` collection
4. **Navigation**: Có thể xem tuần trước/tuần sau
5. **Long press**: Trên ô lớp học để xem menu sửa/xóa

---

## 🚀 Khởi Tạo Dữ Liệu Mẫu

Khi ứng dụng khởi động, dữ liệu mẫu sẽ được tạo tự động:
```dart
await _databaseService.initializeDefaultData();
```

Để tạo lại dữ liệu:
```dart
await _databaseService.reinitializeScheduleData();
```

---

## ⚙️ Lỗi Thường Gặp

| Lỗi | Nguyên Nhân | Giải Pháp |
|-----|-----------|----------|
| Không hiển thị thời khóa biểu | `maLop` không đúng | Kiểm tra `maLop` trong tài khoản |
| Ô học trống | Không có lớp trong thời gian đó | Thêm lớp học mới |
| Sửa không cập nhật | Chưa implement Firestore update | Sử dụng `updateLichHoc()` |

---

## 📞 Liên Hệ / Hỗ Trợ

Nếu gặp vấn đề, kiểm tra:
1. Database cho collection `thoi_khoa_bieu`
2. Trường `maLop` trong tài khoản sinh viên
3. Format giờ `07:30-09:30`
4. Kết nối Firebase
