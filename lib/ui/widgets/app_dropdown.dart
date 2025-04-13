import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/ui/widgets/app_input.dart';
import 'package:better_breaks/ui/widgets/app_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:better_breaks/ui/widgets/app_calendar.dart';

class AppDropdown extends StatefulWidget {
  final String hintText;
  final String? selectedValue;
  final List<String> options;
  final Function(String) onOptionSelected;
  final Function(List<String>)? onDaysSelected;
  final Function(Map<String, dynamic>)? onShiftPatternSelected;
  final TextEditingController? controller;
  final bool showDaysOfWeek;
  final List<String>? initialSelectedDays;
  final Map<String, dynamic>? initialShiftPattern;

  const AppDropdown({
    super.key,
    required this.hintText,
    this.selectedValue,
    required this.options,
    required this.onOptionSelected,
    this.onDaysSelected,
    this.onShiftPatternSelected,
    this.controller,
    this.showDaysOfWeek = false,
    this.initialSelectedDays,
    this.initialShiftPattern,
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

  // Shift pattern properties
  final TextEditingController _daysOnController =
      TextEditingController(text: "3 days");
  final TextEditingController _daysOffController =
      TextEditingController(text: "5 days");
  final TextEditingController _startDateController = TextEditingController();
  String _selectedRotation = "2-weeks rotation";
  String? _rotationPatternDropdownValue;
  bool _showRotationOptions = false;
  final List<String> _rotationOptions = [
    "1 week rotation",
    "2 weeks rotation",
    "3 weeks rotation"
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.selectedValue);
    _selectedDays = widget.initialSelectedDays ?? ['Mon', 'Tues', 'Wed'];

    // Initialize shift pattern
    if (widget.initialShiftPattern != null) {
      _daysOnController.text =
          widget.initialShiftPattern!['daysOn'] ?? "3 days";
      _daysOffController.text =
          widget.initialShiftPattern!['daysOff'] ?? "5 days";
      _startDateController.text = widget.initialShiftPattern!['startDate'] ??
          DateFormat('dd/MM/yyyy').format(DateTime.now());
      _selectedRotation = widget.initialShiftPattern!['rotation'] ?? "";
    } else {
      _startDateController.text =
          DateFormat('dd/MM/yyyy').format(DateTime.now());
      // Default to empty string unless shift pattern is already selected
      _selectedRotation =
          widget.selectedValue == 'Shift pattern' ? "2-weeks rotation" : "";
    }
  }

  @override
  void didUpdateWidget(AppDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedValue != widget.selectedValue) {
      _controller.text = widget.selectedValue ?? '';

      // When switching to shift pattern, set default rotation if none selected
      if (widget.selectedValue == 'Shift pattern' &&
          _selectedRotation.isEmpty) {
        setState(() {
          _selectedRotation = "2-weeks rotation";
          _updateShiftPattern();
        });
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _daysOnController.dispose();
    _daysOffController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      _showDropdownOptions = !_showDropdownOptions;
    });
  }

  void _toggleRotationDropdown() {
    setState(() {
      _showRotationOptions = !_showRotationOptions;
    });
  }

  void _updateShiftPattern() {
    if (widget.onShiftPatternSelected != null) {
      widget.onShiftPatternSelected!({
        'daysOn': _daysOnController.text,
        'daysOff': _daysOffController.text,
        'startDate': _startDateController.text,
        'rotation': _selectedRotation,
      });
    }
  }

