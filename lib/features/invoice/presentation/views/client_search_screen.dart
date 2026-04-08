import 'package:elmohandes/core/di/di.dart';
import 'package:elmohandes/features/invoice/data/models/all_inovices/customer.dart';
import 'package:elmohandes/features/invoice/data/models/all_inovices/invoice_item.dart';

import 'package:elmohandes/features/invoice/domain/entities/all_invoices_entity.dart';
import 'package:elmohandes/features/invoice/domain/entities/customer_entity.dart';
import 'package:elmohandes/features/invoice/presentation/view_models/cubit/customer_search_cubit.dart';
import 'package:elmohandes/features/invoice/presentation/views/display_all_invoices_details.dart';
import 'package:elmohandes/features/invoice/data/models/all_inovices/product.dart'
    as myProduct;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─── Screen ───────────────────────────────────────────────────────────────────

class ClientSearchScreen extends StatelessWidget {
  const ClientSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<CustomerSearchCubit>(),
      child: const _ClientSearchView(),
    );
  }
}

class _ClientSearchView extends StatefulWidget {
  const _ClientSearchView();

  @override
  State<_ClientSearchView> createState() => _ClientSearchViewState();
}

class _ClientSearchViewState extends State<_ClientSearchView> {
  final TextEditingController _ctrl = TextEditingController();

  void _search(BuildContext context) {
    final phone = _ctrl.text.trim();
    if (phone.isEmpty) return;
    // نستدعي الكيوبيت مباشرة — الـ token بياخده من الـ CacheService جوا الكيوبيت
    context.read<CustomerSearchCubit>().searchCustomer(
          token: '', // مش محتاجه هنا، الكيوبيت بيجيبه من الـ Cache
          phone: phone,
        );
  }

  void _clear(BuildContext context) {
    _ctrl.clear();
    context.read<CustomerSearchCubit>().reset();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FB),
        body: CustomScrollView(
          slivers: [
            const _AppBar(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // ── Search Bar ──
                  _SearchBar(
                    controller: _ctrl,
                    onSearch: () => _search(context),
                    onClear: () => _clear(context),
                  ),
                  const SizedBox(height: 28),

                  // ── BlocBuilder يتحكم في كل الـ States ──
                  BlocBuilder<CustomerSearchCubit, CustomerSearchState>(
                    builder: (context, state) {
                      return switch (state) {
                        // ① لسه مابحثش
                        CustomerSearchInitial() => const _HintState(),

                        // ② جاري التحميل
                        CustomerSearchLoading() => const _LoadingState(),

                        // ③ النتائج جت بنجاح
                        CustomerSearchSuccess(customers: final customers) =>
                          customers.isEmpty
                              ? const _NotFoundState()
                              : _ClientResult(
                                  customer: customers.first,
                                ),

                        // ④ في خطأ
                        CustomerSearchError(message: final msg) =>
                          _ErrorState(message: msg),
                      };
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 110,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF1A237E),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(right: 20, bottom: 14),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'بحث العملاء',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'ابحث برقم التليفون لعرض فواتير العميل',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: .70), fontSize: 11),
            ),
          ],
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF283593), Color(0xFF1A237E)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Search Bar ───────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  const _SearchBar({
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A237E).withValues(alpha: .10),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.phone,
              onSubmitted: (_) => onSearch(),
              style: const TextStyle(fontSize: 16, color: Color(0xFF1A1A2E)),
              decoration: InputDecoration(
                hintText: 'أدخل رقم التليفون...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                prefixIcon:
                    const Icon(Icons.phone_outlined, color: Colors.grey),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon:
                            const Icon(Icons.clear_rounded, color: Colors.grey),
                        onPressed: onClear,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 4),
            child: BlocBuilder<CustomerSearchCubit, CustomerSearchState>(
              builder: (context, state) {
                final isLoading = state is CustomerSearchLoading;
                return ElevatedButton.icon(
                  onPressed: isLoading ? null : onSearch,
                  icon: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.search_rounded, size: 18),
                  label: Text(isLoading ? 'جاري...' : 'بحث'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFF1A237E).withValues(alpha: .5),
                    disabledForegroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── States UI ────────────────────────────────────────────────────────────────

class _HintState extends StatelessWidget {
  const _HintState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.manage_search_rounded,
                size: 72, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'ابحث عن عميل برقم تليفونه',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 6),
            Text('هتظهرلك كل فواتيره هنا',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade300)),
          ],
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF1A237E)),
            SizedBox(height: 16),
            Text('جاري البحث...',
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF1A237E),
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _NotFoundState extends StatelessWidget {
  const _NotFoundState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_search_outlined,
                size: 72, color: Colors.red.shade200),
            const SizedBox(height: 16),
            const Text(
              'مفيش عميل بالرقم ده',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E)),
            ),
            const SizedBox(height: 6),
            Text('تأكد من الرقم وحاول تاني',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 72, color: Colors.orange.shade300),
            const SizedBox(height: 16),
            const Text(
              'حصل مشكلة في الاتصال',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E)),
            ),
            const SizedBox(height: 6),
            Text(message,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }
}

