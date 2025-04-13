import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/ui/widgets/app_input.dart';
import 'package:better_breaks/ui/widgets/app_radio_button.dart';

class AppDropdown extends StatefulWidget {
  final String hintText;
  final String? selectedValue;
  final List<String> options;
  final Function(String) onOptionSelected;
  final Function(List<String>)? onDaysSelected;
  final TextEditingController? controller;
  final bool showDaysOfWeek;
  final List<String>? initialSelectedDays;

  const AppDropdown({
    super.key,
    required this.hintText,
    this.selectedValue,
    required this.options,
    required this.onOptionSelected,
    this.onDaysSelected,
    this.controller,
    this.showDaysOfWeek = false,
    this.initialSelectedDays,
  });

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  bool _showDropdownOptions = false;
  late TextEditingController _controller;
  final List<String> daysOfWeek = [
    'Mon',
    'Tues',
    'Wed',
    'Thur',
    'Fri',
    'Sat',
    'Sun'
  ];
  late List<String> _selectedDays;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.selectedValue);
    _selectedDays = widget.initialSelectedDays ?? ['Mon', 'Tues', 'Wed'];
  }

  @override
  void didUpdateWidget(AppDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedValue != widget.selectedValue) {
      _controller.text = widget.selectedValue ?? '';
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      _showDropdownOptions = !_showDropdownOptions;
    });
  }

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }

      if (widget.onDaysSelected != null) {
        widget.onDaysSelected!(_selectedDays);
      }
    });
  }

  Widget _buildDropdownItem(String text) {
    return InkWell(
      onTap: () {
        widget.onOptionSelected(text);
        setState(() {
          _controller.text = text;
          _showDropdownOptions = false;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: AppRadioButton(
          text: text,
          isSelected: widget.selectedValue == text,
          onTap: () {
            widget.onOptionSelected(text);
            setState(() {
              _controller.text = text;
              _showDropdownOptions = false;
            });
          },
        ),
      ),
    );
  }

  Widget _buildDaysOfWeekSelector() {
    // Group days by rows to match the second screenshot
    final firstRow = daysOfWeek.sublist(0, 3); // Mon, Tues, Wed
    final secondRow = daysOfWeek.sublist(3, 6); // Thur, Fri, Sat
    final thirdRow = daysOfWeek.sublist(6, 7); // Sun

    return Builder(builder: (context) {
      return Container(
        margin: EdgeInsets.only(top: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First row: Mon, Tues, Wed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < firstRow.length; i++)
                  _buildDayButton(firstRow[i], context),
              ],
            ),

            SizedBox(height: 12.h),

            // Second row: Thur, Fri, Sat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < secondRow.length; i++)
                  _buildDayButton(secondRow[i], context),
              ],
            ),

            SizedBox(height: 12.h),

            // Third row: Sun (single button)
            Row(
              children: [
                _buildDayButton(thirdRow[0], context),
              ],
            ),
          ],
        ),
      );
    });
  }

  // Calculate the optimal button width based on screen width
  double _getButtonWidth(BuildContext context) {
    // Calculate available width (screen width minus padding)
    final screenWidth = MediaQuery.of(context).size.width;

    // Account for the screen padding and container padding
    final horizontalPadding =
        96.w; // 24.w from screen + 24.w from container padding on each side
    final availableWidth = screenWidth - horizontalPadding;

    // For 3 buttons in a row with spacing between them
    final spacing = 8.w * 2; // Total spacing between 3 buttons
    final buttonWidth = (availableWidth - spacing) / 3;

    return buttonWidth;
  }

  Widget _buildDayButton(String day, BuildContext context) {
    final isSelected = _selectedDays.contains(day);
    final buttonWidth = _getButtonWidth(context);

    return GestureDetector(
      onTap: () => _toggleDay(day),
      child: Container(
        width: buttonWidth,
        height: 45.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: AppInput(
            hintText: widget.hintText,
            isDropdown: true,
            readOnly: true,
            controller: _controller,
            fillColor: Colors.white.withOpacity(0.7),
          ),
        ),
        if (_showDropdownOptions) ...[
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: widget.options
                  .map((option) => _buildDropdownItem(option))
                  .toList(),
            ),
          ),
        ],

        // Show days of week selector if custom pattern is selected
        if (widget.selectedValue == 'Custom pattern')
          _buildDaysOfWeekSelector(),
      ],
    );
  }
}