  // Update the shift pattern start date and call the callback
  void _showStartDatePicker(BuildContext context) {
    DateTime initialDate;
    try {
      initialDate = DateFormat('dd/MM/yyyy').parse(_startDateController.text);
    } catch (e) {
      initialDate = DateTime.now();
    }

    showDialog(
      context: context,
      builder: (context) => AppCalendar(
        selectedDate: initialDate,
        onDateSelected: (date) {
          setState(() {
            _startDateController.text = DateFormat('dd/MM/yyyy').format(date);
            _updateShiftPattern();
          });
          Navigator.pop(context);
        },
      ),
    );
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

  Widget _buildDayButton(String day, BuildContext context) {
    final isSelected = _selectedDays.contains(day);
    final buttonWidth = _getButtonWidth(context);

    return GestureDetector(
      onTap: () => _toggleDay(day),
      child: Container(
        width: buttonWidth,
        height: 45.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white.withOpacity(0.5),
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

  Widget _buildShiftPatternSelector() {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Days On/Off section
          Row(
            children: [
              // Days On
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Days On",
                      style: AppTextStyle.satoshi(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AppInput(
                      controller: _daysOnController,
                      hintText: "Enter days",
                      fillColor: Colors.white.withOpacity(0.7),
                      onTap: () {
                        // Show a number picker if needed
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              // Days Off
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Days Off",
                      style: AppTextStyle.satoshi(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AppInput(
                      controller: _daysOffController,
                      hintText: "Enter days",
                      fillColor: Colors.white.withOpacity(0.7),
                      onTap: () {
                        // Show a number picker if needed
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Start date section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Start date",
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              AppInput(
                controller: _startDateController,
                hintText: "DD/MM/YYYY",
                fillColor: Colors.white.withOpacity(0.7),
                icon: AppIconData.calendar,
                iconColor: AppColors.primary,
                readOnly: true,
                onTap: () => _showStartDatePicker(context),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Rotation Pattern section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rotation Pattern",
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),

              // Dropdown input that shows the current selection or placeholder
              GestureDetector(
                onTap: _toggleRotationDropdown,
                child: AppInput(
                  controller: TextEditingController(
                      text: _selectedRotation.isEmpty ? "" : _selectedRotation),
                  hintText: "Select rotation pattern",
                  fillColor: Colors.white.withOpacity(0.7),
                  isDropdown: true,
                  readOnly: true,
                ),
              ),

              // Only show dropdown options when toggled
              if (_showRotationOptions) ...[
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
                    children: _rotationOptions.map((option) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRotation = option;
                            _showRotationOptions = false;
                            _updateShiftPattern();
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          child: AppRadioButton(
                            text: option,
                            isSelected: _selectedRotation == option,
                            onTap: () {
                              setState(() {
                                _selectedRotation = option;
                                _showRotationOptions = false;
                                _updateShiftPattern();
                              });
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatternPreview() {
    // Get the number of days ON and OFF from the controllers
    int daysOn =
        int.tryParse(_daysOnController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
            3;
    int daysOff = int.tryParse(
            _daysOffController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
        5;
    int totalCycleDays = daysOn + daysOff;

    // Determine number of weeks to show based on rotation pattern
    int weeksToShow = 1;
    if (_selectedRotation.contains('2')) {
      weeksToShow = 2;
    } else if (_selectedRotation.contains('3')) {
      weeksToShow = 3;
    }

    // Calculate total days to show - we'll display 7 days per row to match screenshot
    int daysPerRow = 7;

    // Build rows of day indicators with horizontal scrolling
    List<Widget> rows = [];
    for (int rowIndex = 0; rowIndex < weeksToShow; rowIndex++) {
      List<Widget> rowItems = [];

      // Create days for this row - ensuring we display the right pattern
      for (int dayIndex = 0; dayIndex < daysPerRow; dayIndex++) {
        int cycleDayIndex = (rowIndex * daysPerRow + dayIndex) % totalCycleDays;
        bool isOn = cycleDayIndex < daysOn;

        rowItems.add(
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: _buildDayIndicator(isOn),
          ),
        );
      }

      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: rowItems,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget _buildDayIndicator(bool isOn) {
    return Container(
      width: 45.r,
      height: 45.r,
      decoration: BoxDecoration(
        color: isOn ? AppColors.primary : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Text(
          isOn ? "ON" : "OFF",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isOn ? Colors.white : Colors.grey,
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

        // Show shift pattern selector if shift pattern is selected
        if (widget.selectedValue == 'Shift pattern') ...[
          // Add top divider for shift pattern
          SizedBox(height: 16.h),
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          _buildShiftPatternSelector(),

          // Pattern Preview section - only show when rotation is selected and shift pattern is active
          if (_selectedRotation.isNotEmpty) ...[
            SizedBox(height: 24.h),
            Text(
              "Pattern preview",
              style: AppTextStyle.satoshi(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            _buildPatternPreview(),
          ],
        ],
      ],
    );
  }
}
