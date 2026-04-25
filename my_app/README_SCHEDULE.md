# 📅 Thời Khóa Biểu (Lịch Ca Nhân) - Hệ Thống Quản Lý Điểm

## 🎉 Hoàn Thành

Tôi đã tạo xong **trang Thời Khóa Biểu** giống như hình ảnh bạn cung cấp, với:

✅ **Giao diện đẹp**: Lịch tuần với giờ học (7:00-17:00), Thứ 2-7  
✅ **Dữ liệu riêng biệt**: Mỗi tài khoản/lớp có thời khóa biểu khác nhau trong Firestore  
✅ **Quản lý đầy đủ**: Thêm, sửa, xóa lớp học  
✅ **Quyền hạn**: Sinh viên xem, admin/teacher quản lý  
✅ **Tài liệu chi tiết**: 5 file hướng dẫn

---

## 📁 Các File Chính

### 1. Giao Diện
- **[lib/thoi_khoa_bieu.dart](./lib/thoi_khoa_bieu.dart)** - Trang Lịch Ca Nhân
  - Hiển thị lịch tuần (grid)
  - Thêm/sửa/xóa lớp học
  - Navigation tuần trước/sau
  - Mã màu theo môn

### 2. Dữ Liệu
- **[lib/services/database_service.dart](./lib/services/database_service.dart)** - Database Service
  - `getThoiKhoaBieuWithId()` - Lấy lịch với docId
  - `addThoiKhoaBieu()` - Thêm lớp mới
  - `updateThoiKhoaBieu()` - Sửa lớp
  - `deleteThoiKhoaBieu()` - Xóa lớp
  - Dữ liệu mẫu 15 lớp (tự động khởi tạo)

### 3. Firestore
- **Collection: `thoi_khoa_bieu`**
  - 15 documents (3 lớp x 5 lớp/tuần)
  - Field: `maLop, thu, mon, phong, gio, giangVien, thứTự`
  - Liên kết với `tai_khoan` qua `maLop`

---

## 📚 Tài Liệu

| File | Mô Tả | Mục Đích |
|------|--------|---------|
| **[SCHEDULE_SUMMARY.md](./SCHEDULE_SUMMARY.md)** | Tóm tắt hoàn chỉnh | 📌 **ĐỌC ĐẦU TIÊN** |
| **[SCHEDULE_QUICKSTART.md](./SCHEDULE_QUICKSTART.md)** | Hướng dẫn nhanh | Chạy ngay |
| **[SCHEDULE_IMPLEMENTATION.md](./SCHEDULE_IMPLEMENTATION.md)** | Kỹ thuật chi tiết | Phát triển |
| **[SCHEDULE_USER_GUIDE.md](./SCHEDULE_USER_GUIDE.md)** | Hướng dẫn sử dụng | Dùng trong app |
| **[SCHEDULE_CHANGELOG.md](./SCHEDULE_CHANGELOG.md)** | Lịch sử thay đổi | Reference |

---

## 🚀 Bắt Đầu Nhanh

### 1. Chạy App
```bash
cd my_app
flutter pub get
flutter run
```

### 2. Đăng Nhập Demo
```
Sinh Viên:     20224047 / 123456 (lớp 001)
Admin:         20224282 / 123456
```

### 3. Mở Lịch Ca Nhân
- Menu → Lịch Ca Nhân
- Xem lịch của lớp bạn
- (Nếu admin) Thêm/sửa/xóa lớp

---

## 🎨 Giao Diện

```
┌──────────────────────────────────┐
│ LỊCH CA NHÂN          [+ Thêm]   │ ← AppBar
├──────────────────────────────────┤
│ [<] 20/04-23/04 [>]              │ ← Week Navigation
│                                  │
│  Giờ│ T2│ T3│ T4│ T5│ T6│ T7 │   │ ← Column Headers
├─────┼───┼───┼───┼───┼───┼───┤
│ 7:00│   │   │   │   │   │   │
│ 8:00│ [Flutter   ]│ [Cấu trúc ]   │
│ 9:00│  P.402     │ Lab 01│        │
│     │            │       │        │
│10:00│            │  [Cơ sở DL]    │
│     │            │  P.305 │       │
...
```

### Tương Tác
- **Sinh Viên**: Chỉ xem, chuyển tuần
- **Admin/Teacher**: Click [+ Thêm], long press để sửa/xóa

---

## 📊 Dữ Liệu Mẫu

### 3 Lớp x 5 Lớp/Tuần = 15 Lớp Học

