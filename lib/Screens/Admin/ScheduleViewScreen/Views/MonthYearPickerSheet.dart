import 'package:flutter/material.dart';

class MonthYearPickerSheet extends StatefulWidget {
  final int currentMonth;
  final int currentYear;
  final void Function(int month, int year) onSelected;

  const MonthYearPickerSheet({
    super.key,
    required this.currentMonth,
    required this.currentYear,
    required this.onSelected,
  });

  @override
  State<MonthYearPickerSheet> createState() => _MonthYearPickerSheetState();
}

class _MonthYearPickerSheetState extends State<MonthYearPickerSheet> {
  late int _month;
  late int _year;

  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    _month = widget.currentMonth;
    _year = widget.currentYear;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),

          const Text('Select Month & Year',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0D0D0D))),
          const SizedBox(height: 20),

          // Year Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _arrowBtn(Icons.chevron_left, () => setState(() => _year--)),
              const SizedBox(width: 24),
              Text('$_year',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0D0D0D))),
              const SizedBox(width: 24),
              _arrowBtn(Icons.chevron_right, () => setState(() => _year++)),
            ],
          ),
          const SizedBox(height: 20),

          // Month grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 12,
            itemBuilder: (ctx, i) {
              final isSelected = (i + 1) == _month;
              return GestureDetector(
                onTap: () => setState(() => _month = i + 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF0D0D0D)
                        : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _months[i].substring(0, 3),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? Colors.white : const Color(0xFF555555),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Confirm button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => widget.onSelected(_month, _year),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF18B9C5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Confirm',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _arrowBtn(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: const Color(0xFF0D0D0D), size: 20),
        ),
      );
}
