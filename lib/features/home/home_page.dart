import 'package:flutter/material.dart';

import '../../localization/app_text.dart';
import '../../theme/app_theme.dart';
import '../../widgets/fade_slide_in.dart';
import '../webview/webview_tab_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _locations = {
    'DAR': 'Dar es Salaam',
    'MOROGORO': 'Morogoro',
    'IFAKARA': 'Ifakara',
    'MALINYI': 'Malinyi',
  };

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

    final dateIso =
        '${_departureDate.year.toString().padLeft(4, '0')}-${_departureDate.month.toString().padLeft(2, '0')}-${_departureDate.day.toString().padLeft(2, '0')}';
    final uri = Uri.parse('https://www.louisline.co.tz/book').replace(
      queryParameters: {
        'dialog': '1',
        'from': _from,
        'to': _to,
        'date': dateIso,
        'passengers': '$_passengers',
      },
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            WebViewTabPage(title: context.t('bookTicket'), url: uri.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
            child: Column(
              children: [
                FadeSlideIn(
                  child: SizedBox(
                    height: 280,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset('assets/images/hero_4.jpeg', fit: BoxFit.cover),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0x52000000), Color(0xCC0E1328)],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _heroThumb(
                                      'assets/images/hero_1.jpeg',
                                      height: 118,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _heroThumb(
                                      'assets/images/hero_2.jpeg',
                                      height: 118,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: FadeSlideIn(
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
                ),
                const SizedBox(height: 0),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 170),
                  child: _sectionHeader(
                    context.t('whyLouisline'),
                    context.t('premiumLocal'),
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
                        context.t('safeTrusted'),
                        context.t('comfortableCoaches'),
                        context.t('fastBooking'),
                      ][index],
                      subtitle: [
                        context.t('safeTrustedSub'),
                        context.t('comfortableCoachesSub'),
                        context.t('fastBookingSub'),
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

  Widget _heroThumb(String assetPath, {required double height}) {
    return Material(
      elevation: 6,
      shadowColor: Colors.black54,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Image.asset(assetPath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _sectionHeader(String title, String subtitle) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 360;
        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(color: Color(0xFF64748B))),
            ],
          );
        }
        return Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                subtitle,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF64748B)),
              ),
            ),
          ],
        );
      },
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
  final Map<String, String> locations;
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
            Text(
              context.t('searchBookBus'),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              context.t('nativeHandoff'),
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isDense: true,
                    initialValue: from,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                    icon: const Icon(Icons.expand_more, size: 22),
                    decoration: _fieldDecoration(context.t('from')),
                    selectedItemBuilder: (context) => locations.entries
                        .map(
                          (entry) => Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              entry.value,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    items: locations
                        .entries
                        .map(
                          (entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(
                              entry.value,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: onFromChanged,
                    validator: (value) =>
                        value == null ? context.t('selectOrigin') : null,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isDense: true,
                    initialValue: to,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                    icon: const Icon(Icons.expand_more, size: 22),
                    decoration: _fieldDecoration(context.t('to')),
                    selectedItemBuilder: (context) => locations.entries
                        .map(
                          (entry) => Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              entry.value,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    items: locations
                        .entries
                        .map(
                          (entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(
                              entry.value,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: onToChanged,
                    validator: (value) {
                      if (value == null) {
                        return context.t('selectDestination');
                      }
                      if (from != null && value == from) {
                        return context.t('destinationDifferent');
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: onDateTap,
                    child: InputDecorator(
                      decoration: _fieldDecoration(context.t('departureDate')),
                      child: Row(
                        children: [
                          Text(
                            dateLabel,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 18,
                            color: AppTheme.brandBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: InputDecorator(
                    decoration: _fieldDecoration(context.t('passengers')),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: passengers > 1
                              ? () => onPassengersChanged(passengers - 1)
                              : null,
                          child: Icon(
                            Icons.remove_circle_outline,
                            size: 20,
                            color: passengers > 1
                                ? AppTheme.brandBlue
                                : const Color(0xFF94A3B8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$passengers',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: passengers < 8
                              ? () => onPassengersChanged(passengers + 1)
                              : null,
                          child: Icon(
                            Icons.add_circle_outline,
                            size: 20,
                            color: passengers < 8
                                ? AppTheme.brandBlue
                                : const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.brandAmber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onContinue,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(context.t('continueBooking')),
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
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.brandBlue, width: 1.4),
      ),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
