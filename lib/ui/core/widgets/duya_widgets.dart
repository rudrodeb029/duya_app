import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/repositories/auth_profile_repository.dart';
import '../theme/duya_colors.dart';
import 'islamic_patterns.dart';

/// Signature Duya daylight card with crisp 12px radius, hairline emerald border,
/// and subtle HomeView-matched emerald shadow.
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

  static const lightShadow = [
    BoxShadow(
      color: Color(0x130E523C),
      blurRadius: 18,
      offset: Offset(0, 6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor =
        color ?? (isDark ? DuyaColors.nightCard : DuyaColors.cardLight);
    final isTransparent = cardColor.a == 0;
    final borderColor = isDark
        ? DuyaColors.nightBorder
        : DuyaColors.emerald.withValues(alpha: isTransparent ? 0.16 : 0.09);

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
        boxShadow: (isDark || isTransparent) ? null : lightShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Sunlit sage-pearl backdrop used across HomeView and all secondary pages.
class DuyaDaylightBackground extends StatelessWidget {
  const DuyaDaylightBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      return ColoredBox(color: DuyaColors.nightCanvas, child: child);
    }
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFEEF4F2), Color(0xFFF3F7F5), Color(0xFFF6F9F8)],
        ),
      ),
      child: child,
    );
  }
}

/// Circular elevated white action button matching HomeView's profile button.
class DuyaCircleActionButton extends StatelessWidget {
  const DuyaCircleActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.badgeCount = 0,
    this.size = 40,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;
  final int badgeCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final button = Material(
      color: isDark
          ? DuyaColors.nightCard
          : Colors.white.withValues(alpha: 0.94),
      shape: const CircleBorder(),
      elevation: isDark ? 0 : 3,
      shadowColor: const Color(0x220E523C),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Badge.count(
            count: badgeCount,
            isLabelVisible: badgeCount > 0,
            child: Icon(
              icon,
              color: isDark
                  ? DuyaColors.textPrimaryDark
                  : const Color(0xFF136048),
              size: 20,
            ),
          ),
        ),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}

/// Transparent quick-action header tile matching HomeView's Rawdah/Hajj row.
class DuyaHeaderQuickTile extends StatelessWidget {
  const DuyaHeaderQuickTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isDark
                      ? DuyaColors.desertGoldSoft
                      : const Color(0xFF0E5A42),
                  size: 22,
                ),
                const SizedBox(height: 5),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? DuyaColors.textPrimaryDark
                        : const Color(0xFF1B4332),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Daylight mosque-backdrop header shared by tabs and pushed subpages so
