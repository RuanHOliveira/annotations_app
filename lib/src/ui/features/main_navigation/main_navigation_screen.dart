import 'package:annotations_app/src/routing/routes.dart';
import 'package:annotations_app/src/ui/core/themes/app_text_styles.dart';
import 'package:annotations_app/src/ui/features/main_navigation/main_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class MainNavigationScreen extends StatefulWidget {
  final MainNavigationController _mainNavigationController;

  const MainNavigationScreen({
    super.key,
    required MainNavigationController mainNavigationController,
  }) : _mainNavigationController = mainNavigationController;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Observer(
      builder: (_) {
        return Scaffold(
          backgroundColor: cs.surface,
          drawer: _AppDrawer(
            mainNavigationController: widget._mainNavigationController,
            currentIndex: widget._mainNavigationController.selectedIndex,
            onItemSelected: _changeScreen,
          ),
          body: IndexedStack(
            index: widget._mainNavigationController.selectedIndex,
            children: widget._mainNavigationController.screensOptions,
          ),
        );
      },
    );
  }

  void _changeScreen(int selectedIndex) {
    widget._mainNavigationController.screenSelect(selectedIndex);
    Navigator.pop(context);
  }
}

class _AppDrawer extends StatelessWidget {
  final MainNavigationController mainNavigationController;
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const _AppDrawer({
    required this.currentIndex,
    required this.onItemSelected,
    required this.mainNavigationController,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final padding = MediaQuery.of(context).padding;

    return Drawer(
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      width: 280,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Premium Header
          Container(
            padding: EdgeInsets.fromLTRB(28, padding.top + 32, 28, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: cs.inversePrimary,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: cs.shadow.withAlpha(51),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.sticky_note_2_outlined,
                    size: 28,
                    color: cs.secondary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Annotations',
                  style: AppTextStyles.textBold24.copyWith(letterSpacing: -0.5),
                ),
                const SizedBox(height: 4),
                Text(
                  'Notas inteligentes',
                  style: AppTextStyles.text14.copyWith(
                    color: cs.primary.withAlpha(153),
                  ),
                ),
              ],
            ),
          ),

          // Navigation Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: cs.secondary),
                  const SizedBox(height: 8),
                  _DrawerItem(
                    index: 0,
                    label: 'Notas',
                    icon: Icons.grid_view_rounded,
                    isSelected: currentIndex == 0,
                    onTap: onItemSelected,
                  ),
                  _DrawerItem(
                    index: 1,
                    label: 'Detalhes',
                    icon: Icons.bar_chart_rounded,
                    isSelected: currentIndex == 1,
                    onTap: onItemSelected,
                  ),
                  const Spacer(),
                  _DrawerActionItem(
                    label: 'Sair',
                    icon: Icons.logout,
                    onTap: () async {
                      await mainNavigationController.clearAuth();
                      if (context.mounted) context.go(Routes.login);
                    },
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final int index;
  final String label;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  const _DrawerItem({
    required this.index,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(index),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? cs.secondary : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? cs.inversePrimary : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: isSelected ? cs.secondary : cs.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? cs.inversePrimary
                        : cs.inversePrimary.withAlpha(204),
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

class _DrawerActionItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerActionItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(icon, size: 20, color: cs.primary),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: cs.inversePrimary.withAlpha(204),
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
