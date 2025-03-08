import 'package:flutter/material.dart';

class InvoiceDetailsPage extends StatelessWidget {
  final String invoiceId;
  final String customerName;
  final String customerPhone;
  final String payType;
  final String productName;
  final num price;
  final num discount;
  final num amount;
  final num totalPrice;
  final String createdByName;
  final String createdOn;

  const InvoiceDetailsPage({
    super.key,
    required this.invoiceId,
    required this.customerName,
    required this.customerPhone,
    required this.payType,
    required this.productName,
    required this.price,
    required this.discount,
    required this.amount,
    required this.totalPrice,
    required this.createdByName,
    required this.createdOn,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'تفاصيل الفاتورة',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InvoiceDetailRow(title: 'رقم الفاتورة:', value: invoiceId),
            const SizedBox(height: 10),
            InvoiceDetailRow(title: 'اسم العميل:', value: customerName),
            const SizedBox(height: 10),
            InvoiceDetailRow(title: 'رقم هاتف العميل:', value: customerPhone),
            const SizedBox(height: 10),
            InvoiceDetailRow(title: 'طريقة الدفع:', value: payType),
            const SizedBox(height: 10),
            InvoiceDetailRow(title: 'اسم المنتج:', value: productName),
            const SizedBox(height: 10),
            InvoiceDetailRow(title: 'سعر الوحدة:', value: '$price ج.م'),
            const SizedBox(height: 10),
            InvoiceDetailRow(title: 'الخصم:', value: '$discount ج.م'),
            const SizedBox(height: 10),
            InvoiceDetailRow(title: 'الكمية:', value: amount.toString()),
            const SizedBox(height: 10),
            InvoiceDetailRow(
              title: 'الإجمالي:',
              value: '$totalPrice ج.م',
              valueColor: Colors.green,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            InvoiceDetailRow(title: 'تاريخ الفاتورة:', value: createdOn),
            const SizedBox(height: 10),
            InvoiceDetailRow(
                title: 'تم الإنشاء بواسطة:', value: createdByName.toString()),
            const Spacer(),
            // زر حذف الفاتورة
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _confirmDelete(context);
                },
                child: const Text(
                  'حذف الفاتورة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة تأكيد الحذف
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد أنك تريد حذف هذه الفاتورة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              // تنفيذ حذف الفاتورة هنا
              Navigator.pop(context);
            },
            child: const Text(
              'حذف',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

// ======== تصميم عنصر بيانات الفاتورة ========
class InvoiceDetailRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final FontWeight? fontWeight;

  const InvoiceDetailRow({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: valueColor ?? Colors.black,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
