import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/app_input.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:better_breaks/ui/widgets/app_calendar.dart';

class BookingDetailsView extends StatefulWidget {
  final String eventTitle;
  final String location;
  final String date;
  final double price;
  final int quantity;

  const BookingDetailsView({
    super.key,
    required this.eventTitle,
    required this.location,
    required this.date,
    required this.price,
    required this.quantity,
  });

  @override
  State<BookingDetailsView> createState() => _BookingDetailsViewState();
}

class _BookingDetailsViewState extends State<BookingDetailsView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with empty controller for name and email, current date for date field
    _nameController.text = '';
    _emailController.text = '';
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEventSummary(),
                  SizedBox(height: 24.h),
                  _buildPersonalDetailsSection(),
                  SizedBox(height: 24.h),
                  AppButton(
                    text: 'Make Payment',
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Payment processed for ${widget.eventTitle}!'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: MediaQuery.of(context).padding.top,
        bottom: 0,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            AppBackButton(
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
              size: 18.r,
            ),

            SizedBox(height: 8.h),

            // Title
            Text(
              'Booking details',
              style: AppTextStyle.raleway(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventSummary() {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.eventTitle,
            style: AppTextStyle.raleway(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.lightBlack,
            ),
          ),
          SizedBox(height: 16.h),

          // Location
          Row(
            children: [
              AppIcons(
                icon: AppIconData.location01,
                size: 16.r,
                color: AppColors.grey800,
              ),
              SizedBox(width: 8.w),
              Text(
                widget.location,
                style: AppTextStyle.satoshi(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey800,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Date
          Row(
            children: [
              AppIcons(
                icon: AppIconData.calendar01,
                size: 16.r,
                color: AppColors.grey800,
              ),
              SizedBox(width: 8.w),
              Text(
                widget.date,
                style: AppTextStyle.satoshi(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey800,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Divider - transparent as per screenshot
          Container(
            height: 1,
            color: Colors.transparent,
          ),

          SizedBox(height: 16.h),

          // Total amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyle.raleway(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightBlack,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${(widget.price * widget.quantity).toStringAsFixed(0)}',
                    style: AppTextStyle.interVariable(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  Text(
                    '${widget.quantity} tickets',
                    style: AppTextStyle.satoshi(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.grey800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal details',
          style: AppTextStyle.raleway(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Kindly fill in the details below',
          style: AppTextStyle.satoshi(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.grey800,
          ),
        ),
        SizedBox(height: 16.h),

        // Personal details form in GlassyContainer
        GlassyContainer(
          backgroundColor: Colors.white,
          borderColor: Colors.white,
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name input
              _buildInputLabel('Name'),
              SizedBox(height: 8.h),
              AppInput(
                hintText: 'Enter your name',
                controller: _nameController,
                fillColor: Colors.white,
              ),
              SizedBox(height: 16.h),

              // Email input
              _buildInputLabel('Email Address'),
              SizedBox(height: 8.h),
              AppInput(
                hintText: 'Enter your email',
                controller: _emailController,
                fillColor: Colors.white,
              ),
              SizedBox(height: 16.h),

              // Date input
              _buildInputLabel('Date'),
              SizedBox(height: 8.h),
              AppInput(
                hintText: 'DD/MM/YYYY',
                controller: _dateController,
                icon: AppIconData.calendar,
                iconColor: AppColors.primary,
                readOnly: true,
                fillColor: Colors.white,
                onTap: _showAppCalendar,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: AppTextStyle.satoshi(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.lightBlack,
      ),
    );
  }

  void _showAppCalendar() {
    // Parse the current date from the date controller
    DateTime currentDate;
    try {
      currentDate = DateFormat('dd/MM/yyyy').parse(_dateController.text);
    } catch (e) {
      currentDate = DateTime.now();
    }

    // Show the AppCalendar directly as a dialog without additional wrapping
    showDialog(
      context: context,
      builder: (context) => AppCalendar(
        selectedDate: currentDate,
        onDateSelected: (date) {
          setState(() {
            _dateController.text = DateFormat('dd/MM/yyyy').format(date);
          });
          Navigator.pop(context);
        },
      ),
    );
  }
}
