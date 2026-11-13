/// Bilingual English / Arabic UI copy for core navigation and headers.
class AppStrings {
  const AppStrings({required this.isArabic});

  final bool isArabic;

  String get appName => isArabic ? 'دُعاء' : 'Duya';
  String get tagline => isArabic
      ? 'رفيقك الروحي ومناسكك في كل خطوة'
      : 'Your Spiritual & Pilgrimage Companion';

  // Bottom Navigation
  String get navHome => isArabic ? 'الرئيسية' : 'Home';
  String get navJourney => isArabic ? 'رحلتي' : 'Journey';
  String get navContent => isArabic ? 'المحتوى' : 'Content';
  String get navMarket => isArabic ? 'المتجر' : 'Market';
  String get navAi => isArabic ? 'مساعد دعاء' : 'Duya AI';

  // Common Actions
  String get skip => isArabic ? 'تخطي' : 'Skip';
  String get getStarted => isArabic ? 'ابدأ الرحلة' : 'Get Started';
  String get loginOrRegister =>
      isArabic ? 'تسجيل الدخول أو إنشاء حساب' : 'Sign In or Create Account';
  String get continueAsGuest =>
      isArabic ? 'المتابعة كضيف' : 'Explore as Guest';
  String get wallet => isArabic ? 'المحفظة' : 'Wallet';
  String get searchHint => isArabic ? 'ابحث هنا...' : 'Search...';
  String get viewAll => isArabic ? 'عرض الكل' : 'View all';

  // Home Sections
  String get rawdah => isArabic ? 'الروضة' : 'Rawdah';
  String get umrah => isArabic ? 'العمرة' : 'Umrah';
  String get hajj => isArabic ? 'الحج' : 'Hajj';
  String get allServices => isArabic ? 'كل الخدمات' : 'Services';
  String get motawef => isArabic ? 'مطوّف' : 'Motawef';
  String get quran => isArabic ? 'القرآن' : 'Qur’an';
  String get duas => isArabic ? 'الأدعية' : 'Duas';
  String get qibla => isArabic ? 'القبلة' : 'Qibla';
  String get prayerTimes => isArabic ? 'مواقيت الصلاة' : 'Prayer Times';
  String get mobility => isArabic ? 'عربة الحرم' : 'Mobility';
  String get zamzam => isArabic ? 'زمزم' : 'Zamzam';
}
