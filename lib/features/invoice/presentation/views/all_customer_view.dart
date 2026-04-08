import 'package:elmohandes/core/di/di.dart';
import 'package:elmohandes/features/invoice/domain/entities/all_customers_entity.dart';
import 'package:elmohandes/features/invoice/presentation/view_models/cubit/cubit/all_cutsomer_cubit.dart';
import 'package:elmohandes/features/invoice/presentation/views/client_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─── Entry Point ──────────────────────────────────────────────────────────────

class AllCustomerView extends StatelessWidget {
  const AllCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AllCutsomerCubit>()..getAllCoustomers(),
      child: const _AllCustomerScreen(),
    );
  }
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class _AllCustomerScreen extends StatefulWidget {
  const _AllCustomerScreen();

  @override
  State<_AllCustomerScreen> createState() => _AllCustomerScreenState();
}

class _AllCustomerScreenState extends State<_AllCustomerScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';

  // فلتر: all / debt / clear
  String _filter = 'all';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<AllCustomersEntity> _applyFilters(List<AllCustomersEntity> list) {
    var filtered = list;

    // فلتر الـ flag
    if (_filter == 'debt') {
      filtered = filtered.where((c) => c.flag == true).toList();
    } else if (_filter == 'clear') {
      filtered = filtered.where((c) => c.flag == false).toList();
    }

    // فلتر البحث بالاسم أو التليفون
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((c) {
        final name = (c.custName ?? '').toLowerCase();
        final phone = (c.custPhone ?? '');
        return name.contains(_searchQuery.toLowerCase()) ||
            phone.contains(_searchQuery);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F8),
        body: BlocBuilder<AllCutsomerCubit, AllCutsomerState>(
          builder: (context, state) {
            return switch (state) {
              AllCutsomerInitial() => const _FullPageLoader(),
              AllCutsomerLoaded() => const _FullPageLoader(),
              AllCutsomerError(message: final msg) => _FullPageError(
                  message: msg,
                  onRetry: () =>
                      context.read<AllCutsomerCubit>().getAllCoustomers(),
                ),
              AllCutsomerSuccess(allCustomers: final customers) =>
                _buildContent(customers),
            };
          },
        ),
      ),
    );
  }

  Widget _buildContent(List<AllCustomersEntity> customers) {
    final filtered = _applyFilters(customers);

    // ── إحصائيات سريعة ──
    final totalDebt = customers.where((c) => c.flag == true).length;
    final totalClear = customers.where((c) => c.flag == false).length;
    final totalMoney =
        customers.fold<num>(0, (s, c) => s + (c.totalAmount ?? 0));
    final totalPaid = customers.fold<num>(0, (s, c) => s + (c.totalPaid ?? 0));

    return CustomScrollView(
      slivers: [
        // ── App Bar ──
        _buildAppBar(customers.length),

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),

              // ── Stats Row ──
              _StatsRow(
                total: customers.length,
                debt: totalDebt,
                clear: totalClear,
                totalMoney: totalMoney,
                totalPaid: totalPaid,
              ),
              const SizedBox(height: 20),

              // ── Search Bar ──
              _buildSearchBar(),
              const SizedBox(height: 16),

              // ── Filter Chips ──
              _buildFilterChips(customers),
              const SizedBox(height: 20),

              // ── List Header ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A237E),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'العملاء (${filtered.length})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                  if (filtered.length != customers.length)
                    Text(
                      'من أصل ${customers.length}',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade400),
                    ),
                ],
              ),
              const SizedBox(height: 14),
            ]),
          ),
        ),

        // ── Empty Result ──
        if (filtered.isEmpty)
          SliverFillRemaining(
            child: _EmptyFilterResult(
              onClear: () => setState(() {
                _filter = 'all';
                _searchQuery = '';
                _searchCtrl.clear();
              }),
            ),
          )
        else
          // ── Customer List ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            sliver: SliverList.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _CustomerCard(customer: filtered[i]),
            ),
          ),
      ],
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────

  Widget _buildAppBar(int count) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF1A237E),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded, color: Colors.white),
          tooltip: 'تحديث',
          onPressed: () => context.read<AllCutsomerCubit>().getAllCoustomers(),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(right: 20, bottom: 14),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'كل العملاء',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$count عميل مسجل',
              style: TextStyle(
                color: Colors.white.withValues(alpha: .70),
                fontSize: 11,
              ),
            ),
          ],
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D1B6E), Color(0xFF1A237E), Color(0xFF283593)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Stack(
            children: [
              // دوائر ديكور
              Positioned(
                left: -40,
                top: -20,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: .04),
                  ),
                ),
              ),
              Positioned(
                right: 60,
                bottom: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: .05),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Search Bar ────────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchCtrl,
        onChanged: (v) => setState(() => _searchQuery = v),
        style: const TextStyle(fontSize: 15, color: Color(0xFF1A1A2E)),
        decoration: InputDecoration(
          hintText: 'ابحث بالاسم أو رقم التليفون...',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
          prefixIcon: const Icon(Icons.search_rounded,
              color: Color(0xFF1A237E), size: 22),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded, color: Colors.grey),
                  onPressed: () => setState(() {
                    _searchQuery = '';
                    _searchCtrl.clear();
                  }),
                )
              : null,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  // ── Filter Chips ──────────────────────────────────────────────────────────

  Widget _buildFilterChips(List<AllCustomersEntity> customers) {
    final debtCount = customers.where((c) => c.flag == true).length;
    final clearCount = customers.where((c) => c.flag == false).length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'الكل',
            count: customers.length,
            selected: _filter == 'all',
            color: const Color(0xFF1A237E),
            onTap: () => setState(() => _filter = 'all'),
          ),
          const SizedBox(width: 10),
          _FilterChip(
            label: 'عليه فلوس',
            count: debtCount,
            selected: _filter == 'debt',
            color: const Color(0xFFC62828),
            onTap: () => setState(() => _filter = 'debt'),
          ),
          const SizedBox(width: 10),
          _FilterChip(
            label: 'مسدد',
            count: clearCount,
            selected: _filter == 'clear',
            color: const Color(0xFF2E7D32),
            onTap: () => setState(() => _filter = 'clear'),
          ),
        ],
      ),
    );
  }
}

