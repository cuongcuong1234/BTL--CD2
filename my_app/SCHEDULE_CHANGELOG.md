# 📋 Tóm Tắt Các Thay Đổi - Thời Khóa Biểu

## 🎯 Mục Đích
Tạo trang thời khóa biểu (Lịch Ca Nhân) với:
- Giao diện giống hình ảnh đề xuất (lịch tuần với giờ học)
- Mỗi tài khoản/lớp có thời khóa biểu khác nhau trong Firestore
- Quản lý đầy đủ (xem, thêm, sửa, xóa) cho admin/teacher
- Sinh viên chỉ xem

---

## 📝 Các File Đã Tạo / Sửa Đổi

### 1️⃣ **lib/thoi_khoa_bieu.dart** ✏️ (Sửa)
**Thay đổi chính**:
- ❌ Xóa giao diện list view cũ
- ✅ Tạo giao diện lịch tuần mới (grid/table style)
- ✅ Load dữ liệu từ Firestore theo `maLop`
- ✅ Implement thêm/sửa/xóa với Firestore
- ✅ Navigation tuần trước/tuần sau
- ✅ Mã màu theo môn học
- ✅ Quyền truy cập theo role

**Tính năng**:
```
- Xem lịch tuần theo giờ (7:00 - 17:00)
- Hiển thị 6 thứ (Thứ 2 - Thứ 7)
- Mỗi ô = 1 lớp học
- Long press để sửa/xóa (nếu là admin/teacher)
- Nút [+ Thêm] để thêm lớp mới
```

### 2️⃣ **lib/services/database_service.dart** ✏️ (Sửa)
**Thêm hàm mới**:

```dart
/// Lấy thời khóa biểu với docId
Future<List<Map<String, dynamic>>> getThoiKhoaBieuWithId(String maLop)

/// Xóa lớp từ thời khóa biểu
Future<bool> deleteThoiKhoaBieu(String docId)

/// Cập nhật lớp trong thời khóa biểu
Future<bool> updateThoiKhoaBieu(String docId, Map<String, dynamic> data)

/// Thêm thời khóa biểu mới
Future<bool> addThoiKhoaBieu({
  required String maLop,
  required String thu,
  required int ordinal,
  required String mon,
  required String phong,
  required String gio,
  required String giangVien,
})
```

**Dữ liệu mẫu**:
- Khởi tạo mặc định 15 lớp học (3 lớp x 5 lớp/tuần)
- Phân chia cho lớp 001, 002, 003

### 3️⃣ **SCHEDULE_IMPLEMENTATION.md** ✨ (Tạo)
Tài liệu kỹ thuật chi tiết:
- Cấu trúc Firestore
- API DatabaseService
- Mã màu môn học
- Quyền truy cập
- Dữ liệu mẫu
- Khắc phục lỗi

### 4️⃣ **SCHEDULE_USER_GUIDE.md** ✨ (Tạo)
Hướng dẫn sử dụng cho developer:
- Cách tích hợp vào app
- Giao diện & tính năng
- Cách sử dụng từ code
- FAQ & Best Practices
- Checklist triển khai

---

## 🗄️ Cơ Sở Dữ Liệu Firestore

### Collection: `thoi_khoa_bieu`
```json
{
  "id": "auto_generated",
  "maLop": "001",           // ← Liên kết đến lớp
  "thu": "Thứ 2",
  "thứTự": 2,
  "mon": "Lập trình Flutter",
  "phong": "P.402",
  "gio": "07:30-09:30",
  "giangVien": "Thầy Nguyễn Văn A"
}
```

### Liên Kết: Collection `tai_khoan` (Sinh viên)
```json
{
  "maTaiKhoan": "20224047",
  "maLop": "001",         // ← Xác định thời khóa biểu
  "tenSV": "Nguyễn Gia Khánh",
  ...
}
```

---

## 🎨 Giao Diện Chính

```
┌──────────────────────────────────────────┐
│ LỊCH CA NHÂN              [+ Thêm]       │ ← AppBar
├──────────────────────────────────────────┤
│ [<] 20/04 - 23/04 [>]                    │ ← Week Header
│                                          │
│ Giờ │ Thứ2 │ Thứ3 │ Thứ4 │ Thứ5 │ Thứ6 │ ← Column Headers
├─────┼──────┼──────┼──────┼──────┼──────┤
│ 7:00│      │      │      │      │      │
│ 8:00│[Flutter]    │[Cấu trúc]    │      │
│ 9:00│  P.402│    │ Lab01 │      │      │
│     │      │      │      │      │      │
│10:00│      │      │      │[Cơ sở DL]  │
│     │      │      │      │ P.305│      │
...
```

---

## ✅ Các Tính Năng Đã Implement

| Tính Năng | Sinh Viên | Giáo Viên | Admin | Ghi Chú |
|-----------|-----------|----------|-------|--------|
| **Xem lịch** | ✅ | ✅ | ✅ | Theo lớp từ DB |
| **Thêm** | ❌ | ✅ | ✅ | Dialog form |
| **Sửa** | ❌ | ✅ | ✅ | Long press -> Edit |
| **Xóa** | ❌ | ✅ | ✅ | Long press -> Delete |
| **Chuyển tuần** | ✅ | ✅ | ✅ | Navigation buttons |
| **Mã màu** | ✅ | ✅ | ✅ | Theo môn học |
| **Loading** | ✅ | ✅ | ✅ | Spinner khi tải |

