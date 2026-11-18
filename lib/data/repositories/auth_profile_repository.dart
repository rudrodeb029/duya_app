import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../domain/models/user_wallet_models.dart';
import '../services/preferences_service.dart';

/// Single source of truth for user identity, onboarding state, localization,
/// theme preference, and saved bookmarks.
class AuthProfileRepository extends ChangeNotifier {
  AuthProfileRepository({required this._prefs});

  final PreferencesService _prefs;

  static const _kOnboardingDone = 'onboarding_done';
  static const _kLocaleCode = 'locale_code';
  static const _kDarkMode = 'dark_mode';
  static const _kUserName = 'user_name';
  static const _kUserEmail = 'user_email';
  static const _kUserPhone = 'user_phone';
  static const _kUserPassport = 'user_passport';
  static const _kUserDob = 'user_dob';
  static const _kUserGender = 'user_gender';
  static const _kUserCity = 'user_city';
  static const _kUserEmergency = 'user_emergency';
  static const _kNationality = 'user_nationality';
  static const _kInviteCode = 'user_invite_code';
  static const _kIsGuest = 'user_is_guest';
  static const _kLocationEnabled = 'location_enabled';
  static const _kBookmarkedAyahs = 'bookmarked_ayahs';
  static const _kFavoriteDuas = 'favorite_duas';

  bool _onboardingCompleted = false;
  bool get onboardingCompleted => _onboardingCompleted;

  String _localeCode = 'en';
  String get localeCode => _localeCode;
  bool get isArabic => _localeCode == 'ar';

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  String _inviteCode = '';
  String get inviteCode {
    if (_inviteCode.isEmpty) {
      _inviteCode = _generateUniqueInviteCode();
    }
    return _inviteCode;
  }

  static String _generateUniqueInviteCode([String? seedHint]) {
    const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rng = Random.secure();
    final buffer = StringBuffer('DUYA-');
    if (seedHint != null && seedHint.trim().isNotEmpty) {
      final hash = seedHint.trim().toLowerCase().codeUnits.fold<int>(
            0x811C9DC5,
            (h, c) => ((h ^ c) * 0x01000193) & 0x7FFFFFFF,
          );
      buffer.write(alphabet[hash % alphabet.length]);
      buffer.write(alphabet[(hash >> 5) % alphabet.length]);
    }
    while (buffer.length < 11) {
      buffer.write(alphabet[rng.nextInt(alphabet.length)]);
    }
    return buffer.toString();
  }

  UserProfile _profile = const UserProfile(
    id: 'guest',
    fullName: 'Guest Pilgrim',
    email: '',
    nationality: null,
    isGuest: true,
    locationEnabled: false,
    notificationsEnabled: true,
  );
  UserProfile get profile => _profile;

  final Set<String> _bookmarkedAyahKeys = {'1:1', '93:3'};
  Set<String> get bookmarkedAyahKeys => Set.unmodifiable(_bookmarkedAyahKeys);

  final Set<String> _favoriteDuaIds = {'dua_morning_1', 'dua_tawaf_1'};
  Set<String> get favoriteDuaIds => Set.unmodifiable(_favoriteDuaIds);

  static const List<String> nationalities = [
    'Saudi Arabia',
    'Bangladesh',
    'Indonesia',
    'Pakistan',
    'Egypt',
    'Turkey',
    'Malaysia',
    'United Kingdom',
    'United States',
    'United Arab Emirates',
    'India',
    'Nigeria',
    'Morocco',
    'Jordan',
    'Germany',
    'Switzerland',
    'Sweden',
    'Suriname',
    'Ghana',
    'Georgia',
  ];

  Future<void> load() async {
    _onboardingCompleted = _prefs.getBool(_kOnboardingDone);
    _localeCode = _prefs.getString(_kLocaleCode) ?? 'en';
    _isDarkMode = _prefs.getBool(_kDarkMode);

    final savedName = _prefs.getString(_kUserName);
    final savedEmail = _prefs.getString(_kUserEmail);
    final savedPhone = _prefs.getString(_kUserPhone);
    final savedPassport = _prefs.getString(_kUserPassport);
    final savedDob = _prefs.getString(_kUserDob);
    final savedGender = _prefs.getString(_kUserGender);
    final savedCity = _prefs.getString(_kUserCity);
    final savedEmergency = _prefs.getString(_kUserEmergency);
    final savedNat = _prefs.getString(_kNationality);
    final savedInvite = _prefs.getString(_kInviteCode);
    final isGuest = _prefs.getBool(_kIsGuest, defaultValue: true);
    final locEnabled = _prefs.getBool(_kLocationEnabled);

    if (savedInvite != null && savedInvite.isNotEmpty) {
      _inviteCode = savedInvite;
    } else {
      _inviteCode = _generateUniqueInviteCode(savedEmail ?? savedName);
      await _prefs.setString(_kInviteCode, _inviteCode);
    }

    _profile = _profile.copyWith(
      fullName: savedName ?? 'Guest Pilgrim',
      email: savedEmail ?? '',
      phone: savedPhone ?? '',
      passportNumber: savedPassport ?? '',
      dateOfBirth: savedDob ?? '',
      gender: savedGender ?? '',
      city: savedCity ?? '',
      emergencyContact: savedEmergency ?? '',
      nationality: savedNat,
      isGuest: isGuest,
      locationEnabled: locEnabled,
    );

    final ayahs = _prefs.getStringList(_kBookmarkedAyahs);
    if (ayahs.isNotEmpty) {
      _bookmarkedAyahKeys
        ..clear()
        ..addAll(ayahs);
    }
    final duas = _prefs.getStringList(_kFavoriteDuas);
    if (duas.isNotEmpty) {
      _favoriteDuaIds
        ..clear()
        ..addAll(duas);
    }
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _onboardingCompleted = true;
    await _prefs.setBool(_kOnboardingDone, true);
    notifyListeners();
  }

