import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../theme/duya_colors.dart';
import 'islamic_patterns.dart';

/// Signature Duya card with subtle sandstone/theme-aware border.
class DuyaCard extends StatelessWidget {
  const DuyaCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.onTap,
    this.borderRadius = 12,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final VoidCallback? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor =
        color ?? (isDark ? DuyaColors.nightCard : DuyaColors.cardLight);
    final borderColor =
        isDark ? DuyaColors.nightBorder : DuyaColors.borderLight;

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Section header with optional "View all" pill button.
class DuyaSectionHeader extends StatelessWidget {
  const DuyaSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onActionTap,
    this.actionLabel,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onActionTap;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleLarge),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle!, style: textTheme.bodyMedium),
              ],
            ],
          ),
        ),
        if (onActionTap != null)
          InkWell(
            onTap: onActionTap,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (actionLabel != null) ...[
                    Text(
                      actionLabel!,
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                  const Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Duya geometric badge used in headers and logos.
class DuyaLogoBadge extends StatelessWidget {
  const DuyaLogoBadge({
    super.key,
    this.size = 34,
    this.color = Colors.white,
    this.filled = false,
  });

  final double size;
  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: RubElHizbPainter(color: color, filled: filled),
    );
  }
}

/// Location & Prayer Accuracy permission sheet (elevated alternative to reference modal).
Future<void> showLocationPermissionSheet(
  BuildContext context, {
  required VoidCallback onEnableLocation,
}) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (ctx) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: DuyaColors.desertGoldSoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: DuyaColors.desertGold,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Enable Location Services',
            style: Theme.of(ctx).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Allow Duya to calculate exact prayer times, smart Adhan reminders, and accurate Qibla direction for your current city.',
            style: Theme.of(ctx).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                onEnableLocation();
                Navigator.of(ctx).pop();
              },
              icon: const Icon(Icons.my_location),
              label: const Text('Enable Location'),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Select City Manually Later'),
          ),
        ],
      ),
    ),
  );
}

/// Contextual Sign-In sheet shown only when a guest triggers an account-required action.
Future<void> showLoginPromptSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (ctx) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sign In to Continue',
            style: Theme.of(ctx).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Sign in or create a Duya account to save permits, sync bookings, and secure Challenge entries.',
            style: Theme.of(ctx).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DuyaCard(
                  onTap: () {
                    Navigator.of(ctx).pop();
                    context.push('/auth/login');
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.lock_outline, size: 28),
                      SizedBox(height: 10),
                      Text(
                        'Login with Email',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DuyaCard(
                  onTap: () {
                    Navigator.of(ctx).pop();
                    context.push('/auth/login?sso=1');
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        size: 28,
                        color: DuyaColors.emerald,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Digital ID / SSO',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.of(ctx).pop();
                context.push('/auth/register');
              },
              icon: const Icon(Icons.person_add_alt),
              label: const Text('Register New Account'),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Searchable Nationality Picker bottom sheet (mirrors & improves reference picker).
Future<String?> showNationalityPickerSheet(
  BuildContext context, {
  String? currentSelection,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (ctx) => _NationalityPickerContent(currentSelection: currentSelection),
  );
}

class _NationalityPickerContent extends StatefulWidget {
  const _NationalityPickerContent({this.currentSelection});

  final String? currentSelection;

  @override
  State<_NationalityPickerContent> createState() =>
      _NationalityPickerContentState();
}

class _NationalityPickerContentState extends State<_NationalityPickerContent> {
  String _query = '';
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.currentSelection;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = AuthProfileRepository.nationalities
        .where((n) => n.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.72,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search nationality...',
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final country = filtered[index];
                  final isSelected = country == _selected;
                  return ListTile(
                    title: Text(country),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: DuyaColors.emerald)
                        : null,
                    onTap: () => setState(() => _selected = country),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selected == null
                    ? null
                    : () => Navigator.of(context).pop(_selected),
                child: const Text('Confirm Selection →'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
