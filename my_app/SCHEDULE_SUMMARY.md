# 📌 Tóm Tắt Toàn Bộ - Thời Khóa Biểu (Lịch Ca Nhân)

## 🎯 Yêu Cầu Hoàn Thành

✅ **Giao diện**: Tạo trang thời khóa biểu giống hình ảnh (lịch tuần với giờ học)  
✅ **Dữ liệu**: Mỗi tài khoản/lớp có thời khóa biểu khác nhau trong Firestore  
✅ **Quản lý**: Thêm, sửa, xóa lớp học (cho admin/teacher)  
✅ **Quyền**: Sinh viên chỉ xem, admin/teacher có thể quản lý  

---

## 📦 Các File Chính

### 1. 📄 lib/thoi_khoa_bieu.dart
**Lớp**: `ThoiKhoaBieuScreen` (StatefulWidget)

**Giao diện**:
```
┌─────────────────────────────────────┐
│ LỊCH CA NHÂN              [+ Thêm]  │ ← AppBar
├─────────────────────────────────────┤
│ [<] Tuần 20/04-23/04 [>]             │ ← Navigation
│                                      │
│  Giờ│ Thứ2│ Thứ3│ Thứ4│ Thứ5│ Thứ6 │ ← Cột giờ + Thứ
├────┼─────┼─────┼─────┼─────┼─────┤
│7:00│     │     │     │     │     │
│8:00│[Flutter]  │[Cấu trúc]  │     │
│9:00│ P.402│    │ Lab01 │    │
...
```

**Hàm chính**:
- `initState()` - Load dữ liệu từ Firestore
- `_loadThoiKhoaBieu()` - Fetch từ DB
- `_showForm()` - Dialog thêm/sửa
- `_deleteClass()` - Xóa lớp
- `_buildWeeklySchedule()` - Build giao diện lịch

**Props**:
```dart
userRole: 'student' | 'teacher' | 'admin'
userId: 'mã tài khoản' (bắt buộc)
userClass: 'mã lớp' (optional - sẽ lấy từ DB)
```

### 2. 🔧 lib/services/database_service.dart
**Hàm mới thêm**:

```dart
// Lấy thời khóa biểu với docId (cho sửa/xóa)
getThoiKhoaBieuWithId(String maLop)
  → List<{..., id: docId}>

// Lấy thời khóa biểu không có docId
getThoiKhoaBieu(String maLop)
  → List<{...}>

// Thêm lớp học mới
addThoiKhoaBieu({
  maLop, thu, ordinal, mon, phong, gio, giangVien
})
  → bool

// Cập nhật lớp học
updateThoiKhoaBieu(docId, data)
  → bool

// Xóa lớp học
deleteThoiKhoaBieu(docId)
  → bool
```

**Dữ liệu mẫu**:
- Tự động khởi tạo 15 lớp (3 lớp x 5 lớp/tuần)
- Gọi từ `main.dart` → `initializeDefaultData()`

### 3. 📚 Firestore Schema
```
Collection: thoi_khoa_bieu
├── Document (auto-id)
│   ├── maLop: "001" (string)
│   ├── thu: "Thứ 2" (string)
│   ├── thứTự: 2 (number)
│   ├── mon: "Lập trình Flutter" (string)
│   ├── phong: "P.402" (string)
│   ├── gio: "07:30-09:30" (string)
│   └── giangVien: "Thầy Nguyễn Văn A" (string)
└── ...

Collection: tai_khoan (Sinh viên)
├── Document: "20224047"
│   ├── maTaiKhoan: "20224047"
│   ├── maLop: "001" ← Liên kết
│   ├── tenSV: "Nguyễn Gia Khánh"
│   └── ...
└── ...
```

---

## 🎨 Giao Diện & Tính Năng

### Layout
- **Header**: "LỊCH CA NHÂN" + nút [+ Thêm]
- **Week Navigation**: [<] Ngày tháng [>]
- **Grid Schedule**: 
  - Cột: Giờ (7:00-17:00)
  - Hàng: Thứ 2-7
  - Ô: Lớp học (có màu theo môn)