// ─── Client Result ────────────────────────────────────────────────────────────

class _ClientResult extends StatelessWidget {
  final CustomerEntity customer;

  const _ClientResult({required this.customer});

  @override
  Widget build(BuildContext context) {
    final invoices = customer.invoices ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ClientBanner(customer: customer),
        const SizedBox(height: 24),
        _sectionTitle('الفواتير (${invoices.length})'),
        const SizedBox(height: 14),
        _InvoiceList(invoices: invoices),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _sectionTitle(String title) => Row(
        children: [
          Container(
            width: 4,
            height: 22,
            decoration: BoxDecoration(
                color: const Color(0xFF1A237E),
                borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 10),
          Text(title,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E))),
        ],
      );
}

// ─── Client Banner ────────────────────────────────────────────────────────────

class _ClientBanner extends StatelessWidget {
  final CustomerEntity customer;

  const _ClientBanner({required this.customer});

  String _fmt(double v) =>
      '${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},')} ج';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF283593)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF1A237E).withValues(alpha: .25),
              blurRadius: 20,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── اسم العميل + رقمه ──
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white.withValues(alpha: .15),
                child: Text(
                  customer.name.isNotEmpty ? customer.name[0] : 'ع',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.phone_outlined,
                          size: 13, color: Colors.white70),
                      const SizedBox(width: 4),
                      Text(customer.phone,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 12),

          // ── ملخص المبالغ ──
          Row(
            children: [
              _stat('الإجمالي', _fmt(customer.totalAmount), Colors.white),
              _divider(),
              _stat(
                  'المدفوع', _fmt(customer.totalPaid), const Color(0xFF80CBC4)),
              _divider(),
              _stat('الباقي', _fmt(customer.totalRemaining),
                  const Color(0xFFFFCC80)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value, Color color) => Expanded(
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(color: Colors.white54, fontSize: 11)),
          ],
        ),
      );

  Widget _divider() => Container(
      width: 1, height: 32, color: Colors.white.withValues(alpha: .15));
}

// ─── Invoice List ─────────────────────────────────────────────────────────────

class _InvoiceList extends StatelessWidget {
  final List<Invoices> invoices;

  const _InvoiceList({required this.invoices});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: invoices
          .map((inv) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _InvoiceCard(invoice: inv),
              ))
          .toList(),
    );
  }
}

// ─── Invoice Card ─────────────────────────────────────────────────────────────

// ─── Invoice Card ─────────────────────────────────────────────────────────────

class _InvoiceCard extends StatelessWidget {
  final Invoices invoice;

  const _InvoiceCard({required this.invoice});

