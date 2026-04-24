import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/fade_slide_in.dart';
import '../webview/webview_tab_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _locations = ['Dar es Salaam', 'Morogoro', 'Ifakara', 'Malinyi'];

  final _formKey = GlobalKey<FormState>();
  String? _from;
  String? _to;
  DateTime _departureDate = DateTime.now().add(const Duration(days: 1));
  int _passengers = 1;

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _departureDate = picked);
    }
  }

  void _continueToBooking() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    final date =
        '${_departureDate.year.toString().padLeft(4, '0')}-${_departureDate.month.toString().padLeft(2, '0')}-${_departureDate.day.toString().padLeft(2, '0')}';

    final uri = Uri.parse('https://www.louisline.co.tz/book').replace(
      queryParameters: {
        'from': _from,
        'to': _to,
        'date': date,
        'passengers': '$_passengers',
      },
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            WebViewTabPage(title: 'Book Ticket', url: uri.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          pinned: true,
          expandedHeight: 250,
          backgroundColor: AppTheme.darkBg,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Louisline'),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/hero_4.jpeg', fit: BoxFit.cover),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x55000000), Color(0xD90E1328)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
            child: Column(
              children: [
                const FadeSlideIn(child: _HeroIntro()),
                const SizedBox(height: 14),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 90),
                  child: _BookingNativeCard(
                    formKey: _formKey,
                    locations: _locations,
                    from: _from,
                    to: _to,
                    passengers: _passengers,
                    departureDate: _departureDate,
                    onFromChanged: (value) => setState(() => _from = value),
                    onToChanged: (value) => setState(() => _to = value),
                    onDateTap: () => _pickDate(context),
                    onPassengersChanged: (value) =>
                        setState(() => _passengers = value),
                    onContinue: _continueToBooking,
                  ),
                ),
                const SizedBox(height: 16),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 170),
                  child: _sectionHeader(
                    'Why Louisline',
                    'Premium local experience',
                  ),
                ),
                const SizedBox(height: 10),
                ...List.generate(
                  3,
                  (index) => FadeSlideIn(
                    delay: Duration(milliseconds: 220 + index * 70),
                    child: _BenefitCard(
                      icon: [
                        Icons.verified_user_outlined,
                        Icons.airline_seat_recline_extra,
                        Icons.speed_outlined,
                      ][index],
                      title: [
                        'Safe & Trusted',
                        'Comfortable Coaches',
                        'Fast Booking',
                      ][index],
                      subtitle: [
                        'Experienced drivers and reliable route planning.',
                        'Clean interiors and relaxing seat space.',
                        'Book in seconds and continue in secure flow.',
                      ][index],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title, String subtitle) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        Text(subtitle, style: const TextStyle(color: Color(0xFF64748B))),
      ],
    );
  }
}

class _HeroIntro extends StatelessWidget {
  const _HeroIntro();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x1429388D), Color(0x14D91D27)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0x3329388D)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Native booking experience',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 6),
          Text(
            'Choose route and date here, then continue to secure ticket booking.',
            style: TextStyle(color: Color(0xFF475569), height: 1.35),
          ),
        ],
      ),
    );
  }
}

class _BookingNativeCard extends StatelessWidget {
  const _BookingNativeCard({
    required this.formKey,
    required this.locations,
    required this.from,
    required this.to,
    required this.passengers,
    required this.departureDate,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onDateTap,
    required this.onPassengersChanged,
    required this.onContinue,
  });

  final GlobalKey<FormState> formKey;
  final List<String> locations;
  final String? from;
  final String? to;
  final int passengers;
  final DateTime departureDate;
  final ValueChanged<String?> onFromChanged;
  final ValueChanged<String?> onToChanged;
  final VoidCallback onDateTap;
  final ValueChanged<int> onPassengersChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final dateLabel =
        '${departureDate.day.toString().padLeft(2, '0')}/${departureDate.month.toString().padLeft(2, '0')}/${departureDate.year}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A0F172A),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search and book your bus',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'Styled natively for speed, then handoff to secure booking.',
              style: TextStyle(color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: from,
              decoration: _fieldDecoration('From'),
              items: locations
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: onFromChanged,
              validator: (value) => value == null ? 'Select origin' : null,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: to,
              decoration: _fieldDecoration('To'),
              items: locations
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: onToChanged,
              validator: (value) {
                if (value == null) {
                  return 'Select destination';
                }
                if (from != null && value == from) {
                  return 'Destination must be different';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: onDateTap,
              child: InputDecorator(
                decoration: _fieldDecoration('Departure date'),
                child: Row(
                  children: [
                    Text(
                      dateLabel,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: AppTheme.brandBlue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            InputDecorator(
              decoration: _fieldDecoration('Passengers'),
              child: Row(
                children: [
                  IconButton(
                    onPressed: passengers > 1
                        ? () => onPassengersChanged(passengers - 1)
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text(
                    '$passengers',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: passengers < 8
                        ? () => onPassengersChanged(passengers + 1)
                        : null,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                  const Spacer(),
                  const Text(
                    'Seat count',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.brandAmber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: onContinue,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('Continue to Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.brandBlue, width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  const _BenefitCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0x1A29388D),
            child: Icon(icon, color: AppTheme.brandBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
