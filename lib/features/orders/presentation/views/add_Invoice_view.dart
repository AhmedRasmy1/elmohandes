import '../../../../core/di/di.dart';
import '../../../../core/utils/cashed_data_shared_preferences.dart';
import '../view_models/add_invoice_viewmodel/add_invoice_cubit.dart';
import 'print_invoice_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/font_manager.dart';
import 'package:flutter/material.dart';

class AddInvoiceView extends StatefulWidget {
  final String fontFamily;

  const AddInvoiceView({
    super.key,
    this.fontFamily = FontFamily.cairo,
  });

  @override
  State<AddInvoiceView> createState() => _AddInvoiceViewState();
}

class _AddInvoiceViewState extends State<AddInvoiceView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _customerName = TextEditingController();
  final TextEditingController _customerPhone = TextEditingController();
  String _selectedPaymentMethod = "كاش";
  final List<String> _paymentMethods = ["كاش", "فودافون كاش", "إنستاباي"];
  late AddInvoiceCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<AddInvoiceCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _customerName.dispose();
    _customerPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "إضافة فاتورة جديدة",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    controller: _customerName,
                    label: "اسم العميل",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال اسم العميل';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: _customerPhone,
                    label: "رقم العميل",
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال رقم العميل';
                      } else if (value.length < 11) {
                        return 'رقم الهاتف يجب أن يكون 11 رقمًا على الأقل';
                      }
                      return null;
                    },
                  ),
                  _buildDropdownField(),
                  const SizedBox(height: 25),
                  BlocConsumer<AddInvoiceCubit, AddInvoiceState>(
                    listener: (context, state) {
                      if (state is AddInvoiceSuccess) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return InvoicePage(
                            invoiceData: state.data,
                          );
                        }));
                      }
                    },
                    builder: (context, state) {
                      if (state is AddInvoiceLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is AddInvoiceSuccess) {}
                      if (state is AddInvoiceFailure) {
                        return Center(
                          child: Text(
                            "حدث خطأ ما",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              color: Colors.red,
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              viewModel.addInvoice(
                                token:
                                    'Bearer ${CacheService.getData(key: CacheConstants.userToken)}',
                                customerName:
                                    _customerName.text, // customerName
                                customerPhone: _customerPhone.text,
                                payType: _selectedPaymentMethod, // payType
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "إضافة فاتورة",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          labelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
              const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          labelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
