/// Immutable domain models for User Profile, Wallet, and Duya AI chat.
class UserProfile {
  const UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.nationality,
    required this.isGuest,
    required this.locationEnabled,
    required this.notificationsEnabled,
    this.phone = '',
    this.passportNumber = '',
    this.dateOfBirth = '',
    this.gender = '',
    this.city = '',
    this.emergencyContact = '',
  });

  final String id;
  final String fullName;
  final String email;
  final String? nationality;
  final bool isGuest;
  final bool locationEnabled;
  final bool notificationsEnabled;
  final String phone;
  final String passportNumber;
  final String dateOfBirth;
  final String gender;
  final String city;
  final String emergencyContact;

  UserProfile copyWith({
    String? id,
    String? fullName,
    String? email,
    String? nationality,
    bool? isGuest,
    bool? locationEnabled,
    bool? notificationsEnabled,
    String? phone,
    String? passportNumber,
    String? dateOfBirth,
    String? gender,
    String? city,
    String? emergencyContact,
  }) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      nationality: nationality ?? this.nationality,
      isGuest: isGuest ?? this.isGuest,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      phone: phone ?? this.phone,
      passportNumber: passportNumber ?? this.passportNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      emergencyContact: emergencyContact ?? this.emergencyContact,
    );
  }
}

class WalletTransaction {
  const WalletTransaction({
    required this.id,
    required this.title,
    required this.dateLabel,
    required this.amountSar,
    required this.isCredit,
    required this.category,
  });

  final String id;
  final String title;
  final String dateLabel;
  final double amountSar;
  final bool isCredit;
  final String category;
}

class AiActionLink {
  const AiActionLink({required this.label, required this.route});

  final String label;
  final String route;
}

class AiMessage {
  const AiMessage({
    required this.id,
    required this.isUser,
    required this.text,
    required this.timestamp,
    this.actionLinks = const [],
  });

  final String id;
  final bool isUser;
  final String text;
  final DateTime timestamp;
  final List<AiActionLink> actionLinks;
}
