# ⚡ Quick Start - Thời Khóa Biểu

## 🚀 Bắt Đầu Nhanh

### 1️⃣ Chạy Ứng Dụng
```bash
cd my_app
flutter pub get
flutter run
```

### 2️⃣ Đăng Nhập
```
Mã tài khoản: 20224047
Mật khẩu: 123456
(Sinh viên lớp 001)
```

hoặc

```
Mã tài khoản: 20224282
Mật khẩu: 123456
(Admin - quản lý toàn bộ)
```

### 3️⃣ Mở Trang Thời Khóa Biểu
- Từ menu home → Chọn "Lịch Ca Nhân"
- Hoặc navigate từ drawer

### 4️⃣ Xem Lịch
- Hiển thị tự động lịch của lớp của bạn
- Click `<` `>` để chuyển tuần

### 5️⃣ Quản Lý (Nếu là Admin/Teacher)
- Click **[+ Thêm]** ở góc phải AppBar
- Nhập thông tin → Nhấn **Lưu**

---

## 📱 Tài Khoản Demo

| Mã TK | Mật khẩu | Vai Trò | Lớp | Mục Đích |
|-------|---------|--------|-----|---------|
| 20224282 | 123456 | admin | - | Quản lý toàn bộ |
| 20224047 | 123456 | student | 001 | Xem lịch lớp 001 |
| 20223882 | 123456 | student | 002 | Xem lịch lớp 002 |
| 20224997 | 123456 | student | 003 | Xem lịch lớp 003 |
| 12345 | 123456 | student | 001 | Xem lịch lớp 001 |
| 42222 | 123456 | student | 002 | Xem lịch lớp 002 |

---

## 🎯 Thử Các Tính Năng

### Sinh viên (20224047)
1. ✅ Xem lịch của lớp 001
2. ❌ Không thể thêm/sửa/xóa

### Admin (20224282)
1. ✅ Xem lịch tất cả lớp
2. ✅ Thêm lớp mới
3. ✅ Sửa lớp (long press)
4. ✅ Xóa lớp (long press)

---

## 📊 Lịch Mẫu Sẵn Có

```
Lớp 001:
  Thứ 2-3: Lập trình Flutter (07:30-09:30) - P.402
  Thứ 4:   Cấu trúc dữ liệu (13:30-15:30) - Lab 01
  Thứ 5:   Cơ sở dữ liệu (10:00-12:00) - P.305
  Thứ 7:   Mạng máy tính (08:00-10:00) - P.410

Lớp 002:
  Thứ 2: Cơ sở dữ liệu (08:00-10:00) - P.305
  Thứ 3: Mạng máy tính (10:00-12:00) - P.410
  Thứ 4: Lập trình C++ (07:30-09:30) - Lab 02
  Thứ 5: Lập trình Flutter (13:30-15:30) - P.402
  Thứ 6: Cấu trúc dữ liệu (08:00-10:00) - Lab 01

Lớp 003:
  Thứ 2: Lập trình Flutter (10:00-12:00) - P.402
  Thứ 3: Cơ sở dữ liệu (13:30-15:30) - P.305
  Thứ 4: Mạng máy tính (08:00-10:00) - P.410
  Thứ 5: Cấu trúc dữ liệu (10:00-12:00) - Lab 01
  Thứ 6: Lập trình C++ (13:30-15:30) - Lab 02
```

---

## 🔧 Nếu Lỗi

### Lỗi: "Collection not found"
**Giải pháp**: Dữ liệu chưa được khởi tạo
- Mở Debug Console
- Tìm message: "✅ Đã tạo thời khóa biểu mặc định"
- Nếu không thấy → App chưa khởi động xong
- Restart app

### Lỗi: "Không hiển thị lịch"
**Giải pháp**:
1. Kiểm tra `maLop` trong tài khoản
2. Kiểm tra có dữ liệu trong Firestore không
3. Restart app

### Lỗi: "Long press không có menu"
**Giải pháp**:
- Chắc chắn đang đăng nhập với admin account
- Thử restart app

---

## 💡 Tips

1. 📱 **Responsive**: Thử resize cửa sổ để thấy auto-adjust
2. 🎨 **Màu**: Mỗi môn có màu khác nhau
3. ⏪ **Navigation**: Click `<` hoặc `>` để xem tuần khác
4. ✏️ **Edit**: Long press (giữ lâu) trên ô học để edit
5. 💾 **Auto Save**: Mọi thay đổi tự động lưu vào Firestore

---

## 🎬 Scenario Demo

### Scenario 1: Sinh viên xem lịch
1. Đăng nhập: 20224047
2. Vào "Lịch Ca Nhân"
3. Xem lịch lớp 001
4. Click `>` để xem tuần sau
5. Xem không thể thêm/sửa/xóa

### Scenario 2: Admin quản lý lịch
1. Đăng nhập: 20224282
2. Vào "Lịch Ca Nhân"
3. Click `[+ Thêm]`
4. Nhập: Thứ 2, Lập trình Web, P.401, 07:30-09:30, Cô Trần
5. Nhấn Lưu → Thấy ô mới trên lịch
6. Long press ô mới → Sửa hoặc Xóa
7. Sửa thành công → Ô được cập nhật
8. Xóa thành công → Ô biến mất

---

## 📚 Tài Liệu Thêm

- [SCHEDULE_IMPLEMENTATION.md](./SCHEDULE_IMPLEMENTATION.md) - Kỹ thuật chi tiết
- [SCHEDULE_USER_GUIDE.md](./SCHEDULE_USER_GUIDE.md) - Hướng dẫn sử dụng
- [SCHEDULE_CHANGELOG.md](./SCHEDULE_CHANGELOG.md) - Lịch sử thay đổi

---

## ✅ Checklist

Trước khi sử dụng:
- [ ] Chạy `flutter pub get`
- [ ] Cấu hình Firebase (nếu chưa)
- [ ] Firestore rules cho phép read/write
- [ ] Hot reload/restart app
- [ ] Kiểm tra console có message khởi tạo
- [ ] Test xem lịch
- [ ] Test (nếu admin) thêm/sửa/xóa

---

**Bây giờ bạn đã sẵn sàng!** 🎉

Mở app → Đăng nhập → Xem lịch ca nhân của bạn!
