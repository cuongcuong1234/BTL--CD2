# 📚 Hướng Dẫn Sử Dụng - Trang Thời Khóa Biểu

## 🎯 Mô Tả Tính Năng

Trang **Lịch Ca Nhân** (Thời Khóa Biểu) cho phép:
- 👀 **Xem** thời khóa biểu của lớp/sinh viên mình
- ➕ **Thêm** lớp học mới (Admin/Teacher)
- ✏️ **Sửa** thông tin lớp học (Admin/Teacher)
- 🗑️ **Xóa** lớp học (Admin/Teacher)
- 📅 **Chuyển** giữa các tuần khác nhau

---

## 🔧 Cách Tích Hợp vào Ứng Dụng

### 1. Import Trang
```dart
import 'package:my_app/thoi_khoa_bieu.dart';
```

### 2. Sử Dụng Trang trong Navigation
```dart
// Từ menu hoặc drawer
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ThoiKhoaBieuScreen(
      userRole: 'student',      // 'student', 'teacher', 'admin'
      userId: '20224047',        // ID hiện tại của user
      userClass: '001',          // Lớp của user (optional)
    ),
  ),
);
```

### 3. Cách Truyền Tham Số
```dart
ThoiKhoaBieuScreen(
  userRole: userRole,    // Vai trò người dùng
  userId: userId,        // ID tài khoản
  userClass: maLop,      // Mã lớp (nếu không truyền, sẽ tìm từ DB)
)
```

---

## 📊 Giao Diện & Tính Năng

### Layout Chính
```
┌─────────────────────────────────────┐
│ LỊCH CA NHÂN              [+ Thêm]  │  ← AppBar
├─────────────────────────────────────┤
│ 20/04 - 23/04 [<] [>]               │  ← Header tuần
│                                      │
│  Giờ │ Thứ2 │ Thứ3 │ Thứ4 │ Thứ5 │  ← Cột giờ + Thứ
│─────┼──────┼──────┼──────┼──────│
│ 7:00│      │      │      │      │
│ 8:00│ [Flutter]    │ [Cấu trúc]    │
│ 9:00│  P.402  │      │ Lab 01 │
│     │        │      │        │
│10:00│       │ [Mạng máy]    │
│     │       │  P.410 │
...
```

### Tính Năng Giao Diện
- 🎨 **Màu sắc** theo môn học
- 📱 **Responsive** - phù hợp mọi kích thước
- ⏪ **Navigation tuần** - xem tuần trước/sau
- 🔵 **Trạng thái loading** - khi đang tải dữ liệu

---

## 👥 Quyền Truy Cập

| Hành động | Student | Teacher | Admin |
|-----------|---------|---------|-------|
| Xem lịch | ✅ | ✅ | ✅ |
| Thêm | ❌ | ✅ | ✅ |
| Sửa | ❌ | ✅ | ✅ |
| Xóa | ❌ | ✅ | ✅ |

---

## 🎮 Hướng Dẫn Sử Dụng

### Sinh Viên
1. Mở trang "Lịch Ca Nhân"
2. Xem thời khóa biểu của lớp mình
3. Chuyển giữa các tuần khác nhau bằng nút < >

### Giáo Viên / Admin
1. Mở trang "Lịch Ca Nhân"
2. Nhấn nút **[+ Thêm]** để thêm lớp học mới
   - Chọn Thứ, Môn, Phòng, Giờ, Giảng viên
   - Nhấn **Lưu**
3. **Long press** trên ô lớp học để sửa/xóa
   - Chọn **Sửa** → Cập nhật → **Lưu**
   - Chọn **Xóa** → Xác nhận

---

## 💾 Dữ Liệu Firestore

### Cấu Trúc Collection `thoi_khoa_bieu`

```json
{
  "id": "doc_id_tự_động",
  "maLop": "001",
  "thu": "Thứ 2",
  "thứTự": 2,
  "mon": "Lập trình Flutter",
  "phong": "P.402",
  "gio": "07:30-09:30",
  "giangVien": "Thầy Nguyễn Văn A"
}
```

### Liên Kết với Tài Khoản
```json
// Tài khoản sinh viên
{
  "maTaiKhoan": "20224047",
  "maLop": "001",    // ← Liên kết đến thời khóa biểu
  ...
}
```

---

## 🎨 Mã Màu Mặc Định

| Môn | Màu | Hex |
|-----|-----|-----|
| Lập trình Flutter | 🔵 Blue | #2196F3 |
| Cấu trúc dữ liệu | 🟠 Orange | #FF9800 |
| Cơ sở dữ liệu | 🟣 Purple | #9C27B0 |
| Mạng máy tính | 🟡 Amber | #FFC107 |
| Lập trình C++ | 🟢 Teal | #009688 |

