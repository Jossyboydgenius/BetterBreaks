import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_theme_colors.dart';
import 'package:better_breaks/ui/widgets/app_badge.dart';
import 'package:better_breaks/ui/widgets/weather_forecast_card.dart';
import 'package:better_breaks/ui/widgets/expanded_weather_forecast.dart';
import 'package:better_breaks/ui/widgets/event_card.dart';
import 'package:intl/intl.dart';
import 'package:better_breaks/ui/widgets/summary_bottom_sheet.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';

class PlannerBottomSheet extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  final List<String> holidays;
  final VoidCallback? onComplete;
  final VoidCallback? onBack;

  const PlannerBottomSheet({
    super.key,
    this.startDate,
    this.endDate,
    this.description,
    this.holidays = const [],
    this.onComplete,
    this.onBack,
  });

  @override
  State<PlannerBottomSheet> createState() => _PlannerBottomSheetState();
}

class _PlannerBottomSheetState extends State<PlannerBottomSheet>
    with SingleTickerProviderStateMixin {
  final _dateFormat = DateFormat('dd/MM/yyyy');
  final DraggableScrollableController _dragController =
      DraggableScrollableController();

  // Animation controller for weather expand/collapse
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  bool _isExpanded = false;
  bool _showSummary = false;
  DateTime? _startDate;
  DateTime? _endDate;
  final PageController _pageController = PageController();
  int _currentEventIndex = 0;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate;
    _endDate = widget.endDate;

    // Setup animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _dragController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _onAccept() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SummaryBottomSheet(
        startDate: _startDate,
        endDate: _endDate,
        onStartDateChanged: (date) {
          setState(() => _startDate = date);
        },
        onEndDateChanged: (date) {
          setState(() => _endDate = date);
        },
        onConfirm: () {
          Navigator.pop(context);
          if (widget.onComplete != null) {
            Navigator.pop(context);
          }
        },
        onComplete: widget.onComplete ?? () {},
        totalBreakDays: 12,
        selectedDays: 5,
        remainingDays: 7,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6, // 60% of screen height
      minChildSize: 0.4, // Minimum 40% of screen height
      maxChildSize: 0.9, // Maximum 90% of screen height
      snap: true,
      snapSizes: const [0.4, 0.6, 0.9],
      controller: _dragController,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppThemeColors.getCardBackgroundColor(context),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Draggable indicator
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  // Calculate new size based on drag
                  final newSize = _dragController.size -
                      (details.delta.dy / MediaQuery.of(context).size.height);
                  // Clamp to min/max bounds
                  final clampedSize = newSize.clamp(0.4, 0.9);
                  // Update controller
                  if (_dragController.size != clampedSize &&
                      clampedSize >= 0.4 &&
                      clampedSize <= 0.9) {
                    _dragController.jumpTo(clampedSize);
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    width: 120.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: AppThemeColors.getDragHandleColor(context),
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Forecast container
                      PlannerForecastContainer(
                        startDate: widget.startDate,
                        endDate: widget.endDate,
                        description: widget.description,
                        holidays: widget.holidays,
                        isExpanded: _isExpanded,
                        expandAnimation: _expandAnimation,
                        onExpand: _toggleExpanded,
                        onCollapse: _toggleExpanded,
                      ),

                      SizedBox(height: 24.h),

                      // Experience section
                      ExperienceSection(),

                      SizedBox(height: 24.h),

                      // Confirm & Back buttons
                      _buildButtons(),

                      // Add bottom padding to avoid buttons being hidden by the bottom nav
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: AppTextStyle.raleway(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 240.h,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentEventIndex = index;
              });
            },
            children: [
              EventCard(
                image: AppImageData.image,
                title: 'Beach Yoga festival',
                location: 'Gelora Bung Karno Stadium..',
                date: 'November 15 2023',
                price: '\$60',
              ),
              EventCard(
                image: AppImageData.image1,
                title: 'Beach Yoga festival',
                location: 'Gelora Bung Karno Stadium..',
                date: 'November 15 2023',
                price: '\$60',
              ),
              EventCard(
                image: AppImageData.image2,
                title: 'Beach Yoga festival',
                location: 'Gelora Bung Karno Stadium..',
                date: 'November 15 2023',
                price: '\$60',
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Center(
          child: AppDotsIndicator(
            dotsCount: 3,
            position: _currentEventIndex,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Confirm Selection button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onComplete,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Text(
              'Confirm Selection',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // Back button
        if (widget.onBack != null) ...[
          SizedBox(height: 12.h),
          Center(
            child: TextButton(
              onPressed: widget.onBack,
              child: Text(
                'Back',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlack,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class DraggableIndicator extends StatelessWidget {
  const DraggableIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.h),
        width: 120.w,
        height: 5.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.r),
        ),
      ),
    );
  }
}

class PlannerForecastContainer extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  final List<String> holidays;
  final bool isExpanded;
  final Animation<double> expandAnimation;
  final VoidCallback onExpand;
  final VoidCallback onCollapse;

  const PlannerForecastContainer({
    super.key,
    this.startDate,
    this.endDate,
    this.description,
    this.holidays = const [],
    required this.isExpanded,
    required this.expandAnimation,
    required this.onExpand,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      blurSigmaX: 10,
      blurSigmaY: 10,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlannerDateRangeSection(
            startDate: startDate,
            endDate: endDate,
            description: description,
            holidays: holidays,
          ),
          Divider(color: Colors.white.withOpacity(0.5), height: 1.h),
          WeatherForecastSection(
            isExpanded: isExpanded,
            expandAnimation: expandAnimation,
            onExpand: onExpand,
            onCollapse: onCollapse,
          ),
        ],
      ),
    );
  }
}