---

## 🚀 Cách Sử Dụng

### 1. Từ Home hoặc Menu
```dart
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
```

### 2. Xem Lịch
- App tự động load lịch của lớp từ Firestore
- Hiển thị tuần hiện tại
- Click < > để xem tuần khác

### 3. Quản Lý (Admin/Teacher)
- Click **[+ Thêm]** để thêm lớp
- **Long press** trên ô để sửa/xóa
- Form sẽ pop up, nhập thông tin, nhấn **Lưu**

---

## 📊 Dữ Liệu Mẫu

### Lớp 001
- **Sinh viên**: Nguyễn Gia Khánh (20224047), Nguyễn Văn A (12345)
- Thứ 2-3: Lập trình Flutter (07:30-09:30) - P.402
- Thứ 4: Cấu trúc dữ liệu (13:30-15:30) - Lab 01
- Thứ 5: Cơ sở dữ liệu (10:00-12:00) - P.305
- Thứ 7: Mạng máy tính (08:00-10:00) - P.410

### Lớp 002
- **Sinh viên**: Vũ Huy Khánh (20223882), Nguyễn Văn B (42222)
- Thứ 2: Cơ sở dữ liệu (08:00-10:00) - P.305
- Thứ 3: Mạng máy tính (10:00-12:00) - P.410
- Thứ 4: Lập trình C++ (07:30-09:30) - Lab 02
- Thứ 5: Lập trình Flutter (13:30-15:30) - P.402
- Thứ 6: Cấu trúc dữ liệu (08:00-10:00) - Lab 01

### Lớp 003
- **Sinh viên**: Ngô Mạnh Kiên (20224997)
- Thứ 2: Lập trình Flutter (10:00-12:00) - P.402
- Thứ 3: Cơ sở dữ liệu (13:30-15:30) - P.305
- Thứ 4: Mạng máy tính (08:00-10:00) - P.410
- Thứ 5: Cấu trúc dữ liệu (10:00-12:00) - Lab 01
- Thứ 6: Lập trình C++ (13:30-15:30) - Lab 02

---

## 🎨 Mã Màu Môn Học

| Môn | Màu Hex | Flutter |
|----|---------|---------|
| Lập trình Flutter | #2196F3 | Colors.blue |
| Cấu trúc dữ liệu | #FF9800 | Colors.orange |
| Cơ sở dữ liệu | #9C27B0 | Colors.purple |
| Mạng máy tính | #FFC107 | Colors.amber |
| Lập trình C++ | #009688 | Colors.teal |

---

## 🔄 Luồng Dữ Liệu

```
User Login
    ↓
Load ThoiKhoaBieuScreen(userId)
    ↓
Get user info → lấy maLop
    ↓
Query Firestore: thoi_khoa_bieu where maLop == user.maLop
    ↓
orderBy thứTự
    ↓
Hiển thị lịch tuần
    ↓
User action (thêm/sửa/xóa)
    ↓
Update Firestore
    ↓
Reload dữ liệu
```

---

## ⚙️ Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.0.0
  cloud_firestore: ^5.0.0
```

---

## 📌 Các Điểm Quan Trọng

1. **Dữ liệu theo lớp**: Mỗi sinh viên xem lịch của lớp mình (qua `maLop`)
2. **Format giờ**: `HH:mm-HH:mm` (VD: `07:30-09:30`)
3. **Thứ học**: Thứ 2 - Thứ 7 (không có Chủ Nhật)
4. **DocId cần cho sửa/xóa**: Query có include `'id': doc.id`
5. **Quyền theo role**: Kiểm tra `userRole` trong build()
6. **Error handling**: Catch exception và print log
7. **Loading state**: Hiển thị spinner khi tải dữ liệu

---

## 🧪 Test Checklist

- [ ] Sinh viên có thể xem lịch lớp mình
- [ ] Giáo viên có thể thêm lớp học
- [ ] Giáo viên có thể sửa lớp học (long press)
- [ ] Giáo viên có thể xóa lớp học
- [ ] Navigation tuần hoạt động đúng
- [ ] Mã màu hiển thị đúng
- [ ] Firestore update thành công
- [ ] Reload data sau khi thay đổi
- [ ] Không crash khi loading
- [ ] Error handling hoạt động

---

## 📞 Troubleshooting

| Vấn đề | Giải Pháp |
|--------|----------|
| Không hiển thị lịch | Kiểm tra `maLop` trong tài khoản |
| Sửa không cập nhật | Kiểm tra `docId` và `updateThoiKhoaBieu` |
| Xóa không xóa | Kiểm tra `docId` và quyền Firestore |
| Crash khi load | Thêm try-catch và log debug |
| Form không hiển thị | Kiểm tra role, nên là teacher hoặc admin |

---

## 📅 Timeline

- ✅ Database schema design
- ✅ Hàm CRUD trong DatabaseService  
- ✅ UI lịch tuần
- ✅ Load dữ liệu từ Firestore
- ✅ Thêm/Sửa/Xóa
- ✅ Dữ liệu mẫu
- ✅ Tài liệu
- ⏭️ (Optional) Export PDF, Reminder notifications

---

**Status**: ✅ Hoàn tất  
**Version**: 1.0  
**Date**: 23/04/2026
