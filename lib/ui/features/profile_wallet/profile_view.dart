import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../../core/theme/duya_colors.dart';
import '../../core/widgets/duya_widgets.dart';

/// User Profile, Nationality, Language (EN/AR), Warm Night theme & Saved Items.
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProfileRepository>();
    final profile = auth.profile;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Preferences')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DuyaCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: DuyaColors.emerald,
                  child: Text(
                    profile.fullName.characters.first.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        profile.isGuest
                            ? 'Guest Explorer'
                            : profile.email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                if (profile.isGuest)
                  ElevatedButton(
                    onPressed: () => context.push('/auth/login'),
                    child: const Text('Sign In'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DuyaCard(
            onTap: () async {
              final picked = await showNationalityPickerSheet(
                context,
                currentSelection: profile.nationality,
              );
              if (picked != null) await auth.updateNationality(picked);
            },
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.public_outlined),
              title: const Text('Nationality'),
              subtitle: Text(profile.nationality ?? 'Not set'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 10),
          DuyaCard(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.translate),
                  title: const Text('Arabic Language (RTL)'),
                  subtitle: Text(auth.isArabic ? 'العربية مفعلة' : 'English'),
                  value: auth.isArabic,
                  onChanged: (v) => auth.setLocale(v ? 'ar' : 'en'),
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.dark_mode_outlined),
                  title: const Text('Warm Night Mode'),
                  value: auth.isDarkMode,
                  onChanged: (_) => auth.toggleDarkMode(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          DuyaCard(
            onTap: () => context.push('/journey/bookings'),
            child: const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.confirmation_num_outlined),
              title: Text('My Bookings & Permits'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 10),
          DuyaCard(
            onTap: () => context.push('/content/quran'),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.bookmark_outline),
              title: const Text('Saved Qur’an & Dua Bookmarks'),
              subtitle: Text(
                '${auth.bookmarkedAyahKeys.length} Ayahs • ${auth.favoriteDuaIds.length} Duas',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          if (!profile.isGuest) ...[
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => auth.signOut(),
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
            ),
          ],
        ],
      ),
    );
  }
}