class PlannerDateRangeSection extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  final List<String> holidays;

  const PlannerDateRangeSection({
    super.key,
    this.startDate,
    this.endDate,
    this.description,
    this.holidays = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (startDate != null && endDate != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_formatDate(startDate!)}-${_formatDate(endDate!)}',
                  style: AppTextStyle.raleway(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightBlack,
                  ),
                ),
                const AppBadge(
                  text: 'High Impact',
                  backgroundColor: AppColors.bgRed100,
                  textColor: AppColors.red100,
                ),
              ],
            ),
            if (description != null) ...[
              SizedBox(height: 8.h),
              Text(
                description!,
                style: AppTextStyle.satoshi(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlack,
                ),
              ),
            ],
            if (holidays.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: holidays
                    .map((holiday) => AppBadge.holiday(text: holiday))
                    .toList(),
              ),
            ],
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}

class WeatherForecastSection extends StatelessWidget {
  final bool isExpanded;
  final Animation<double> expandAnimation;
  final VoidCallback onExpand;
  final VoidCallback onCollapse;

  const WeatherForecastSection({
    super.key,
    required this.isExpanded,
    required this.expandAnimation,
    required this.onExpand,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: AnimatedBuilder(
        animation: expandAnimation,
        builder: (context, child) {
          return AnimatedCrossFade(
            firstChild: _buildCollapsedView(),
            secondChild: ExpandedWeatherForecast(onCollapse: onCollapse),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            layoutBuilder:
                (topChild, topChildKey, bottomChild, bottomChildKey) {
              return Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    key: bottomChildKey,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: bottomChild,
                  ),
                  Positioned(
                    key: topChildKey,
                    child: topChild,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCollapsedView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '10 Days Weather Forecast',
          style: AppTextStyle.satoshi(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              WeatherForecastCard(
                day: 'Wed',
                date: 11,
                weatherType: 'sunny',
                temperature: '49°',
              ),
              SizedBox(width: 12.w),
              WeatherForecastCard(
                day: 'Sun',
                date: 12,
                weatherType: 'cloudy',
                temperature: '49°',
              ),
              SizedBox(width: 12.w),
              WeatherForecastCard(
                day: 'Mon',
                date: 13,
                weatherType: 'sunny',
                temperature: '49°',
              ),
              SizedBox(width: 12.w),
              WeatherForecastCard(
                day: 'Tues',
                date: 14,
                weatherType: 'sunny',
                temperature: '49°',
              ),
              SizedBox(width: 12.w),
              WeatherForecastCard(
                day: 'Tues',
                date: 15,
                weatherType: 'sunny',
                temperature: '49°',
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: onExpand,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Expand',
                  style: AppTextStyle.satoshi(
                    fontSize: 14.sp,
                    color: AppColors.lightBlack,
                  ),
                ),
                SizedBox(width: 4.w),
                AppIcons(
                  icon: AppIconData.expand,
                  size: 16.r,
                  color: AppColors.lightBlack,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  int _currentEventIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Experience',
            style: AppTextStyle.raleway(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlack,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 240.h,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentEventIndex = index;
              });
            },
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: EventCard(
                  image: AppImageData.image,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: EventCard(
                  image: AppImageData.image1,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: EventCard(
                  image: AppImageData.image2,
                  title: 'Beach Yoga festival',
                  location: 'Gelora Bung Karno Stadium..',
                  date: 'November 15 2023',
                  price: '\$60',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Center(
          child: AppDotsIndicator(
            dotsCount: 3,
            position: _currentEventIndex,
          ),
        ),
      ],
    );
  }
}

class PlannerActionButtons extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const PlannerActionButtons({
    super.key,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          text: 'Confirm Selection',
          backgroundColor: AppColors.primary,
          onPressed: onAccept,
        ),
        SizedBox(height: 12.h),
        AppButton(
          text: 'Decline',
          backgroundColor: Colors.white,
          textColor: AppColors.lightBlack,
          onPressed: onDecline,
        ),
      ],
    );
  }
}
