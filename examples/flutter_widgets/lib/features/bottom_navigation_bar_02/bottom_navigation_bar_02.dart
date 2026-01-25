import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widgets/core/app_icons.dart';

class BottomNavigationBarScreen02 extends StatefulWidget {
  const BottomNavigationBarScreen02({super.key});

  @override
  State<BottomNavigationBarScreen02> createState() =>
      _BottomNavigationBarScreen02State();
}

class _BottomNavigationBarScreen02State
    extends State<BottomNavigationBarScreen02> {
  int _currentSelectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text("Home")),
    Center(child: Text("Fav")),
    Center(child: Text("Cart")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    // 1. Theme Data: Get colors from the system/app theme
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 2. Brand Color: The orange specific to this design
    const brandColor = Color(0xFFFF7643);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: _pages[_currentSelectedIndex],

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          // Text style for the selected item (small, bold, brand color)
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: brandColor,
              );
            }
            // Text style for unselected items (optional, since we hide them usually)
            return TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant);
          }),
        ),
        child: NavigationBar(
          selectedIndex: _currentSelectedIndex,
          onDestinationSelected: (index) =>
              setState(() => _currentSelectedIndex = index),

          // Animation: Only show text when the tab is active
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,

          // Appearance
          backgroundColor: colorScheme.surfaceContainer,
          elevation: 0,
          indicatorColor: brandColor.withValues(alpha: 0.15),

          // Destinations using our cleaner AppIcons class
          destinations: [
            _buildDestination("Home", AppIcons.home, brandColor),
            _buildDestination("Fav", AppIcons.heart, brandColor),
            _buildDestination("Chat", AppIcons.chat, brandColor),
            _buildDestination("Profile", AppIcons.user, brandColor),
          ],
        ),
      ),
    );
  }

  /// Reusable helper to create destinations
  NavigationDestination _buildDestination(
    String label,
    String iconAsset,
    Color activeColor,
  ) {
    return NavigationDestination(
      label: label,
      // Icon when NOT selected (Standard Grey from Theme)
      icon: SvgPicture.string(
        iconAsset,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurfaceVariant,
          BlendMode.srcIn,
        ),
      ),
      // Icon when SELECTED (Brand Orange)
      selectedIcon: SvgPicture.string(
        iconAsset,
        colorFilter: ColorFilter.mode(
          activeColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