// ─── Stats Row ────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final int total, debt, clear;
  final num totalMoney, totalPaid;

  const _StatsRow({
    required this.total,
    required this.debt,
    required this.clear,
    required this.totalMoney,
    required this.totalPaid,
  });

  String _fmt(num v) => v
      .toStringAsFixed(0)
      .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _MiniStatCard(
            label: 'إجمالي العملاء',
            value: '$total',
            icon: Icons.people_outline_rounded,
            color: const Color(0xFF1A237E),
            bg: const Color(0xFFE8EAF6),
          ),
          const SizedBox(width: 12),
          _MiniStatCard(
            label: 'عليهم فلوس',
            value: '$debt',
            icon: Icons.warning_amber_rounded,
            color: const Color(0xFFC62828),
            bg: const Color(0xFFFFEBEE),
          ),
          const SizedBox(width: 12),
          _MiniStatCard(
            label: 'مسددين',
            value: '$clear',
            icon: Icons.check_circle_outline_rounded,
            color: const Color(0xFF2E7D32),
            bg: const Color(0xFFE8F5E9),
          ),
          const SizedBox(width: 12),
          _MiniStatCard(
            label: 'إجمالي المبالغ',
            value: '${_fmt(totalMoney)} ج',
            icon: Icons.account_balance_wallet_outlined,
            color: const Color(0xFF00695C),
            bg: const Color(0xFFE0F2F1),
          ),
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color, bg;

  const _MiniStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    )),
                const SizedBox(height: 2),
                Text(label,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Filter Chip ──────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? color : Colors.grey.shade200,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: .25),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withValues(alpha: .25)
                    : color.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Customer Card ────────────────────────────────────────────────────────────

// ─── Customer Card ────────────────────────────────────────────────────────────

class _CustomerCard extends StatelessWidget {
  final AllCustomersEntity customer;

  const _CustomerCard({required this.customer});