### Tương Tác
| Hành động | Sinh Viên | Giáo Viên | Admin |
|-----------|-----------|----------|-------|
| Xem lịch | ✅ | ✅ | ✅ |
| Click [+ Thêm] | ❌ | ✅ | ✅ |
| Long press ô | ❌ | ✅ (Sửa/Xóa) | ✅ |

### Form Dialog
```
[Thêm/Sửa Lớp Học]
├── Thứ: [Dropdown]
├── Môn học: [TextField]
├── Phòng: [TextField]
├── Giờ: [TextField] (VD: 07:30-09:30)
├── Giảng viên: [TextField]
└── [Hủy] [Lưu]
```

### Mã Màu Môn Học
```
Lập trình Flutter → Colors.blue (#2196F3)
Cấu trúc dữ liệu → Colors.orange (#FF9800)
Cơ sở dữ liệu → Colors.purple (#9C27B0)
Mạng máy tính → Colors.amber (#FFC107)
Lập trình C++ → Colors.teal (#009688)
```

---

## 🚀 Cách Sử Dụng trong App

### Import
```dart
import 'package:my_app/thoi_khoa_bieu.dart';
```

### Navigate
```dart
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
```

### Tích Hợp vào Home/Drawer
```dart
ListTile(
  title: Text('Lịch Ca Nhân'),
  leading: Icon(Icons.schedule),
  onTap: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ThoiKhoaBieuScreen(
        userRole: user['vaiTro'],
        userId: user['maTaiKhoan'],
        userClass: user['maLop'],
      ),
    ),
  ),
)
```

---

## 📊 Dữ Liệu Mẫu

### Lớp 001 (Nganh CNTT)
- Sinh viên: Nguyễn Gia Khánh, Nguyễn Văn A
- Thứ 2-3: Lập trình Flutter (07:30-09:30) - P.402 - Thầy Nguyễn Văn A
- Thứ 4: Cấu trúc dữ liệu (13:30-15:30) - Lab 01 - Cô Trần Thị B
- Thứ 5: Cơ sở dữ liệu (10:00-12:00) - P.305 - Thầy Lê Văn C
- Thứ 7: Mạng máy tính (08:00-10:00) - P.410 - Thầy Hoàng Văn D

### Lớp 002 (Nganh CNTT/Kế Toán)
- Sinh viên: Vũ Huy Khánh, Nguyễn Văn B
- Thứ 2: Cơ sở dữ liệu (08:00-10:00) - P.305 - Thầy Lê Văn C
- Thứ 3: Mạng máy tính (10:00-12:00) - P.410 - Thầy Hoàng Văn D
- Thứ 4: Lập trình C++ (07:30-09:30) - Lab 02 - Cô Ngô Thị E
- Thứ 5: Lập trình Flutter (13:30-15:30) - P.402 - Thầy Nguyễn Văn A
- Thứ 6: Cấu trúc dữ liệu (08:00-10:00) - Lab 01 - Cô Trần Thị B

### Lớp 003 (Nganh CNTT)
- Sinh viên: Ngô Mạnh Kiên
- Thứ 2: Lập trình Flutter (10:00-12:00) - P.402 - Thầy Nguyễn Văn A
- Thứ 3: Cơ sở dữ liệu (13:30-15:30) - P.305 - Thầy Lê Văn C
- Thứ 4: Mạng máy tính (08:00-10:00) - P.410 - Thầy Hoàng Văn D
- Thứ 5: Cấu trúc dữ liệu (10:00-12:00) - Lab 01 - Cô Trần Thị B
- Thứ 6: Lập trình C++ (13:30-15:30) - Lab 02 - Cô Ngô Thị E

---

## 🧪 Test Scenarios

### Test 1: Sinh Viên Xem Lịch
1. Đăng nhập: 20224047 / 123456 (lớp 001)
2. Mở Lịch Ca Nhân
3. ✅ Thấy lịch lớp 001
4. ✅ Không có nút [+ Thêm]
5. ✅ Long press không có menu

### Test 2: Admin Thêm Lớp
1. Đăng nhập: 20224282 / 123456 (admin)
2. Mở Lịch Ca Nhân
3. Click [+ Thêm]
4. Nhập: Thứ 2, Lập trình Web, P.401, 08:00-10:00, Giáo viên
5. Click Lưu
6. ✅ Thấy ô mới trên lịch

