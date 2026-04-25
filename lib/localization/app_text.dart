import 'package:flutter/widgets.dart';

enum AppLanguage { en, sw }

class LocaleScope extends InheritedWidget {
  const LocaleScope({
    super.key,
    required this.language,
    required this.setLanguage,
    required super.child,
  });

  final AppLanguage language;
  final ValueChanged<AppLanguage> setLanguage;

  static LocaleScope of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<LocaleScope>();
    assert(result != null, 'LocaleScope not found in widget tree.');
    return result!;
  }

  @override
  bool updateShouldNotify(LocaleScope oldWidget) => language != oldWidget.language;
}

class AppText {
  static const Map<String, String> _en = {
    'home': 'Home',
    'routes': 'Routes',
    'book': 'Book',
    'gallery': 'Gallery',
    'contact': 'Contact',
    'bookTicket': 'Book Ticket',
    'skip': 'Skip',
    'next': 'Next',
    'getStarted': 'Get Started',
    'onboard1Title': 'Travel Better With Louisline',
    'onboard1Sub':
        'Book routes fast, track trips, and enjoy premium coach comfort across Tanzania.',
    'onboard2Title': 'Smooth Booking Experience',
    'onboard2Sub':
        'Intuitive seat booking and professional service with seamless trip details.',
    'onboard3Title': 'Your Trip, Beautifully Organized',
    'onboard3Sub':
        'Manage tickets, discover routes, and stay updated in one elegant app.',
    'whyLouisline': 'Why Louisline',
    'premiumLocal': 'Premium local experience',
    'safeTrusted': 'Safe & Trusted',
    'safeTrustedSub': 'Experienced drivers and reliable route planning.',
    'comfortableCoaches': 'Comfortable Coaches',
    'comfortableCoachesSub': 'Clean interiors and relaxing seat space.',
    'fastBooking': 'Fast Booking',
    'fastBookingSub': 'Book in seconds and continue in secure flow.',
    'nativeBookingTitle': 'Native booking experience',
    'nativeBookingSub':
        'Choose route and date here, then continue to secure ticket booking.',
    'searchBookBus': 'Search and book your bus',
    'nativeHandoff': 'Styled natively for speed, then handoff to secure booking.',
    'from': 'From',
    'to': 'To',
    'departureDate': 'Departure date',
    'passengers': 'Passengers',
    'seatCount': 'Seat count',
    'continueBooking': 'Continue to Booking',
    'selectOrigin': 'Select origin',
    'selectDestination': 'Select destination',
    'destinationDifferent': 'Destination must be different',
    'routesSub': 'Daily schedule and premium comfort service.',
    'contactHero':
        'Need assistance? Our support team is available daily for booking and route inquiries.',
    'address': 'Address',
    'mobile': 'Mobile',
    'whatsapp': 'WhatsApp',
    'refresh': 'Refresh',
    'language': 'Language',
  };

  static const Map<String, String> _sw = {
    'home': 'Nyumbani',
    'routes': 'Njia',
    'book': 'Tiketi',
    'gallery': 'Picha',
    'contact': 'Mawasiliano',
    'bookTicket': 'Weka Tiketi',
    'skip': 'Ruka',
    'next': 'Ifuatayo',
    'getStarted': 'Anza',
    'onboard1Title': 'Safiri Vizuri na Louisline',
    'onboard1Sub':
        'Weka njia kwa haraka, fuatilia safari, na furahia faraja ya basi la kiwango cha juu Tanzania.',
    'onboard2Title': 'Uzoefu Rahisi wa Tiketi',
    'onboard2Sub':
        'Mfumo rahisi wa tiketi na huduma bora pamoja na taarifa za safari zilizo wazi.',
    'onboard3Title': 'Safari Yako Imepangwa Vizuri',
    'onboard3Sub':
        'Dhibiti tiketi, gundua njia, na pata taarifa zote kwenye app moja nzuri.',
    'whyLouisline': 'Kwa nini Louisline',
    'premiumLocal': 'Uzoefu bora wa ndani',
    'safeTrusted': 'Salama na ya Kuaminika',
    'safeTrustedSub': 'Madereva wenye uzoefu na mipango ya safari ya uhakika.',
    'comfortableCoaches': 'Mabasi ya Faraja',
    'comfortableCoachesSub': 'Ndani safi na nafasi nzuri ya kukaa.',
    'fastBooking': 'Tiketi ya Haraka',
    'fastBookingSub': 'Weka tiketi ndani ya sekunde na endelea kwa usalama.',
    'nativeBookingTitle': 'Uzoefu wa tiketi wa asili',
    'nativeBookingSub':
        'Chagua njia na tarehe hapa, kisha endelea kwenye mfumo salama wa kuweka tiketi.',
    'searchBookBus': 'Tafuta na weka nafasi ya basi',
    'nativeHandoff': 'Imeundwa native kwa kasi, kisha inaendelea kwenye mfumo salama wa tiketi.',
    'from': 'Kutoka',
    'to': 'Kwenda',
    'departureDate': 'Tarehe ya kuondoka',
    'passengers': 'Abiria',
    'seatCount': 'Idadi ya viti',
    'continueBooking': 'Endelea Kuweka Tiketi',
    'selectOrigin': 'Chagua unapopanda',
    'selectDestination': 'Chagua unakokwenda',
    'destinationDifferent': 'Unakokwenda lazima kutofautiana',
    'routesSub': 'Ratiba za kila siku na huduma ya faraja ya kiwango cha juu.',
    'contactHero':
        'Unahitaji msaada? Timu yetu ya huduma inapatikana kila siku kwa tiketi na maswali ya njia.',
    'address': 'Anwani',
    'mobile': 'Simu',
    'whatsapp': 'WhatsApp',
    'refresh': 'Pakia upya',
    'language': 'Lugha',
  };

  static String translate(AppLanguage language, String key) {
    final map = language == AppLanguage.sw ? _sw : _en;
    return map[key] ?? _en[key] ?? key;
  }
}

extension AppTextX on BuildContext {
  AppLanguage get appLanguage => LocaleScope.of(this).language;
  String t(String key) => AppText.translate(appLanguage, key);
}
