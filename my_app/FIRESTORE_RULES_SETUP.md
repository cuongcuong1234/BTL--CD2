# 🔐 Firebase Rules - Quick Setup Guide

## ⚠️ CRITICAL - Bạn PHẢI cấu hình này!

Nếu không cấu hình Firestore Rules, ứng dụng sẽ gặp lỗi **"Permission denied"**.

---

## 📋 Các Bước Thiết Lập

### **Step 1: Vào Firebase Console**
1. Mở trình duyệt
2. Truy cập: https://console.firebase.google.com
3. Đăng nhập bằng Gmail

### **Step 2: Chọn Project**
1. Click vào project của bạn (tên project)
2. Dashboard sẽ hiển thị

### **Step 3: Vào Firestore Database**
1. Sidebar trái → Click **Build** (hoặc **Develop**)
2. Click **Firestore Database**

### **Step 4: Mở Rules**
1. Click tab **Rules** (ở cạnh **Data**)
2. Sẽ thấy default rules hay rules cũ

### **Step 5: Copy Rules Mới**

**Copy-paste rules này:**

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Cho phép tất cả người dùng đọc dữ liệu
    match /{collection}/{document=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

### **Step 6: Publish**
1. Edit xong
2. Click **Publish** (nút màu xanh)
3. Chọn **Publish** trong dialog xác nhận
4. Chờ "Published successfully" ✅

---

## ✅ Kiểm Tra Hoàn Tất

Sau khi publish, bạn sẽ thấy:
```
✅ Rules successfully updated
   published on [date] at [time]
```

---

## 🔒 Giải Thích Rules

| Rule | Nghĩa |
|------|-------|
| `allow read: if true;` | Cho phép **tất cả mọi người đọc** dữ liệu |
| `allow write: if request.auth != null;` | Cho phép **người dùng đã đăng nhập ghi** dữ liệu |

Điều này đủ để:
- ✅ Sinh viên xem hồ sơ của mình
- ✅ Sinh viên cập nhật thông tin của mình
- ✅ Admin xem dữ liệu

---

## ⚠️ Lưỡi Đôi (Trade-off)

💡 **Rules này cho phép tất cả mọi người đọc.**
- ✅ Dễ setup
- ✅ Hoạt động nhanh
- ❌ Không bảo mật (ai cũng có thể đọc dữ liệu)

**Nếu muốn bảo mật hơn**, dùng rules này:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Tài khoản - chỉ đọc, không ghi
    match /tai_khoan/{userId} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
    
    // Hồ sơ - sinh viên chỉ có thể edit của mình
    match /ho_so/{userId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update: if request.auth.uid == userId;
      allow delete: if request.auth.uid == userId;
    }
    
    // Dữ liệu khác - chỉ đọc
    match /{document=**} {
      allow read: if true;
      allow write: if false;
    }
  }
}
```

---

## 🆘 Troubleshooting

### **❌ Lỗi: "Permission denied"**
- Bạn chưa publish Rules
- **Giải pháp:** Làm lại step 1-6 ở trên

### **❌ Lỗi: "Rules compilation failed"**
- Rules có syntax error
- **Giải pháp:** 
  1. Xoá hết rules
  2. Copy-paste chính xác rules từ phần "Copy Rules Mới"
  3. Kiểm tra không có ký tự thừa

### **✅ Rules OK nhưng còn lỗi**
- Có thể là lỗi khác (network, Firebase config, v.v.)
- **Giải pháp:** Kiểm tra Firebase configuration trong `firebase_options.dart`

---

## 🔄 Kiểm Tra Rules Hiện Tại

Để xem rules đang chạy:

1. Vào **Firestore Database** → **Rules**
2. Xem rules có lớn như trên không
3. Nếu ngắn hơn (chỉ vài dòng) → chưa được update

---

## 📱 Test Rules

Sau khi publish, test bằng cách:

1. Chạy app: `flutter run`
2. Đăng nhập: username=**20224047**, password=**123456**
3. Vào trang Hồ Sơ
4. Nếu thấy dữ liệu hiển thị → Rules OK ✅
5. Nếu lỗi → Kiểm tra lại Rules

---

## 🎯 Tóm Tắt

| Bước | Việc Cần Làm |
|------|-------------|
| 1 | Vào Firebase Console |
| 2 | Chọn project |
| 3 | Firestore DB → Rules |
| 4 | Copy-paste rules mới |
| 5 | Click Publish |
| ✅ | Xong! |

**Thời gian:** ~2 phút

---

## 💡 Pro Tips

1. **Backup Rules cũ** trước khi thay đổi
   - Copy rules cũ ra notepad

2. **Test Rules** trong Firebase Console
   - Click "Run tests" (nếu có)

3. **Monitor Rules errors** trong Console
   - Vào Firebase Console → Logs

4. **Versioning**
   - Thay đổi major rules → ghi log lại

---

**Đừng quên publish! ⚡**
