import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// User Profile screen where users can enter and save all personal details,
/// nationality, language (EN/AR), Warm Night theme & saved items.
class ProfileView extends StatefulWidget {
  const ProfileView({super.key, this.inShell = false});

  final bool inShell;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;
  late final TextEditingController _passportController;
  late final TextEditingController _dobController;
  late final TextEditingController _emergencyController;

  String? _nationality;
  String _gender = '';
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    final profile = context.read<AuthProfileRepository>().profile;
    _nameController = TextEditingController(
      text: profile.fullName == 'Guest Pilgrim' ? '' : profile.fullName,
    );
    _emailController = TextEditingController(text: profile.email);
    _phoneController = TextEditingController(text: profile.phone);
    _cityController = TextEditingController(text: profile.city);
    _passportController = TextEditingController(text: profile.passportNumber);
    _dobController = TextEditingController(text: profile.dateOfBirth);
    _emergencyController =
        TextEditingController(text: profile.emergencyContact);
    _nationality = profile.nationality;
    _gender = profile.gender;
    _initialized = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _passportController.dispose();
    _dobController.dispose();
    _emergencyController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile(AuthProfileRepository auth) async {
    await auth.updateProfileDetails(
      fullName: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      nationality: _nationality,
      passportNumber: _passportController.text,
      dateOfBirth: _dobController.text,
      gender: _gender,
      city: _cityController.text,
      emergencyContact: _emergencyController.text,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Profile details saved!')),
      );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProfileRepository>();
    final profile = auth.profile;
    final displayName = _nameController.text.trim().isNotEmpty
        ? _nameController.text.trim()
        : profile.fullName;

    final listContent = ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        DuyaCard(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: DuyaColors.emerald,
                child: Text(
                  displayName.characters.first.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profile.email.isNotEmpty
                          ? profile.email
                          : (profile.isGuest ? 'Guest Explorer' : ''),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 10.5),
                    ),
                  ],
                ),
              ),
              if (profile.isGuest)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 32),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                  onPressed: () => context.push('/auth/login'),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 10.5),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Personal Info',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        DuyaCard(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileInputField(
                controller: _nameController,
                label: 'Full Name',
                hint: 'Enter your full name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 10),
              _ProfileInputField(
                controller: _emailController,
                label: 'Email',
                hint: 'you@example.com',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              _ProfileInputField(
                controller: _phoneController,
                label: 'Phone / WhatsApp',
                hint: '+966 5X XXX XXXX',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () async {
                        final picked = await showNationalityPickerSheet(
                          context,
                          currentSelection: _nationality,
                        );
                        if (picked != null) {
                          setState(() => _nationality = picked);
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          isDense: true,
                          labelText: 'Nationality',
                          labelStyle: TextStyle(fontSize: 11),
                          prefixIcon: Icon(
                            Icons.public_outlined,
                            size: 17,
                            color: DuyaColors.emerald,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          _nationality ?? 'Select country',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.5,
                            color: _nationality == null
                                ? Theme.of(context).hintColor
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ProfileInputField(
                      controller: _cityController,
                      label: 'City',
                      hint: 'e.g. Makkah',
                      icon: Icons.location_city_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _ProfileInputField(
                      controller: _passportController,
                      label: 'Passport / ID',
                      hint: 'Passport number',
                      icon: Icons.badge_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ProfileInputField(
                      controller: _dobController,
                      label: 'Date of Birth',
                      hint: 'DD/MM/YYYY',
                      icon: Icons.cake_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Gender',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  for (final g in ['Male', 'Female']) ...[
                    ChoiceChip(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Text(g, style: const TextStyle(fontSize: 10.5)),
                      selected: _gender == g,
                      onSelected: (_) => setState(() => _gender = g),
                    ),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              _ProfileInputField(
                controller: _emergencyController,
                label: 'Emergency Contact',
                hint: 'Name & phone number',
                icon: Icons.contact_emergency_outlined,
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                  ),
                  onPressed: () => _saveProfile(auth),
                  icon: const Icon(Icons.save_outlined, size: 16),
                  label: const Text(
                    'Save Info',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Preferences',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        DuyaCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                secondary: const Icon(Icons.translate, size: 20),
                title: const Text(
                  'Arabic Language (RTL)',
                  style: TextStyle(fontSize: 12),
                ),
                subtitle: Text(
                  auth.isArabic ? 'العربية مفعلة' : 'English',
                  style: const TextStyle(fontSize: 10.5),
                ),
                value: auth.isArabic,
                onChanged: (v) => auth.setLocale(v ? 'ar' : 'en'),
              ),
              const Divider(height: 1),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                secondary: const Icon(Icons.dark_mode_outlined, size: 20),
                title: const Text(
                  'Warm Night Mode',
                  style: TextStyle(fontSize: 12),
                ),
                value: auth.isDarkMode,
                onChanged: (_) => auth.toggleDarkMode(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        DuyaCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          onTap: () => context.push('/journey/bookings'),
          child: const ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Icon(Icons.confirmation_num_outlined, size: 20),
            title: Text(
              'My Bookings & Permits',
              style: TextStyle(fontSize: 12),
            ),
            trailing: Icon(Icons.chevron_right, size: 18),
          ),
        ),
        const SizedBox(height: 10),
        DuyaCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          onTap: () => context.push('/content/quran'),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: const Icon(Icons.bookmark_outline, size: 20),
            title: const Text(
              'Saved Qur’an & Dua Bookmarks',
              style: TextStyle(fontSize: 12),
            ),
            subtitle: Text(
              '${auth.bookmarkedAyahKeys.length} Ayahs • ${auth.favoriteDuaIds.length} Duas',
              style: const TextStyle(fontSize: 10.5),
            ),
            trailing: const Icon(Icons.chevron_right, size: 18),
          ),
        ),
        if (!profile.isGuest) ...[
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => auth.signOut(),
            icon: const Icon(Icons.logout, size: 16),
            label: const Text('Sign Out', style: TextStyle(fontSize: 11.5)),
          ),
        ],
      ],
    );

    if (widget.inShell) {
      return DuyaDaylightBackground(
        child: Column(
          children: [
            DuyaDaylightHeader(
              title: auth.isArabic ? 'الملف الشخصي' : 'Profile',
              showBack: false,
              showLogo: true,
            ),
            Expanded(child: listContent),
          ],
        ),
      );
    }

    return DuyaSubpageScaffold(
      title: auth.isArabic ? 'الملف الشخصي' : 'Profile',
      body: listContent,
    );
  }
}

class _ProfileInputField extends StatelessWidget {
  const _ProfileInputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 11.5),
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        labelStyle: const TextStyle(fontSize: 11),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 10.5),
        prefixIcon: Icon(icon, size: 17, color: DuyaColors.emerald),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
    );
  }
}
