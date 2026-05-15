import 'package:flutter/material.dart';
import 'utils/responsive_helper.dart';

class ThongBaoScreen extends StatefulWidget {
  const ThongBaoScreen({super.key});

  @override
  State<ThongBaoScreen> createState() => _ThongBaoScreenState();
}

class _ThongBaoScreenState extends State<ThongBaoScreen> {
  late List<Map<String, String>> danhSachThongBao;
  late TextEditingController tieuDeController;
  late TextEditingController noiDungController;
  late TextEditingController ngayController;
  String selectedLoai = 'Thông báo chung';
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    danhSachThongBao = [
      {
        'tieuDe': 'Thông báo nghỉ lễ Giỗ Tổ Hùng Vương',
        'ngay': '05/04/2026',
        'loai': 'Nghỉ lễ',
        'noiDung': 'Toàn thể sinh viên được nghỉ từ ngày 10/04 đến hết ngày 12/04.'
      },
      {
        'tieuDe': 'Danh sách học bổng học kỳ 1 - 2026',
        'ngay': '02/04/2026',
        'loai': 'Học bổng',
        'noiDung': 'Chúc mừng các bạn sinh viên có tên trong danh sách nhận học bổng khuyến khích.'
      },
      {
        'tieuDe': 'Hội thảo: Lập trình Flutter và Cơ hội nghề nghiệp',
        'ngay': '30/03/2026',
        'loai': 'Sự kiện',
        'noiDung': 'Diễn ra vào 8:30 sáng Thứ 7 tuần này tại Hội trường lớn.'
      },
    ];
    tieuDeController = TextEditingController();
    noiDungController = TextEditingController();
    ngayController = TextEditingController();
  }

  @override
  void dispose() {
    tieuDeController.dispose();
    noiDungController.dispose();
    ngayController.dispose();
    super.dispose();
  }

  void _showNotification(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _resetForm() {
    tieuDeController.clear();
    noiDungController.clear();
    ngayController.clear();
    selectedLoai = 'Thông báo chung';
    editingIndex = null;
  }

  void _showAddEditDialog({int? index}) {
    if (index != null) {
      final item = danhSachThongBao[index];
      tieuDeController.text = item['tieuDe']!;
      noiDungController.text = item['noiDung']!;
      ngayController.text = item['ngay']!;
      selectedLoai = item['loai']!;
      editingIndex = index;
    } else {
      _resetForm();
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.paddingMedium(context),
        ),
        child: Container(
          width: ResponsiveHelper.getDialogWidth(context),
          padding: EdgeInsets.all(ResponsiveHelper.paddingLarge(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                index == null ? 'Thêm thông báo' : 'Sửa thông báo',
                style: TextStyle(
                  fontSize: ResponsiveHelper.headingFontSize(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ResponsiveHelper.paddingLarge(context)),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: tieuDeController,
                        decoration: InputDecoration(
                          labelText: 'Tiêu đề',
                          labelStyle: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall(context)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.paddingMedium(context),
                            vertical: ResponsiveHelper.paddingSmall(context),
                          ),
                        ),
                        style: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
                      ),
                      SizedBox(height: ResponsiveHelper.paddingMedium(context)),
                      TextField(
                        controller: noiDungController,
                        decoration: InputDecoration(
                          labelText: 'Nội dung',
                          labelStyle: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall(context)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.paddingMedium(context),
                            vertical: ResponsiveHelper.paddingSmall(context),
                          ),
                        ),
                        maxLines: 3,
                        style: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
                      ),
                      SizedBox(height: ResponsiveHelper.paddingMedium(context)),
                      TextField(
                        controller: ngayController,
                        decoration: InputDecoration(
                          labelText: 'Ngày (dd/MM/yyyy)',
                          labelStyle: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall(context)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.paddingMedium(context),
                            vertical: ResponsiveHelper.paddingSmall(context),
                          ),
                        ),
                        style: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
                      ),
                      SizedBox(height: ResponsiveHelper.paddingMedium(context)),
                      DropdownButton<String>(
                        value: selectedLoai,
                        isExpanded: true,
                        items: ['Nghỉ lễ', 'Học bổng', 'Sự kiện', 'Thông báo chung']
                            .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
                              ),
                            ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => selectedLoai = value!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ResponsiveHelper.paddingLarge(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Hủy',
                      style: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
                    ),
                  ),
                  SizedBox(width: ResponsiveHelper.paddingSmall(context)),
                  ElevatedButton(
                    onPressed: () {
                      if (tieuDeController.text.isEmpty ||
                          noiDungController.text.isEmpty ||
                  ngayController.text.isEmpty) {
                        _showNotification('Vui lòng điền đầy đủ thông tin!', isError: true);
                        return;
                      }

                      if (editingIndex == null) {
                        danhSachThongBao.add({
                          'tieuDe': tieuDeController.text,
                          'noiDung': noiDungController.text,
                          'ngay': ngayController.text,
                          'loai': selectedLoai,
                        });
                        _showNotification('Thêm thông báo thành công!');
                      } else {
                        danhSachThongBao[editingIndex!] = {
                          'tieuDe': tieuDeController.text,
                          'noiDung': noiDungController.text,
                          'ngay': ngayController.text,
                          'loai': selectedLoai,
                        };
                        _showNotification('Cập nhật thông báo thành công!');
                      }

                      _resetForm();
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Lưu',
                      style: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteNotification(int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.paddingMedium(context),
        ),
        child: Container(
          padding: EdgeInsets.all(ResponsiveHelper.paddingLarge(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Xác nhận xóa',
                style: TextStyle(
                  fontSize: ResponsiveHelper.headingFontSize(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ResponsiveHelper.paddingMedium(context)),
              Text(
                'Bạn có chắc muốn xóa thông báo này?',
                style: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
              ),
              SizedBox(height: ResponsiveHelper.paddingLarge(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Hủy',
                      style: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context)),
                    ),
                  ),
                  SizedBox(width: ResponsiveHelper.paddingSmall(context)),
                  ElevatedButton(
                    onPressed: () {
                      danhSachThongBao.removeAt(index);
                      _showNotification('Xóa thông báo thành công!');
                      setState(() {});
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(
                      'Xóa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveHelper.bodyFontSize(context),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final padding = ResponsiveHelper.paddingMedium(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber, size: ResponsiveHelper.mediumIconSize(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'THÔNG BÁO CHUNG',
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveHelper.headingFontSize(context),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.amber, size: ResponsiveHelper.mediumIconSize(context)),
            onPressed: () => _showAddEditDialog(),
          ),
        ],
      ),
      body: danhSachThongBao.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: ResponsiveHelper.largeIconSize(context), color: Colors.grey[300]),
                  SizedBox(height: ResponsiveHelper.paddingLarge(context)),
                  Text(
                    'Không có thông báo nào',
                    style: TextStyle(fontSize: ResponsiveHelper.bodyFontSize(context), color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(padding),
              itemCount: danhSachThongBao.length,
              itemBuilder: (context, index) {
                final item = danhSachThongBao[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: padding),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusMedium(context)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(ResponsiveHelper.paddingMedium(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTag(item['loai']!),
                            Row(
                              children: [
                                Text(
                                  item['ngay']!,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ResponsiveHelper.smallFontSize(context),
                                  ),
                                ),
                                SizedBox(width: ResponsiveHelper.paddingSmall(context)),
                                PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: const Row(
                                        children: [
                                          Icon(Icons.edit, size: 18),
                                          SizedBox(width: 8),
                                          Text('Sửa'),
                                        ],
                                      ),
                                      onTap: () => _showAddEditDialog(index: index),
                                    ),
                                    PopupMenuItem(
                                      child: const Row(
                                        children: [
                                          Icon(Icons.delete, size: 18, color: Colors.red),
                                          SizedBox(width: 8),
                                          Text('Xóa', style: TextStyle(color: Colors.red)),
                                        ],
                                      ),
                                      onTap: () => _deleteNotification(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['tieuDe']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveHelper.bodyFontSize(context),
                          ),
                        ),
                        SizedBox(height: ResponsiveHelper.paddingSmall(context)),
                        Text(
                          item['noiDung']!,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildTag(String type, {BuildContext? context}) {
    Color bgColor;
    Color textColor;
    switch (type) {
      case 'Nghỉ lễ':
        bgColor = Colors.red[100]!;
        textColor = Colors.red[700]!;
        break;
      case 'Học bổng':
        bgColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        break;
      case 'Sự kiện':
        bgColor = Colors.orange[100]!;
        textColor = Colors.orange[700]!;
        break;
      default:
        bgColor = Colors.blue[100]!;
        textColor = Colors.blue[700]!;
    }
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.paddingSmall(context ?? this.context),
        vertical: ResponsiveHelper.paddingXSmall(context ?? this.context),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall(context ?? this.context)),
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: ResponsiveHelper.smallFontSize(context ?? this.context),
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}