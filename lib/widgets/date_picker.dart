import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';

class DatePicker extends StatefulWidget {
  final ValueChanged<DateTime?> onChanged;
  const DatePicker({
    super.key,
    required this.onChanged,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Selected Date: ${DateFormat('EEEE, MMM d').format(_selectedDate)}", style: AppTextStyles.body),
        ElevatedButton(
          onPressed: () async {
            final DateTime? dateTime = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2026),
              lastDate: DateTime(2100),
            );
            if (dateTime != null) {
              setState(() {
                _selectedDate = dateTime;
              });
              widget.onChanged(dateTime);
            }
          },
          style: ElevatedButton.styleFrom(
            side: const BorderSide(
              color: AppColors.secondary,
              width: 1,
            )
          ),
          child: Text("Choose Date", style: AppTextStyles.body,)
        ),
      ],
    );
  }
}