---

## ⚙️ Cấu Hình & Tùy Chỉnh

### Thay Đổi Giờ Học
```dart
// Trong _ThoiKhoaBieuScreenState
final List<int> _gioHoc = [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
// Thêm/xóa giờ tùy ý
```

### Thay Đổi Danh Sách Thứ
```dart
final List<String> _thuTrongTuan = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
// Có thể thêm 'Chủ Nhật' nếu cần
```

### Thay Đổi Màu Sắc
```dart
Color _getMonColor(String mon) {
  final colors = {
    'Lập trình Flutter': Colors.blue,
    'Cấu trúc dữ liệu': Colors.orange,
    // Thêm/thay đổi màu tùy ý
  };
  return colors[mon] ?? Colors.indigo;
}
```

---

## 🔍 Khắc Phục Lỗi

### ❌ Lỗi: "Không hiển thị thời khóa biểu"
**Nguyên nhân**: `maLop` không đúng hoặc không có dữ liệu

**Giải pháp**:
1. Kiểm tra tài khoản sinh viên có `maLop` không
2. Kiểm tra Firestore collection `thoi_khoa_bieu` có dữ liệu không
3. Debug: In ra `maLop` trong console

```dart
print('Debug - maLop: $maLop');
print('Debug - schedule: $thoiKhoaBieu');
```

### ❌ Lỗi: "Firestore error: missing or invalid"
**Nguyên nhân**: Dữ liệu truyền vào Firestore không đúng format

**Giải pháp**:
1. Kiểm tra format giờ: `07:30-09:30` (với dấu gạch ngang)
2. Kiểm tra `thu` có trong danh sách `_thuTrongTuan` không
3. Đảm bảo `maLop` không null

### ❌ Lỗi: "State not mounted"
**Nguyên nhân**: Widget đã bị destroy nhưng vẫn cố update

**Giải pháp**: Kiểm tra `if (mounted)` trước khi setState
```dart
if (mounted) {
  setState(() { ... });
}
```

---

## 📱 Ví Dụ Thực Tế

### Ví Dụ 1: Mở Trang từ Home
```dart
void openSchedule() {
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
}
```

### Ví Dụ 2: Thêm Lớp Học từ Admin Panel
```dart
Future<void> addScheduleFromAdmin(String maLop, String mon, String gio) async {
  await DatabaseService().addThoiKhoaBieu(
    maLop: maLop,
    thu: 'Thứ 2',
    ordinal: 2,
    mon: mon,
    phong: 'P.402',
    gio: gio,
    giangVien: 'Giáo viên',
  );
  // Refresh lịch
  setState(() => _loadThoiKhoaBieu());
}
```

---

## 🚀 Best Practices

✅ **Làm tốt**
- Luôn truyền `userId` và `userRole` chính xác
- Kiểm tra `maLop` trước khi load dữ liệu
- Sử dụng `if (mounted)` trước setState
- Format giờ theo chuẩn `HH:mm-HH:mm`

❌ **Tránh**
- Không truyền giá trị hardcoded cho `userId`
- Không thay đổi dữ liệu local mà không update Firestore
- Không query Firestore trong build() method
- Không dùng `async` trong build()

---

## 📞 FAQ

**Q: Làm sao để show lịch của người khác?**
A: Thay đổi `userId` khi tạo instance:
```dart
ThoiKhoaBieuScreen(userId: 'user_id_khac')
```

**Q: Có thể thêm lớp học ngoài các giờ mặc định không?**
A: Có, sửa `_gioHoc` list để thêm giờ mới.

**Q: Làm sao để export lịch ra PDF?**
A: Cần thêm package `pdf` và implement custom export logic.

**Q: Có thể tạo thời khóa biểu theo từng sinh viên không?**
A: Hiện tại là theo lớp. Để per-student, cần thay `maLop` → `maSV` trong query.

---

## 📋 Checklist Triển Khai

- [ ] Import `ThoiKhoaBieuScreen` trong app
- [ ] Thêm route/navigation đến trang
- [ ] Kiểm tra Firestore collection `thoi_khoa_bieu` có dữ liệu
- [ ] Kiểm tra tài khoản sinh viên có field `maLop`
- [ ] Test xem lịch (student)
- [ ] Test thêm lớp (teacher/admin)
- [ ] Test sửa lớp
- [ ] Test xóa lớp
- [ ] Test chuyển tuần
- [ ] Check loading state
- [ ] Kiểm tra error handling

---

**Phiên bản**: 1.0  
**Cập nhật lần cuối**: 23/04/2026  
**Tác giả**: Development Team