**Lớp 001** (Nguyễn Gia Khánh, Nguyễn Văn A)
- Thứ 2-3: Lập trình Flutter (07:30-09:30) - P.402 - Thầy Nguyễn Văn A
- Thứ 4: Cấu trúc dữ liệu (13:30-15:30) - Lab 01 - Cô Trần Thị B
- Thứ 5: Cơ sở dữ liệu (10:00-12:00) - P.305 - Thầy Lê Văn C
- Thứ 7: Mạng máy tính (08:00-10:00) - P.410 - Thầy Hoàng Văn D

**Lớp 002** (Vũ Huy Khánh, Nguyễn Văn B)
- Thứ 2: Cơ sở dữ liệu (08:00-10:00) - P.305 - Thầy Lê Văn C
- Thứ 3: Mạng máy tính (10:00-12:00) - P.410 - Thầy Hoàng Văn D
- Thứ 4: Lập trình C++ (07:30-09:30) - Lab 02 - Cô Ngô Thị E
- Thứ 5: Lập trình Flutter (13:30-15:30) - P.402 - Thầy Nguyễn Văn A
- Thứ 6: Cấu trúc dữ liệu (08:00-10:00) - Lab 01 - Cô Trần Thị B

**Lớp 003** (Ngô Mạnh Kiên)
- Thứ 2: Lập trình Flutter (10:00-12:00) - P.402 - Thầy Nguyễn Văn A
- Thứ 3: Cơ sở dữ liệu (13:30-15:30) - P.305 - Thầy Lê Văn C
- Thứ 4: Mạng máy tính (08:00-10:00) - P.410 - Thầy Hoàng Văn D
- Thứ 5: Cấu trúc dữ liệu (10:00-12:00) - Lab 01 - Cô Trần Thị B
- Thứ 6: Lập trình C++ (13:30-15:30) - Lab 02 - Cô Ngô Thị E

---

## 🎨 Mã Màu Môn Học

```
Lập trình Flutter  → 🔵 Blue   (#2196F3)
Cấu trúc dữ liệu   → 🟠 Orange (#FF9800)
Cơ sở dữ liệu      → 🟣 Purple (#9C27B0)
Mạng máy tính      → 🟡 Amber   (#FFC107)
Lập trình C++      → 🟢 Teal    (#009688)
```

---

## 🗄️ Firestore Schema

### Collection: `thoi_khoa_bieu`
```json
{
  "id": "auto_generated",
  "maLop": "001",
  "thu": "Thứ 2",
  "thứTự": 2,
  "mon": "Lập trình Flutter",
  "phong": "P.402",
  "gio": "07:30-09:30",
  "giangVien": "Thầy Nguyễn Văn A"
}
```

### Collection: `tai_khoan` (Sinh Viên)
```json
{
  "maTaiKhoan": "20224047",
  "tenSV": "Nguyễn Gia Khánh",
  "maLop": "001",           // ← Liên kết đến thời khóa biểu
  "vaiTro": "student",
  "email": "...",
  ...
}
```

---

## 🔧 API DatabaseService

```dart
// Lấy lịch với docId (cho sửa/xóa)
Future<List<Map<String, dynamic>>> getThoiKhoaBieuWithId(String maLop)

// Lấy lịch không có docId
Future<List<Map<String, dynamic>>> getThoiKhoaBieu(String maLop)

// Thêm lớp mới
Future<bool> addThoiKhoaBieu({
  required String maLop,
  required String thu,
  required int ordinal,
  required String mon,
  required String phong,
  required String gio,
  required String giangVien,
})

// Sửa lớp
Future<bool> updateThoiKhoaBieu(String docId, Map<String, dynamic> data)

// Xóa lớp
Future<bool> deleteThoiKhoaBieu(String docId)
```

---

