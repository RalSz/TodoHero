import 'package:flutter/material.dart';

class _TabAsset {
  final String active;
  final String inactive;

  const _TabAsset({required this.active, required this.inactive});
}

class AppNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const AppNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  static const List<_TabAsset> _tabs = [
    _TabAsset(
      active: '../assets/icons/Icon_Scroll1_1-1.png',
      inactive: '../assets/icons/Icon_Scroll0_1-1.png'
    ),
    _TabAsset(
      active: '../assets/icons/Icon_Map1_1-1.png',
      inactive: '../assets/icons/Icon_Map0_1-1.png'
    ),
    _TabAsset(
      active: '../assets/icons/Icon_Help1_1-1.png',
      inactive: '../assets/icons/Icon_Help0_1-1.png'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(_tabs.length, (index) {
        final isSelected = index == selectedIndex;
        return GestureDetector(
          onTap: () => onTabSelected(index),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              isSelected ? _tabs[index].active : _tabs[index].inactive,
              width: 48,
              height: 48,
            ),
          ),
        );
      }),
    );
  }
}