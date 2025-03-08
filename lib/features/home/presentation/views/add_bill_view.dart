import 'package:elmohandes/core/di/di.dart';
import 'package:elmohandes/core/resources/font_manager.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/home/presentation/viewmodels/add_bills/add_bill_cubit.dart';
import 'package:elmohandes/features/home/presentation/views/bill_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBillPage extends StatefulWidget {
  final String fontFamily;

  const AddBillPage({
    super.key,
    this.fontFamily = FontFamily.cairo,
  });

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _customerName = TextEditingController();
  final TextEditingController _customerPhone = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  late AddBillCubit viewModel;
  String _selectedPaymentMethod = "كاش";
  final List<String> _paymentMethods = ["كاش", "فودافون كاش", "إنستاباي"];

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<AddBillCubit>();
    // _customerName = TextEditingController(text: widget.customerName);
    // _customerPhone = TextEditingController(text: widget.customerPhone);
    // _quantity = TextEditingController(text: widget.quantity);
  }

  @override
  void dispose() {
    _customerName.dispose();
    _customerPhone.dispose();
    _quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "إضافة فاتورة جديدة",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: FontFamily.cairoSemiBold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                        controller: _customerName, label: "اسم العميل"),
                    _buildTextField(
                      controller: _customerPhone,
                      label: "رقم العميل",
                      keyboardType: TextInputType.phone,
                    ),
                    _buildDropdownField(),
                    _buildTextField(
                        controller: _quantity,
                        label: "الكمية",
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 20),
                    BlocConsumer<AddBillCubit, AddBillState>(
                      listener: (context, state) {
                        if (state is AddBillSuccess) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("تمت الاضافة"),
                                    content: const Text("تمت الاضافة بنجاح"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BillDetailsView(
                                                  billData: state.addBillEntity,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text("حسنا"))
                                    ],
                                  ));
                        } else if (state is AddBillFailure) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("خطأ"),
                                    content:
                                        const Text("حدث خطأ أثناء الاضافة"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("حسنا"))
                                    ],
                                  ));
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.addBill(
                                  id: CacheService.getData(
                                      key: CacheConstants.productId),
                                  customerName: _customerName.text,
                                  customerPhone: _customerPhone.text,
                                  amount: num.parse(_quantity.text),
                                  payType: _selectedPaymentMethod,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "إضافة فاتورة",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: widget.fontFamily,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedPaymentMethod,
        items: _paymentMethods.map((String method) {
          return DropdownMenuItem<String>(
            value: method,
            child: Text(method, textDirection: TextDirection.rtl),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedPaymentMethod = newValue!;
          });
        },
        decoration: InputDecoration(
          labelText: "طريقة الدفع",
          border: OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        ),
      ),
    );
  }
}