## 💻 Cách Tích Hợp

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
      userRole: userRole,
      userId: userId,
      userClass: maLop,
    ),
  ),
);
```

### Thêm vào Menu/Home
```dart
ListTile(
  title: Text('Lịch Ca Nhân'),
  leading: Icon(Icons.schedule),
  onTap: () => openThoiKhoaBieu(),
)
```

---

## ✅ Tính Năng Hoàn Thành

| Tính Năng | Status | Ghi Chú |
|-----------|--------|--------|
| Xem lịch tuần | ✅ | Grid style, lịch đẹp |
| Load từ Firestore | ✅ | Theo `maLop` |
| Thêm lớp | ✅ | Dialog form |
| Sửa lớp | ✅ | Long press → Edit |
| Xóa lớp | ✅ | Long press → Delete |
| Navigation tuần | ✅ | [<] [>] buttons |
| Mã màu | ✅ | 5 màu theo môn |
| Quyền truy cập | ✅ | Theo role |
| Dữ liệu mẫu | ✅ | 15 lớp x 3 lớp |
| Auto khởi tạo | ✅ | main.dart → initializeDefaultData() |

---

## 🧪 Testing

### Test Sinh Viên
```
1. Đăng nhập: 20224047 / 123456
2. Mở Lịch Ca Nhân
3. ✅ Thấy lịch lớp 001
4. ✅ Không có nút [+ Thêm]
5. ✅ Long press không có menu
6. ✅ Click < > để chuyển tuần
```

### Test Admin
```
1. Đăng nhập: 20224282 / 123456
2. Mở Lịch Ca Nhân
3. ✅ Click [+ Thêm] → Form
4. ✅ Long press ô → Sửa/Xóa
5. ✅ Lưu → Cập nhật Firestore
6. ✅ Xóa → Xóa khỏi Firestore
```

---

## 📞 FAQ

**Q: Sinh viên khác lớp có thể xem lịch của lớp khác không?**  
A: Không. Mỗi sinh viên chỉ xem lịch lớp của họ (qua `maLop`).

**Q: Có thể thêm lớp học ngoài giờ mặc định không?**  
A: Có. Sửa `_gioHoc` list trong code để thêm giờ mới.

**Q: Format giờ là gì?**  
A: `HH:mm-HH:mm` (VD: `07:30-09:30`)

**Q: Có thể chỉnh sửa màu sắc không?**  
A: Có. Sửa hàm `_getMonColor()` để thay đổi màu.

---

## 🔍 Troubleshooting

| Vấn Đề | Giải Pháp |
|--------|----------|
| Không hiển thị lịch | Kiểm tra `maLop` trong tài khoản |
| Sửa không cập nhật | Kiểm tra `docId` và Firestore rules |
| Xóa không xóa | Kiểm tra quyền Firestore |
| Form không hiển thị | Chắc chắn đang đăng nhập là teacher/admin |
| Crash khi load | Kiểm tra try-catch và log debug |

---

## 📈 Bước Tiếp Theo (Optional)

- 🔔 Thêm notification nhắc lớp học
- 📥 Export lịch ra PDF
- 📧 Gửi lịch qua email
- 🔄 Sync với Google Calendar
- 👥 Ghép lịch sinh viên trong lớp
- 📊 Báo cáo lịch dạy/học
- 🔐 Quản lý lớp học theo khoa/ngành

---

## 📋 File Được Tạo/Sửa

```
✏️ Sửa:
  lib/thoi_khoa_bieu.dart
  lib/services/database_service.dart

✨ Tạo:
  SCHEDULE_SUMMARY.md
  SCHEDULE_QUICKSTART.md
  SCHEDULE_IMPLEMENTATION.md
  SCHEDULE_USER_GUIDE.md
  SCHEDULE_CHANGELOG.md
  README_SCHEDULE.md (file này)
```

---

## 🎓 Kiến Thức

Bạn đã học được:
- ✅ Thiết kế giao diện grid/table trong Flutter
- ✅ Query Firestore với where clause
- ✅ CRUD operations (Create, Read, Update, Delete)
- ✅ Quản lý quyền hạn theo role
- ✅ State management và data binding
- ✅ Dialog forms và user input
- ✅ Navigation và routing

---

## 💡 Best Practices

✅ **Làm tốt**
- Luôn check `maLop` trước khi load
- Sử dụng `if (mounted)` trước setState
- Validate input trước lưu
- Catch exception và log
- Reload data sau thay đổi

❌ **Tránh**
- Không hardcode userId
- Không thay dữ liệu local mà không update DB
- Không query DB trong build()
- Không sử dụng async trong build()
- Không xóa admin account

---

## 🏆 Hoàn Thành

**Status**: ✅ Hoàn Thành 100%  
**Version**: 1.0  
**Ngày tạo**: 23/04/2026  
**Cập nhật**: 23/04/2026

---

**📧 Liên hệ / Hỗ Trợ**

Nếu gặp vấn đề:
1. Kiểm tra [SCHEDULE_QUICKSTART.md](./SCHEDULE_QUICKSTART.md)
2. Tìm debug log
3. Kiểm tra Firestore database
4. Review [SCHEDULE_USER_GUIDE.md](./SCHEDULE_USER_GUIDE.md)
5. Tham khảo [SCHEDULE_IMPLEMENTATION.md](./SCHEDULE_IMPLEMENTATION.md)

---

**Cảm ơn bạn đã sử dụng hệ thống! 🙏**