  Future<void> setLocale(String code) async {
    if (_localeCode == code) return;
    _localeCode = code;
    await _prefs.setString(_kLocaleCode, code);
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setBool(_kDarkMode, _isDarkMode);
    notifyListeners();
  }

  Future<void> continueAsGuest() async {
    _onboardingCompleted = true;
    _profile = _profile.copyWith(isGuest: true, fullName: 'Guest Pilgrim');
    await _prefs.setBool(_kOnboardingDone, true);
    await _prefs.setBool(_kIsGuest, true);
    notifyListeners();
  }

  Future<void> signInWithEmail({
    required String email,
    String? displayName,
  }) async {
    _onboardingCompleted = true;
    final cleanName = (displayName != null && displayName.trim().isNotEmpty)
        ? displayName.trim()
        : email.split('@').first;
    _profile = _profile.copyWith(
      id: 'user_${email.hashCode}',
      fullName: cleanName,
      email: email.trim(),
      isGuest: false,
    );
    await _prefs.setBool(_kOnboardingDone, true);
    await _prefs.setBool(_kIsGuest, false);
    await _prefs.setString(_kUserName, _profile.fullName);
    await _prefs.setString(_kUserEmail, _profile.email);
    _inviteCode = _generateUniqueInviteCode(_profile.email);
    await _prefs.setString(_kInviteCode, _inviteCode);
    notifyListeners();
  }

  Future<void> signInWithSso() async {
    await signInWithEmail(
      email: 'pilgrim@duya.app',
      displayName: 'Abdullah Al-Mansoor',
    );
  }

  Future<void> registerAccount({
    required String fullName,
    required String email,
    required String nationality,
  }) async {
    _onboardingCompleted = true;
    _profile = _profile.copyWith(
      id: 'user_${email.hashCode}',
      fullName: fullName.trim(),
      email: email.trim(),
      nationality: nationality,
      isGuest: false,
    );
    await _prefs.setBool(_kOnboardingDone, true);
    await _prefs.setBool(_kIsGuest, false);
    await _prefs.setString(_kUserName, _profile.fullName);
    await _prefs.setString(_kUserEmail, _profile.email);
    await _prefs.setString(_kNationality, nationality);
    _inviteCode = _generateUniqueInviteCode(_profile.email);
    await _prefs.setString(_kInviteCode, _inviteCode);
    notifyListeners();
  }

  Future<void> updateNationality(String nationality) async {
    _profile = _profile.copyWith(nationality: nationality);
    await _prefs.setString(_kNationality, nationality);
    notifyListeners();
  }

  Future<void> updateProfileDetails({
    required String fullName,
    required String email,
    required String phone,
    String? nationality,
    required String passportNumber,
    required String dateOfBirth,
    required String gender,
    required String city,
    required String emergencyContact,
  }) async {
    final cleanName = fullName.trim().isEmpty ? 'Guest Pilgrim' : fullName.trim();
    final cleanEmail = email.trim();
    final cleanPhone = phone.trim();
    final cleanPassport = passportNumber.trim();
    final cleanDob = dateOfBirth.trim();
    final cleanGender = gender.trim();
    final cleanCity = city.trim();
    final cleanEmergency = emergencyContact.trim();

    _profile = _profile.copyWith(
      fullName: cleanName,
      email: cleanEmail,
      phone: cleanPhone,
      nationality: nationality ?? _profile.nationality,
      passportNumber: cleanPassport,
      dateOfBirth: cleanDob,
      gender: cleanGender,
      city: cleanCity,
      emergencyContact: cleanEmergency,
      isGuest: cleanName == 'Guest Pilgrim' && cleanEmail.isEmpty,
    );

    await _prefs.setString(_kUserName, cleanName);
    await _prefs.setString(_kUserEmail, cleanEmail);
    await _prefs.setString(_kUserPhone, cleanPhone);
    await _prefs.setString(_kUserPassport, cleanPassport);
    await _prefs.setString(_kUserDob, cleanDob);
    await _prefs.setString(_kUserGender, cleanGender);
    await _prefs.setString(_kUserCity, cleanCity);
    await _prefs.setString(_kUserEmergency, cleanEmergency);
    if (nationality != null) {
      await _prefs.setString(_kNationality, nationality);
    }
    await _prefs.setBool(_kIsGuest, _profile.isGuest);
    notifyListeners();
  }

  Future<void> setLocationEnabled(bool enabled) async {
    _profile = _profile.copyWith(locationEnabled: enabled);
    await _prefs.setBool(_kLocationEnabled, enabled);
    notifyListeners();
  }

  Future<void> toggleAyahBookmark(String ayahKey) async {
    if (_bookmarkedAyahKeys.contains(ayahKey)) {
      _bookmarkedAyahKeys.remove(ayahKey);
    } else {
      _bookmarkedAyahKeys.add(ayahKey);
    }
    await _prefs.setStringList(_kBookmarkedAyahs, _bookmarkedAyahKeys.toList());
    notifyListeners();
  }

  Future<void> toggleFavoriteDua(String duaId) async {
    if (_favoriteDuaIds.contains(duaId)) {
      _favoriteDuaIds.remove(duaId);
    } else {
      _favoriteDuaIds.add(duaId);
    }
    await _prefs.setStringList(_kFavoriteDuas, _favoriteDuaIds.toList());
    notifyListeners();
  }

  Future<void> signOut() async {
    _profile = _profile.copyWith(
      id: 'guest',
      fullName: 'Guest Pilgrim',
      email: '',
      isGuest: true,
    );
    await _prefs.setBool(_kIsGuest, true);
    notifyListeners();
  }
}