/// every route shares HomeView's exact sunlit top architecture.
class DuyaDaylightHeader extends StatelessWidget {
  const DuyaDaylightHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = true,
    this.showLogo = false,
    this.onBack,
    this.actions = const [],
    this.bottom,
    this.bottomPadding = 12,
  });

  final String title;
  final String? subtitle;
  final bool showBack;
  final bool showLogo;
  final VoidCallback? onBack;
  final List<Widget> actions;
  final Widget? bottom;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        if (!isDark)
          Positioned.fill(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/hero_mosque_header.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topRight,
                  errorBuilder: (_, _, _) => const ColoredBox(
                    color: Color(0xFFEAF2EF),
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.45, 0.85, 1.0],
                      colors: [
                        Color(0x55F3F7F5),
                        Color(0x88F3F7F5),
                        Color(0xE8F3F7F5),
                        Color(0xFFF3F7F5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, bottomPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (showBack) ...[
                      DuyaCircleActionButton(
                        icon: Icons.arrow_back_rounded,
                        tooltip: 'Back',
                        onTap: onBack ??
                            () => context.canPop()
                                ? context.pop()
                                : context.go('/home'),
                      ),
                      const SizedBox(width: 12),
                    ] else if (showLogo) ...[
                      const SizedBox(
                        width: 38,
                        height: 40,
                        child: CustomPaint(painter: DuyaArchLogoPainter()),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isDark
                                  ? DuyaColors.textPrimaryDark
                                  : const Color(0xFF10553F),
                              fontSize: 13.0,
                              height: 1.15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.2,
                            ),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              subtitle!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isDark
                                    ? DuyaColors.textSecondaryDark
                                    : DuyaColors.textSecondaryLight,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (actions.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      ...actions,
                    ],
                  ],
                ),
                if (bottom != null) ...[
                  const SizedBox(height: 14),
                  bottom!,
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Unified daylight scaffold with HomeView's sage-pearl backdrop and sunlit header.
class DuyaSubpageScaffold extends StatelessWidget {
  const DuyaSubpageScaffold({
    super.key,
    required this.title,
    required this.body,
    this.subtitle,
    this.actions = const [],
    this.headerBottom,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final Widget? headerBottom;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: DuyaDaylightBackground(
        child: Column(
          children: [
            DuyaDaylightHeader(
              title: title,
              subtitle: subtitle,
              showBack: true,
              actions: actions,
              bottom: headerBottom,
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

/// HomeView-style sunlit showcase card with right-fading daylight photo & silk ribbon.
class DuyaDaylightBannerCard extends StatelessWidget {
  const DuyaDaylightBannerCard({
    super.key,
    required this.child,
    this.imageAsset,
    this.onTap,
    this.showRibbon = true,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final String? imageAsset;
  final VoidCallback? onTap;
  final bool showRibbon;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? DuyaColors.nightCard : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? DuyaColors.nightBorder
              : DuyaColors.emerald.withValues(alpha: 0.09),
        ),
        boxShadow: isDark ? null : DuyaCard.lightShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Stack(
              children: [
                if (imageAsset != null)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: 170,
                    child: ShaderMask(
                      shaderCallback: (rect) => const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.0, 0.35, 1.0],
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                          Colors.black,
                        ],
                      ).createShader(rect),
                      blendMode: BlendMode.dstIn,
                      child: Opacity(
                        opacity: isDark ? 0.25 : 0.92,
                        child: Image.asset(
                          imageAsset!,
                          fit: BoxFit.cover,
                          alignment: Alignment.centerRight,
                          errorBuilder: (_, _, _) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  ),
                if (showRibbon)
                  const Positioned(
                    right: 0,
                    bottom: 0,
                    width: 160,
                    height: 36,
                    child: IgnorePointer(
                      child: CustomPaint(painter: CardSilkRibbonPainter()),
                    ),
                  ),
                Padding(padding: padding, child: child),
              ],
            ),
          ),
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

/// Compact golden Ilm balance pill (four-diamond emblem + count).
class DuyaIlmChip extends StatelessWidget {
  const DuyaIlmChip({super.key, required this.count, this.onTap});

  final num count;
  final VoidCallback? onTap;

  String get _formattedCount {
    final d = count.toDouble();
    if (d == d.roundToDouble()) return d.toInt().toString();
    return double.parse(d.toStringAsFixed(3)).toString();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const IlmIcon(size: 15, color: DuyaColors.desertGold),
              const SizedBox(width: 6),
              Text(
                '$_formattedCount Ilm',
                style: TextStyle(
                  color: isDark
                      ? DuyaColors.textPrimaryDark
                      : const Color(0xFF10553F),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
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
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: DuyaColors.desertGoldSoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: DuyaColors.desertGold,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Enable Location Services',
            style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'Allow Duya to calculate exact prayer times, smart Adhan reminders, and accurate Qibla direction for your current city.',
            style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                  fontSize: 10.5,
                  height: 1.4,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
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
              onPressed: () {
                onEnableLocation();
                Navigator.of(ctx).pop();
              },
              icon: const Icon(Icons.my_location, size: 16),
              label: const Text(
                'Enable Location',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Select City Manually Later',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
              ),
            ),
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
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
