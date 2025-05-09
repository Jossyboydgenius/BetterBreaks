import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/views/booking_details/booking_details_view.dart';

class EventDetailsView extends StatefulWidget {
  final String image;
  final String title;
  final String location;
  final String date;
  final String price;
  final String? description;

  const EventDetailsView({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.date,
    required this.price,
    this.description,
  });

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  int _quantity = 1;
  late double _unitPrice;
  late double _totalPrice;

  @override
  void initState() {
    super.initState();
    // Extract numeric price value from string (e.g. '$25' → 25)
    _unitPrice = double.parse(widget.price.replaceAll(RegExp(r'[^0-9.]'), ''));
    _totalPrice = _unitPrice * _quantity;
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
      _totalPrice = _unitPrice * _quantity;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        _totalPrice = _unitPrice * _quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leadingWidth: 40.w,
        toolbarHeight: 40.h,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w, top: 12.h),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, size: 32.r),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            AppImages(
              imagePath: widget.image,
              width: double.infinity,
              height: 300.h,
              fit: BoxFit.cover,
            ),
            // Event Details Container
            Padding(
              padding: EdgeInsets.all(24.w),
              child: GlassyContainer(
                padding: EdgeInsets.all(24.r),
                backgroundColor: Colors.white,
                borderColor: Colors.white,
                blurSigmaX: 10,
                blurSigmaY: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.title,
                      style: AppTextStyle.raleway(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Location and Price in a Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Location
                        Expanded(
                          child: Row(
                            children: [
                              AppIcons(
                                icon: AppIconData.location01,
                                size: 20.r,
                                color: AppColors.grey800,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  widget.location,
                                  style: AppTextStyle.satoshi(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Price Label
                        Text(
                          'Price',
                          style: AppTextStyle.satoshi(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey800,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    // Date and Price Value in a Row
                    Row(
                      children: [
                        // Date
                        Expanded(
                          child: Row(
                            children: [
                              AppIcons(
                                icon: AppIconData.calendar01,
                                size: 20.r,
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
                        ),

                        // Price Value
                        Text(
                          widget.price,
                          style: AppTextStyle.interVariable(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightBlack,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Divider
                    Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    SizedBox(height: 16.h),

                    // About section
                    Text(
                      'About the event',
                      style: AppTextStyle.raleway(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      widget.description ??
                          'Lorem ipsum dolor sit amet consectetur. Neque semper ultrices tempor facilisi viverra. Tellus congue id lacinia leo rutrum tellus. Quis quis eget volutpat sapien faucibus quam lacus in fermentum.',
                      style: AppTextStyle.satoshi(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey800,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Location section
                    Text(
                      'Location',
                      style: AppTextStyle.raleway(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        AppIcons(
                          icon: AppIconData.location01,
                          size: 20.r,
                          color: AppColors.grey800,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            widget.location,
                            style: AppTextStyle.satoshi(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey800,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Divider
                    Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    SizedBox(height: 24.h),

                    // Booking section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: AppTextStyle.satoshi(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey800,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${_totalPrice.toStringAsFixed(0)}',
                              style: AppTextStyle.interVariable(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightBlack,
                              ),
                            ),
                            // Quantity selector
                            Container(
                              height: 44.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22.r),
                                border: Border.all(
                                  color: AppColors.grey200,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Minus button
                                  InkWell(
                                    onTap: _decreaseQuantity,
                                    child: Container(
                                      width: 44.w,
                                      height: 44.h,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.grey,
                                        size: 24.r,
                                      ),
                                    ),
                                  ),

                                  // Vertical divider
                                  Container(
                                    width: 1,
                                    height: 24.h,
                                    color: AppColors.grey200,
                                  ),

                                  // Quantity
                                  Container(
                                    width: 44.w,
                                    alignment: Alignment.center,
                                    child: Text(
                                      _quantity.toString(),
                                      style: AppTextStyle.satoshi(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  // Vertical divider
                                  Container(
                                    width: 1,
                                    height: 24.h,
                                    color: AppColors.grey200,
                                  ),

                                  // Plus button
                                  InkWell(
                                    onTap: _increaseQuantity,
                                    child: Container(
                                      width: 44.w,
                                      height: 44.h,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.grey,
                                        size: 24.r,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Book Now button
                    AppButton(
                      text: 'Book Now',
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingDetailsView(
                              eventTitle: widget.title,
                              location: widget.location,
                              date: widget.date,
                              price: _unitPrice,
                              quantity: _quantity,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
