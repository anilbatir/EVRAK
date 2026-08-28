import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/document_provider.dart';
import '../theme/app_theme.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DocumentProvider>().loadDocuments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactive = isDark ? AppColors.darkTextSecondary : const Color(0xFFA8A5BC);
    final accent = AppColors.accent;

    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBg : AppColors.lightBg,
          border: Border(top: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              label: 'Ana Sayfa',
              selected: _index == 0,
              color: accent,
              inactiveColor: inactive,
              onTap: () => setState(() => _index = 0),
            ),
            _NavItem(
              icon: Icons.grid_view_rounded,
              label: 'Kategoriler',
              selected: _index == 1,
              color: accent,
              inactiveColor: inactive,
              onTap: () => setState(() => _index = 1),
            ),
            _NavItem(
              icon: Icons.favorite_rounded,
              label: 'Favoriler',
              selected: _index == 2,
              color: accent,
              inactiveColor: inactive,
              onTap: () => setState(() => _index = 2),
            ),
            _NavItem(
              icon: Icons.person_rounded,
              label: 'Profil',
              selected: _index == 3,
              color: accent,
              inactiveColor: inactive,
              onTap: () => setState(() => _index = 3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.color,
    required this.inactiveColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final Color color;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tint = selected ? color : inactiveColor;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: tint),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 10.5, color: tint, fontWeight: selected ? FontWeight.w700 : FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