  String _fmt(num? v) => (v ?? 0)
      .toStringAsFixed(0)
      .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},');

  @override
  Widget build(BuildContext context) {
    final hasDebt = customer.flag == true;
    final remaining = (customer.totalAmount ?? 0) - (customer.totalPaid ?? 0);
    final progress = (customer.totalAmount ?? 0) > 0
        ? ((customer.totalPaid ?? 0) / (customer.totalAmount ?? 1))
            .clamp(0.0, 1.0)
            .toDouble()
        : 0.0;

    final statusColor =
        hasDebt ? const Color(0xFFC62828) : const Color(0xFF2E7D32);
    final statusBg =
        hasDebt ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9);
    final statusLabel = hasDebt ? 'عليه فلوس' : 'مسدد';
    final statusIcon =
        hasDebt ? Icons.warning_amber_rounded : Icons.check_circle_rounded;

    // 👈 ضفنا الـ GestureDetector هنا عشان الدوسة
    return GestureDetector(
        onTap: () {
          // لو العميل عنده رقم تليفون، افتح صفحة البحث بالرقم ده
          if (customer.custPhone != null && customer.custPhone!.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClientSearchScreen(
                  initialPhone: customer.custPhone, // 👈 باصينا الرقم هنا
                ),
              ),
            );
          } else {
            // ممكن تطلعله سناك بار هنا لو حابب تقوله إن العميل ده ملوش رقم متسجل
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('عفواً، لا يوجد رقم هاتف مسجل لهذا العميل')),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: hasDebt
                  ? const Color(0xFFC62828).withValues(alpha: .12)
                  : Colors.transparent,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
// ... باقي كود الـ Column والشكل بتاع الكارت زي ما هو
          child: Column(
            children: [
              // ── الصف العلوي: أفاتار + اسم + status ──
              Row(
                children: [
                  // أفاتار
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: hasDebt
                            ? [const Color(0xFFEF9A9A), const Color(0xFFC62828)]
                            : [
                                const Color(0xFF66BB6A),
                                const Color(0xFF2E7D32)
                              ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        (customer.custName?.isNotEmpty ?? false)
                            ? customer.custName![0]
                            : 'ع',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // الاسم والتليفون
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.custName ?? 'اسم غير معروف',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(Icons.phone_outlined,
                                size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              customer.custPhone ?? '—',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Status Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, size: 13, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          statusLabel,
                          style: TextStyle(
                            fontSize: 11,
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ── نبوّي بس لو عليه فلوس ──
              if (hasDebt) ...[
                const SizedBox(height: 14),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                const SizedBox(height: 12),

                // المبالغ
                Row(
                  children: [
                    _amountItem('الإجمالي', _fmt(customer.totalAmount),
                        const Color(0xFF1A1A2E)),
                    _vDivider(),
                    _amountItem('المدفوع', _fmt(customer.totalPaid),
                        const Color(0xFF2E7D32)),
                    _vDivider(),
                    _amountItem('الباقي', '${_fmt(remaining)} ج',
                        const Color(0xFFC62828)),
                  ],
                ),
                const SizedBox(height: 12),

                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFEEEEEE),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress == 1
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFFC62828),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${(progress * 100).toStringAsFixed(0)}٪ مسدد',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ));
  }

  Widget _amountItem(String label, String value, Color color) => Expanded(
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      );

  Widget _vDivider() =>
      Container(width: 1, height: 28, color: const Color(0xFFF0F0F0));
}

// ─── Full Page States ─────────────────────────────────────────────────────────

class _FullPageLoader extends StatelessWidget {
  const _FullPageLoader();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF0F2F8),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF1A237E)),
            SizedBox(height: 16),
            Text('جاري تحميل العملاء...',
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

class _FullPageError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _FullPageError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F8),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded,
                size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text('مش قادر يتصل بالسيرفر',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(height: 8),
            Text(message,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade400)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('حاول تاني'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A237E),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Empty Filter Result ──────────────────────────────────────────────────────

class _EmptyFilterResult extends StatelessWidget {
  final VoidCallback onClear;

  const _EmptyFilterResult({required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.filter_list_off_rounded,
              size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 14),
          Text('مفيش نتائج للفلتر ده',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: onClear,
            icon: const Icon(Icons.clear_all_rounded),
            label: const Text('امسح الفلتر'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF1A237E),
            ),
          ),
        ],
      ),
    );
  }
}
