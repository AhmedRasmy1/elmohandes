import 'package:flutter/material.dart';

class Invoice {
  final String invoiceNumber;
  final DateTime date;
  final double total;
  final double paid;

  const Invoice({
    required this.invoiceNumber,
    required this.date,
    required this.total,
    required this.paid,
  });

  double get remaining => total - paid;
}

class Client {
  final String name;
  final String phone;
  final List<Invoice> invoices;

  const Client({
    required this.name,
    required this.phone,
    required this.invoices,
  });
}

// ─── Fake Database (جايب من الـ API الحقيقي بدل كده) ─────────────────────────

final List<Client> _fakeDatabase = [
  Client(
    name: 'أحمد محمد علي',
    phone: '01012345678',
    invoices: [
      Invoice(
          invoiceNumber: 'INV-0001',
          date: DateTime(2024, 11, 5),
          total: 5200,
          paid: 3000),
      Invoice(
          invoiceNumber: 'INV-0002',
          date: DateTime(2025, 1, 18),
          total: 8400,
          paid: 8400),
      Invoice(
          invoiceNumber: 'INV-0009',
          date: DateTime(2025, 3, 2),
          total: 1500,
          paid: 0),
    ],
  ),
  Client(
    name: 'سارة إبراهيم',
    phone: '01098765432',
    invoices: [
      Invoice(
          invoiceNumber: 'INV-0003',
          date: DateTime(2025, 2, 10),
          total: 12000,
          paid: 7000),
    ],
  ),
  Client(
    name: 'محمود حسن',
    phone: '01155556677',
    invoices: [
      Invoice(
          invoiceNumber: 'INV-0004',
          date: DateTime(2024, 12, 1),
          total: 3800,
          paid: 3800),
      Invoice(
          invoiceNumber: 'INV-0007',
          date: DateTime(2025, 3, 20),
          total: 2200,
          paid: 1000),
    ],
  ),
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class ClientSearchScreen extends StatefulWidget {
  const ClientSearchScreen({super.key});

  @override
  State<ClientSearchScreen> createState() => _ClientSearchScreenState();
}

class _ClientSearchScreenState extends State<ClientSearchScreen> {
  final TextEditingController _ctrl = TextEditingController();
  Client? _client;
  bool _searched = false;

  void _search() {
    final phone = _ctrl.text.trim();
    if (phone.isEmpty) return;
    final result = _fakeDatabase.where((c) => c.phone == phone).firstOrNull;
    setState(() {
      _client = result;
      _searched = true;
    });
  }

  void _clear() {
    _ctrl.clear();
    setState(() {
      _client = null;
      _searched = false;
    });
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
        body: LayoutBuilder(builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 800;
          return CustomScrollView(
            slivers: [
              _AppBar(isDesktop: isDesktop),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 80 : 20,
                  vertical: 24,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _SearchBar(
                      controller: _ctrl,
                      onSearch: _search,
                      onClear: _clear,
                    ),
                    const SizedBox(height: 28),
                    if (!_searched) const _HintState(),
                    if (_searched && _client == null) const _NotFoundState(),
                    if (_searched && _client != null)
                      _ClientResult(
                        client: _client!,
                        isDesktop: isDesktop,
                      ),
                  ]),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  final bool isDesktop;
  const _AppBar({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: isDesktop ? 130 : 110,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF1A237E),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(
          right: isDesktop ? 80 : 20,
          bottom: 14,
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('بحث العملاء',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text('ابحث برقم التليفون لعرض فواتير العميل',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: .70), fontSize: 11)),
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
            child: ElevatedButton.icon(
              onPressed: onSearch,
              icon: const Icon(Icons.search_rounded, size: 18),
              label: const Text('بحث'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A237E),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Empty States ─────────────────────────────────────────────────────────────

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
            Text('ابحث عن عميل برقم تليفونه',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Text('هتظهرلك كل فواتيره هنا',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade300)),
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
            const Text('مفيش عميل بالرقم ده',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(height: 6),
            Text('تأكد من الرقم وحاول تاني',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }
}

// ─── Client Result ────────────────────────────────────────────────────────────

class _ClientResult extends StatelessWidget {
  final Client client;
  final bool isDesktop;

  const _ClientResult({required this.client, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final total = client.invoices.fold(0.0, (s, i) => s + i.total);
    final paid = client.invoices.fold(0.0, (s, i) => s + i.paid);
    final remaining = total - paid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ClientBanner(
            client: client, total: total, paid: paid, remaining: remaining),
        const SizedBox(height: 24),
        _sectionTitle('الفواتير (${client.invoices.length})'),
        const SizedBox(height: 14),
        isDesktop
            ? _DesktopGrid(invoices: client.invoices)
            : _MobileList(invoices: client.invoices),
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
  final Client client;
  final double total, paid, remaining;

  const _ClientBanner(
      {required this.client,
      required this.total,
      required this.paid,
      required this.remaining});

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
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white.withValues(alpha: .15),
                child: Text(client.name[0],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(client.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.phone_outlined,
                          size: 13, color: Colors.white70),
                      const SizedBox(width: 4),
                      Text(client.phone,
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
          Row(
            children: [
              _stat('الإجمالي', _fmt(total), Colors.white),
              _divider(),
              _stat('المدفوع', _fmt(paid), const Color(0xFF80CBC4)),
              _divider(),
              _stat('الباقي', _fmt(remaining), const Color(0xFFFFCC80)),
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

// ─── Desktop Grid ─────────────────────────────────────────────────────────────

class _DesktopGrid extends StatelessWidget {
  final List<Invoice> invoices;
  const _DesktopGrid({required this.invoices});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const cols = 3;
      const spacing = 16.0;
      final w = (constraints.maxWidth - spacing * (cols - 1)) / cols;
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: invoices
            .map((inv) => SizedBox(width: w, child: _InvoiceCard(inv)))
            .toList(),
      );
    });
  }
}

// ─── Mobile List ──────────────────────────────────────────────────────────────

class _MobileList extends StatelessWidget {
  final List<Invoice> invoices;
  const _MobileList({required this.invoices});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: invoices
          .map((inv) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _InvoiceCard(inv),
              ))
          .toList(),
    );
  }
}

// ─── Invoice Card ─────────────────────────────────────────────────────────────

class _InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  const _InvoiceCard(this.invoice);

  String _fmt(double v) =>
      '${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},')} ج';

  String _date(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  Color get _statusColor {
    if (invoice.remaining == 0) return const Color(0xFF2E7D32);
    if (invoice.paid == 0) return const Color(0xFFC62828);
    return const Color(0xFFE65100);
  }

  Color get _statusBg {
    if (invoice.remaining == 0) return const Color(0xFFE8F5E9);
    if (invoice.paid == 0) return const Color(0xFFFFEBEE);
    return const Color(0xFFFBE9E7);
  }

  String get _statusLabel {
    if (invoice.remaining == 0) return 'مسدد بالكامل';
    if (invoice.paid == 0) return 'لم يُسدد';
    return 'مسدد جزئياً';
  }

  @override
  Widget build(BuildContext context) {
    final progress = (invoice.total > 0 ? invoice.paid / invoice.total : 0.0)
        .clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
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
                  Text(invoice.invoiceNumber,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1A237E))),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: _statusBg, borderRadius: BorderRadius.circular(8)),
                child: Text(_statusLabel,
                    style: TextStyle(
                        fontSize: 11,
                        color: _statusColor,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          const SizedBox(height: 14),

          // ── Date ──
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined,
                  size: 13, color: Colors.grey),
              const SizedBox(width: 6),
              Text(_date(invoice.date),
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 14),

          // ── Amounts ──
          _row('الإجمالي', _fmt(invoice.total), const Color(0xFF1A1A2E)),
          const SizedBox(height: 8),
          _row('المدفوع', _fmt(invoice.paid), const Color(0xFF2E7D32)),
          const SizedBox(height: 8),
          _row(
            'الباقي',
            _fmt(invoice.remaining),
            invoice.remaining > 0 ? const Color(0xFFC62828) : Colors.grey,
          ),

          const SizedBox(height: 16),

          // ── Progress ──
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
                fontSize: 11, color: _statusColor, fontWeight: FontWeight.w600),
          ),
        ],
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
