import 'package:elmohandes/core/di/di.dart';
import 'package:elmohandes/features/home/presentation/viewmodels/delete_one_bill/delete_one_bill_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoiceDetailsPage extends StatefulWidget {
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
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  late DeleteOneBillCubit viewModel;
  @override
  void initState() {
    viewModel = getIt.get<DeleteOneBillCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
              InvoiceDetailRow(title: 'رقم الفاتورة:', value: widget.invoiceId),
              const SizedBox(height: 10),
              InvoiceDetailRow(
                  title: 'اسم العميل:', value: widget.customerName),
              const SizedBox(height: 10),
              InvoiceDetailRow(
                  title: 'رقم هاتف العميل:', value: widget.customerPhone),
              const SizedBox(height: 10),
              InvoiceDetailRow(title: 'طريقة الدفع:', value: widget.payType),
              const SizedBox(height: 10),
              InvoiceDetailRow(title: 'اسم المنتج:', value: widget.productName),
              const SizedBox(height: 10),
              InvoiceDetailRow(
                  title: 'سعر الوحدة:', value: '${widget.price} ج.م'),
              const SizedBox(height: 10),
              InvoiceDetailRow(
                  title: 'الخصم:', value: '${widget.discount} ج.م'),
              const SizedBox(height: 10),
              InvoiceDetailRow(
                  title: 'الكمية:', value: widget.amount.toString()),
              const SizedBox(height: 10),
              InvoiceDetailRow(
                title: 'الإجمالي:',
                value: '${widget.totalPrice} ج.م',
                valueColor: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              InvoiceDetailRow(
                  title: 'تاريخ الفاتورة:', value: widget.createdOn),
              const SizedBox(height: 10),
              InvoiceDetailRow(
                  title: 'تم الإنشاء بواسطة:',
                  value: widget.createdByName.toString()),
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
              viewModel.deleteOneBill(widget.invoiceId);
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
