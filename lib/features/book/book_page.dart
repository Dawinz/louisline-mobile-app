import 'package:flutter/material.dart';

import '../../localization/app_text.dart';
import '../../theme/app_theme.dart';

class NativeBookPage extends StatefulWidget {
  const NativeBookPage({
    super.key,
    this.initialFrom,
    this.initialTo,
    this.initialDate,
    this.initialPassengers,
  });

  final String? initialFrom;
  final String? initialTo;
  final DateTime? initialDate;
  final int? initialPassengers;

  @override
  State<NativeBookPage> createState() => _NativeBookPageState();
}

class _NativeBookPageState extends State<NativeBookPage> {
  static const _locations = {
    'DAR': 'Dar es Salaam',
    'MOROGORO': 'Morogoro',
    'IFAKARA': 'Ifakara',
    'MALINYI': 'Malinyi',
  };

  final _formKey = GlobalKey<FormState>();
  String? _from;
  String? _to;
  late DateTime _departureDate;
  int _passengers = 1;

  @override
  void initState() {
    super.initState();
    _from = widget.initialFrom;
    _to = widget.initialTo;
    _departureDate = widget.initialDate ?? DateTime.now().add(const Duration(days: 1));
    _passengers = widget.initialPassengers ?? 1;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _departureDate = picked);
  }

  void _submitBooking() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    final fromLabel = _locations[_from] ?? _from!;
    final toLabel = _locations[_to] ?? _to!;
    final date =
        '${_departureDate.day.toString().padLeft(2, '0')}/${_departureDate.month.toString().padLeft(2, '0')}/${_departureDate.year}';

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t('bookTicket')),
        content: Text(
          '$fromLabel → $toLabel\n$date • $_passengers ${context.t('passengers')}\n\nYour booking request is ready. Please confirm through our call center or WhatsApp support.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel =
        '${_departureDate.day.toString().padLeft(2, '0')}/${_departureDate.month.toString().padLeft(2, '0')}/${_departureDate.year}';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t('bookTicket')),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [AppTheme.brandBlue, AppTheme.brandRed]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _from,
                      isDense: true,
                      decoration: _fieldDecoration(context.t('from')),
                      items: _locations.entries
                          .map(
                            (entry) => DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value, overflow: TextOverflow.ellipsis),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _from = value),
                      validator: (value) =>
                          value == null ? context.t('selectOrigin') : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _to,
                      isDense: true,
                      decoration: _fieldDecoration(context.t('to')),
                      items: _locations.entries
                          .map(
                            (entry) => DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value, overflow: TextOverflow.ellipsis),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _to = value),
                      validator: (value) {
                        if (value == null) return context.t('selectDestination');
                        if (_from != null && value == _from) {
                          return context.t('destinationDifferent');
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: _fieldDecoration(context.t('departureDate')),
                        child: Row(
                          children: [
                            Text(dateLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
                            const Spacer(),
                            const Icon(Icons.calendar_month_outlined, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InputDecorator(
                      decoration: _fieldDecoration(context.t('passengers')),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: _passengers > 1
                                ? () => setState(() => _passengers -= 1)
                                : null,
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text('$_passengers', style: const TextStyle(fontWeight: FontWeight.w800)),
                          IconButton(
                            onPressed: _passengers < 8
                                ? () => setState(() => _passengers += 1)
                                : null,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _submitBooking,
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(context.t('continueBooking')),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.brandAmber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
    );
  }
}