  String _fmt(double v) =>
      '${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},')} ج';

  String _date(String? d) => d ?? 'غير محدد';

  double get _total => (invoice.totalAmount ?? 0).toDouble();
  double get _paid => (invoice.paidAmount ?? 0).toDouble();
  double get _remaining => (invoice.remainingAmount ?? 0).toDouble();

  Color get _statusColor {
    if (_remaining == 0) return const Color(0xFF2E7D32);
    if (_paid == 0) return const Color(0xFFC62828);
    return const Color(0xFFE65100);
  }

  Color get _statusBg {
    if (_remaining == 0) return const Color(0xFFE8F5E9);
    if (_paid == 0) return const Color(0xFFFFEBEE);
    return const Color(0xFFFBE9E7);
  }

  String get _statusLabel {
    if (_remaining == 0) return 'مسدد بالكامل';
    if (_paid == 0) return 'لم يُسدد';
    return 'مسدد جزئياً';
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_total > 0 ? _paid / _total : 0.0).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 14,
              offset: const Offset(0, 4)),
        ],
      ),
      // ضفنا Material و InkWell هنا عشان الأنيميشن بتاع الدوسة يبقى شغال وشيك
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            // 🚀 النقلة لصفحة التفاصيل
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InvoicePageDetails(
                  invoiceData: AllInvoiceEntity(
                    customerName: invoice.customerName ?? '',
                    customerPhone: invoice.customerPhone ?? '',
                    payType: invoice.payType ?? '',
                    casherName: invoice.caisherName ?? '',
                    createdAt: invoice.createdAt ?? '',
                    invoiceNumber: invoice.invoiceNumber ?? '',
                    remainingAmount: _remaining,
                    invoiceItems: invoice.invoiceItems
                            ?.map((item) => InvoiceItem(
                                  id: item.id ?? 0,
                                  invoiceId: item.invoiceId ?? 0,
                                  productId: item.productId ?? 0,
                                  quantity: item.quantity ?? 0,
                                  totalPrice: item.totalPrice ?? 0,
                                  product: item.product != null
                                      ? myProduct.Product(
                                          id: item.product!.id ?? 0,
                                          name: item.product!.name ?? '',
                                          price: item.product!.price ?? 0,
                                          countryOfOrigin:
                                              item.product!.countryOfOrigin ??
                                                  '',
                                          quantity: item.product!.quantity ?? 0,
                                          discount: item.product!.discount ?? 0,
                                        )
                                      : null,
                                ))
                            .toList() ??
                        [],
                    invoiceTotalPrice: _total,
                    paidAmount: _paid,
                    // لو في بيانات تانية بيطلبها الـ Entity ضيفها هنا من الـ invoice
                  ),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header: رقم الفاتورة + status ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: const Color(0xFFE8EAF6),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.receipt_long_outlined,
                              size: 18, color: Color(0xFF1A237E)),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          invoice.invoiceNumber ?? 'رقم غير معروف',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF1A237E)),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: _statusBg,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        _statusLabel,
                        style: TextStyle(
                            fontSize: 11,
                            color: _statusColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                const SizedBox(height: 14),

                // ── التاريخ ──
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 13, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(_date(invoice.createdAt),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 14),

                // ── المبالغ ──
                _row('الإجمالي', _fmt(_total), const Color(0xFF1A1A2E)),
                const SizedBox(height: 8),
                _row('المدفوع', _fmt(_paid), const Color(0xFF2E7D32)),
                const SizedBox(height: 8),
                _row(
                  'الباقي',
                  _fmt(_remaining),
                  _remaining > 0 ? const Color(0xFFC62828) : Colors.grey,
                ),

                const SizedBox(height: 16),

                // ── Progress Bar ──
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: const Color(0xFFEEEEEE),
                    valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}٪ مسدد',
                  style: TextStyle(
                      fontSize: 11,
                      color: _statusColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value, Color color) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: color)),
        ],
      );
}
