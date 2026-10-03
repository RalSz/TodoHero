import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DaySelectMonth extends StatefulWidget
{
  final ValueChanged<Set<int>?> onChanged;
  const DaySelectMonth({
    super.key,
    required this.onChanged,
  });

  @override
  State<DaySelectMonth> createState() => _DaySelectMonthState();
}

class _DaySelectMonthState extends State<DaySelectMonth>
{
  final _days = List<int>.generate(31, (int index) => index + 1);
  final Set<int> _selectedDays = {};

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Pick days"),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return Wrap(
              spacing: 8.0, 
              runSpacing: 4.0,
              children: _days.map((day) {
                final isSelected = _selectedDays.contains(day);
            
                return GestureDetector(
                  onTap: () {
                    setDialogState(() {
                      if (isSelected) {
                        _selectedDays.remove(day);
                      } else {
                        _selectedDays.add(day);
                      }
                      
                    });
            
                    widget.onChanged(Set<int>.from(_selectedDays));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : null,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: isSelected ? AppColors.primary : AppColors.secondary)
                    ),
                    child: Text(
                      "$day",
                      style: AppTextStyles.body
                    )
                  ),
                );
              }).toList()
            );
          }
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Done"))
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: _showDialog,
        style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: AppColors.secondary,
            width: 1,
          )
        ),
        child: Text("Select days", style: AppTextStyles.body)
      ),
    );
  }
}