### Test 3: Admin Sửa Lớp
1. Long press ô lớp
2. Chọn "Sửa"
3. Thay đổi dữ liệu
4. Click Lưu
5. ✅ Ô được cập nhật

### Test 4: Admin Xóa Lớp
1. Long press ô lớp
2. Chọn "Xóa"
3. ✅ Ô biến mất

### Test 5: Navigation Tuần
1. Click [>] để xem tuần sau
2. ✅ Ngày tháng thay đổi
3. Click [<] để quay lại
4. ✅ Quay lại tuần trước

---

## 📋 Danh Sách Tài Khoản Demo

```
Tài Khoản (MaTK) | Mật khẩu | Vai Trò | Lớp | Tên
──────────────────────────────────────────────────────
20224282         | 123456   | admin   | -   | Admin
20224047         | 123456   | student | 001 | Nguyễn Gia Khánh
20223882         | 123456   | student | 002 | Vũ Huy Khánh
20224997         | 123456   | student | 003 | Ngô Mạnh Kiên
12345            | 123456   | student | 001 | Nguyễn Văn A
42222            | 123456   | student | 002 | Nguyễn Văn B
```

---

## 📚 Tài Liệu

| File | Mô Tả |
|------|--------|
| [SCHEDULE_QUICKSTART.md](./SCHEDULE_QUICKSTART.md) | Hướng dẫn nhanh |
| [SCHEDULE_IMPLEMENTATION.md](./SCHEDULE_IMPLEMENTATION.md) | Kỹ thuật chi tiết |
| [SCHEDULE_USER_GUIDE.md](./SCHEDULE_USER_GUIDE.md) | Hướng dẫn sử dụng |
| [SCHEDULE_CHANGELOG.md](./SCHEDULE_CHANGELOG.md) | Lịch sử thay đổi |

---

## ⚙️ Cấu Hình

### Tùy Chỉnh Giờ Học
```dart
final List<int> _gioHoc = [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
// Thêm/xóa giờ tùy ý
```

### Tùy Chỉnh Thứ
```dart
final List<String> _thuTrongTuan = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
// Có thể thêm 'Chủ Nhật' nếu cần
```

### Tùy Chỉnh Màu Sắc
```dart
Color _getMonColor(String mon) {
  final colors = {
    'Lập trình Flutter': Colors.blue,
    'Cấu trúc dữ liệu': Colors.orange,
    // Thêm/thay đổi tùy ý
  };
  return colors[mon] ?? Colors.indigo;
}
```

---

## 🔍 Debug

### Console Logs
```
✅ Đã tạo thời khóa biểu mặc định
✅ Đã thêm thời khóa biểu mới
✅ Đã cập nhật thời khóa biểu
✅ Đã xóa thời khóa biểu
❌ Lỗi load thời khóa biểu: [error message]
```

### Kiểm Tra Firestore
- Firebase Console → Firestore → `thoi_khoa_bieu` collection
- Kiểm tra có 15 documents không (3 lớp x 5 lớp)
- Kiểm tra field `maLop`, `mon`, `gio`, etc.

---

## ✅ Hoàn Thành Checklist

- [x] Giao diện lịch tuần
- [x] Load dữ liệu từ Firestore
- [x] Thêm lớp học
- [x] Sửa lớp học
- [x] Xóa lớp học
- [x] Quyền theo role
- [x] Navigation tuần
- [x] Mã màu môn học
- [x] Dữ liệu mẫu
- [x] Tài liệu
- [x] Tài khoản demo

---

## 🎯 Bước Tiếp Theo (Optional)

- 🔔 Notification cho nhắc học
- 📥 Export lịch ra PDF
- 📧 Gửi lịch qua email
- 🔄 Sync lịch với Google Calendar
- 👥 Ghép lịch của sinh viên trong 1 lớp
- 📊 Báo cáo lịch dạy/học

---

**Status**: ✅ Hoàn Thành  
**Version**: 1.0  
**Ngày**: 23/04/2026  
**Cập nhật cuối**: 23/04/2026
