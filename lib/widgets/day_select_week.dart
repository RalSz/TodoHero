import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DaySelectWeek extends StatefulWidget
{
  final ValueChanged<Set<String>?> onChanged;
  const DaySelectWeek({
    super.key,
    required this.onChanged,
  });

  @override
  State<DaySelectWeek> createState() => _DaySelectWeekState();
}

class _DaySelectWeekState extends State<DaySelectWeek>
{
  final _days = ["Su", "M", "Tu", "W", "Th", "F", "Sa"];
  final Set<String> _selectedDays = {};

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _days.map((day) {
        final isSelected = _selectedDays.contains(day);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedDays.remove(day);
              } else {
                _selectedDays.add(day);
              }

              widget.onChanged(_selectedDays);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : null,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: isSelected ? AppColors.primary : AppColors.secondary)
            ),
            child: Text(
              day,
              style: AppTextStyles.body
            )
          ),
        );
      }).toList(),
    );
  }
}