import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/gradient_box_border.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime) onDateSelected;
  final Function(DateTime, DateTime?) onRangeSelected;

  const CalendarWidget({
    Key? key,
    this.startDate,
    this.endDate,
    required this.onDateSelected,
    required this.onRangeSelected,
  }) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _currentMonth;
  late DateTime? _startDate;
  late DateTime? _endDate;
  
  // Page controller for month swipe
  late PageController _pageController;
  
  // Keep track of the page index to manage the infinitely scrolling PageView
  int _currentPageIndex = 1000; // Start with an arbitrary large number

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startDate != oldWidget.startDate) {
      _startDate = widget.startDate;
    }
    if (widget.endDate != oldWidget.endDate) {
      _endDate = widget.endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
        border: const GradientBoxBorder(
          gradient: AppColors.calendarBorderGradient,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          _buildCalendarHeader(),
          SizedBox(height: 16.h),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => _showMonthPickerDialog(),
              child: Text(
                _getMonthName(_currentMonth.month),
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => _showYearPickerDialog(),
              child: Text(
                _currentMonth.year.toString(),
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            AppIcons(
              icon: AppIconData.leftArrow,
              onPressed: _previousMonth,
              size: 18.r,
              color: AppColors.lightBlack,
            ),
            SizedBox(width: 20.w),
            AppIcons(
              icon: AppIconData.rightArrow,
              onPressed: _nextMonth,
              size: 18.r,
              color: AppColors.lightBlack,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    return Column(
      children: [
        _buildWeekdayHeader(),
        SizedBox(height: 16.h),
        Container(
          height: 240.h, // Adjusted height
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _handlePageChange,
            itemBuilder: (context, index) {
              // Calculate the month offset relative to the current month
              final monthOffset = index - _currentPageIndex;
              final targetMonth = DateTime(
                _currentMonth.year,
                _currentMonth.month + monthOffset,
              );
              return _buildMonthGrid(targetMonth);
            },
          ),
        ),
      ],
    );
  }
  
  void _handlePageChange(int page) {
    if (page != _currentPageIndex) {
      final monthDiff = page - _currentPageIndex;
      final newMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + monthDiff,
      );
      
      setState(() {
        _currentMonth = newMonth;
        _currentPageIndex = page;
      });
    }
  }

  Widget _buildWeekdayHeader() {
    final weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays.map((day) {
        final isWeekend = day == 'S';
        return SizedBox(
          width: 32.w,
          child: Text(
            day,
            style: AppTextStyle.raleway(
              fontSize: 14.sp,
              color: isWeekend ? AppColors.orange300 : AppColors.lightBlack,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMonthGrid(DateTime month) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.w,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final dayOffset = index - (firstWeekday - 1);
        final day = dayOffset + 1;
        
        if (dayOffset < 0 || day > daysInMonth) {
          return const SizedBox();
        }

        final date = DateTime(month.year, month.month, day);
        final isStartDate = _startDate?.year == date.year && 
                           _startDate?.month == date.month && 
                           _startDate?.day == date.day;
        final isEndDate = _endDate?.year == date.year && 
                          _endDate?.month == date.month && 
                          _endDate?.day == date.day;
        final isInRange = _isDateInRange(date);
        final isWeekend = date.weekday == 6 || date.weekday == 7;
        final isPastDate = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

        return TweenAnimationBuilder(
          tween: ColorTween(
            begin: Colors.transparent,
            end: isStartDate || isEndDate 
                ? AppColors.orange100
                : isInRange 
                    ? AppColors.orange200
                    : Colors.transparent,
          ),
          duration: const Duration(milliseconds: 300),
          builder: (context, Color? color, child) {
            return GestureDetector(
              onTap: isPastDate ? null : () => _onDateSelected(date),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Center(
                  child: Text(
                    day.toString(),
                    style: AppTextStyle.satoshi(
                      fontSize: 14.sp,
                      color: isPastDate
                          ? AppColors.grey
                          : (isStartDate || isEndDate)
                              ? Colors.white
                              : isWeekend
                                  ? AppColors.orange300
                                  : AppColors.lightBlack,
                      fontWeight: (isStartDate || isEndDate) ? FontWeight.w400 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool _isDateInRange(DateTime date) {
    if (_startDate == null || _endDate == null) return false;
    return date.isAfter(_startDate!) && date.isBefore(_endDate!);
  }

  void _onDateSelected(DateTime date) {
    if (_startDate == null || _endDate != null) {
      // Start new selection
      _startDate = date;
      _endDate = null;
      widget.onDateSelected(date);
    } else {
      // Complete the range
      if (date.isBefore(_startDate!)) {
        _endDate = _startDate;
        _startDate = date;
      } else {
        _endDate = date;
      }
      widget.onRangeSelected(_startDate!, _endDate);
    }
  }

  void _previousMonth() {
    // Animate to the previous page
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextMonth() {
    // Animate to the next page
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  void _showMonthPickerDialog() {
    final currentYear = _currentMonth.year;
    final PageController pageController = PageController(initialPage: 1000); // Large initial page for "infinite" scrolling
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
        child: StatefulBuilder(
          builder: (context, setDialogState) {
            // Track current display year separately
            int displayYear = currentYear;
            
            // Calculate responsive height based on design spec (approximately 3 rows of months)
            double gridHeight = MediaQuery.of(context).size.height * 0.16;
            // Ensure height stays within reasonable bounds
            gridHeight = gridHeight.clamp(110.0, 140.0);
            
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 12.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        displayYear.toString(),
                        style: AppTextStyle.satoshi(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightBlack,
                        ),
                      ),
                      Row(
                        children: [
                          AppIcons(
                            icon: AppIconData.leftArrow,
                            onPressed: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            size: 18.r,
                            color: AppColors.lightBlack,
                          ),
                          SizedBox(width: 20.w),
                          AppIcons(
                            icon: AppIconData.rightArrow,
                            onPressed: () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            size: 18.r,
                            color: AppColors.lightBlack,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: gridHeight,
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (page) {
                        setDialogState(() {
                          displayYear = currentYear + (page - 1000);
                        });
                      },
                      itemBuilder: (context, pageIndex) {
                        final year = currentYear + (pageIndex - 1000);
                        
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 8.h,
                            crossAxisSpacing: 8.w,
                            childAspectRatio: 2.0,
                          ),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            final month = index + 1;
                            final isSelected = month == _currentMonth.month && year == _currentMonth.year;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentMonth = DateTime(year, month);
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.orange200 : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Text(
                                    _getMonthAbbreviation(month),
                                    style: AppTextStyle.satoshi(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightBlack,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showYearPickerDialog() {
    final int baseYear = DateTime.now().year;
    final PageController pageController = PageController(initialPage: 1000);
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
        child: StatefulBuilder(
          builder: (context, setDialogState) {
            // Local state for the current page's year range
            int rangeOffset = 0;
            int startYear = baseYear - 5 + (rangeOffset * 12);
            int endYear = baseYear + 6 + (rangeOffset * 12);
            
            // Calculate responsive height based on design spec (approximately 3 rows of years)
            double gridHeight = MediaQuery.of(context).size.height * 0.16;
            // Ensure height stays within reasonable bounds
            gridHeight = gridHeight.clamp(110.0, 130.0);
            
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 12.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${startYear} - ${endYear}",
                        style: AppTextStyle.satoshi(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightBlack,
                        ),
                      ),
                      Row(
                        children: [
                          AppIcons(
                            icon: AppIconData.leftArrow,
                            onPressed: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            size: 18.r,
                            color: AppColors.lightBlack,
                          ),
                          SizedBox(width: 20.w),
                          AppIcons(
                            icon: AppIconData.rightArrow,
                            onPressed: () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            size: 18.r,
                            color: AppColors.lightBlack,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: gridHeight,
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (page) {
                        setDialogState(() {
                          rangeOffset = page - 1000;
                          startYear = baseYear - 5 + (rangeOffset * 12);
                          endYear = baseYear + 6 + (rangeOffset * 12);
                        });
                      },
                      itemBuilder: (context, pageIndex) {
                        final pageOffset = pageIndex - 1000;
                        final pageStartYear = baseYear - 5 + (pageOffset * 12);
                        final List<int> years = List.generate(12, (index) => pageStartYear + index);
                        
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 8.h,
                            crossAxisSpacing: 8.w,
                            childAspectRatio: 2.0,
                          ),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            final year = years[index];
                            final isSelected = year == _currentMonth.year;
                            
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentMonth = DateTime(year, _currentMonth.month);
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.orange200 : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Text(
                                    year.toString(),
                                    style: AppTextStyle.satoshi(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightBlack,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
  