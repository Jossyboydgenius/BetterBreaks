import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/app_input.dart';
import 'package:intl/intl.dart';

class FilterEventsBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>)? onApplyFilter;

  const FilterEventsBottomSheet({
    super.key,
    this.onApplyFilter,
  });

  @override
  State<FilterEventsBottomSheet> createState() =>
      _FilterEventsBottomSheetState();
}

class _FilterEventsBottomSheetState extends State<FilterEventsBottomSheet> {
  final _locationController = TextEditingController();
  final List<String> _categories = [
    'All',
    'Sports',
    'Music',
    'Movies',
    'Health'
  ];
  int _selectedCategoryIndex = 0;

  final _dateFormat = DateFormat('dd/MM/yyyy');
  String _dateRange = ''; // Format: "startDate - endDate"
  DateTime? _startDate;
  DateTime? _endDate;

  // Price range
  RangeValues _priceRange = const RangeValues(20, 1000);
  final double _minPrice = 0;
  final double _maxPrice = 1000;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _selectDateRange() async {
    final initialDateRange = DateTimeRange(
      start: _startDate ?? DateTime.now(),
      end: _endDate ?? DateTime.now().add(const Duration(days: 7)),
    );

    final newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.lightBlack,
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDateRange != null) {
      setState(() {
        _startDate = newDateRange.start;
        _endDate = newDateRange.end;
        _dateRange =
            '${_dateFormat.format(_startDate!)} - ${_dateFormat.format(_endDate!)}';
      });
    }
  }

  void _applyFilter() {
    if (widget.onApplyFilter != null) {
      final filterData = {
        'location': _locationController.text,
        'category': _categories[_selectedCategoryIndex],
        'startDate': _startDate,
        'endDate': _endDate,
        'minPrice': _priceRange.start,
        'maxPrice': _priceRange.end,
      };
      widget.onApplyFilter!(filterData);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with draggable indicator and close button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // This space ensures the close button is right-aligned
                SizedBox(width: 24.w),
                // Draggable indicator
                Container(
                  width: 60.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(2.5.r),
                  ),
                ),
                // Close button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppIcons(
                    icon: AppIconData.close,
                    size: 36.r,
                  ),
                ),
              ],
            ),
          ),

          // Filter events title
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Filter events',
                style: AppTextStyle.raleway(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightBlack,
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location
                  Text(
                    'Location',
                    style: AppTextStyle.satoshi(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  AppInput(
                    controller: _locationController,
                    hintText: 'Enter location',
                    icon: AppIconData.location01,
                  ),
                  SizedBox(height: 24.h),

                  // Categories
                  Text(
                    'Categories',
                    style: AppTextStyle.satoshi(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildCategoryTabs(),
                  SizedBox(height: 24.h),

                  // Date Range
                  Text(
                    'Date Range',
                    style: AppTextStyle.satoshi(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: _selectDateRange,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey200),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _dateRange.isEmpty
                                  ? 'Select date range'
                                  : _dateRange,
                              style: AppTextStyle.satoshi(
                                fontSize: 16.sp,
                                color: _dateRange.isEmpty
                                    ? AppColors.grey600
                                    : AppColors.lightBlack,
                              ),
                            ),
                          ),
                          AppIcons(
                            icon: AppIconData.calendar,
                            size: 20.r,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Price Range
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price',
                        style: AppTextStyle.satoshi(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlack,
                        ),
                      ),
                      Text(
                        '\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
                        style: AppTextStyle.satoshi(
                          fontSize: 14.sp,
                          color: AppColors.grey800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  _buildPriceRangeSlider(),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${_minPrice.toInt()}',
                        style: AppTextStyle.satoshi(
                          fontSize: 14.sp,
                          color: AppColors.grey700,
                        ),
                      ),
                      Text(
                        '\$${_maxPrice.toInt()}',
                        style: AppTextStyle.satoshi(
                          fontSize: 14.sp,
                          color: AppColors.grey700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // Apply filter button
                  AppButton(
                    text: 'Apply filter',
                    backgroundColor: AppColors.primary,
                    onPressed: _applyFilter,
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                gradient: isSelected ? AppColors.filterGradient : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? Colors.transparent : AppColors.grey200,
                ),
              ),
              child: Center(
                child: Text(
                  _categories[index],
                  style: AppTextStyle.satoshi(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.lightBlack,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceRangeSlider() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: RangeSlider(
        values: _priceRange,
        min: _minPrice,
        max: _maxPrice,
        divisions: 20,
        activeColor: AppColors.primary,
        inactiveColor: AppColors.grey200,
        labels: RangeLabels(
            '\$${_priceRange.start.toInt()}', '\$${_priceRange.end.toInt()}'),
        onChanged: (RangeValues values) {
          setState(() {
            _priceRange = values;
          });
        },
      ),
    );
  }
}
