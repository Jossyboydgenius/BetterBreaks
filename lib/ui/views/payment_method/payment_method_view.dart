import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';

class PaymentMethodView extends StatelessWidget {
  final String eventTitle;
  final int quantity;
  final double totalAmount;

  const PaymentMethodView({
    super.key,
    required this.eventTitle,
    required this.quantity,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final double fee = 5.0; // Standard fee for the order
    final double orderTotal = totalAmount + fee;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildTopBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPaymentMethodsSection(context),
                  SizedBox(height: 24.h),
                  _buildOrderSummarySection(
                      quantity, totalAmount, fee, orderTotal),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
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
              'Select a payment method',
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

  Widget _buildPaymentMethodsSection(BuildContext context) {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildPaymentMethodItem(
            context,
            icon: AppIconData.creditCard,
            title: 'Debit/Credit Card',
            isFirst: true,
          ),
          _buildDivider(),
          _buildPaymentMethodItem(
            context,
            icon: AppIconData.googlePay,
            title: 'Google pay',
          ),
          _buildDivider(),
          _buildPaymentMethodItem(
            context,
            icon: AppIconData.applePay,
            title: 'Apple pay',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodItem(
    BuildContext context, {
    required String icon,
    required String title,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () {
        // Process payment and show confirmation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment processed via $title for $eventTitle!'),
            backgroundColor: AppColors.primary,
          ),
        );
        // Navigate back to the home screen
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            // Payment method icon
            AppIcons(
              icon: icon,
              size: 24.r,
              color: AppColors.lightBlack,
            ),
            SizedBox(width: 16.w),

            // Payment method title
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.satoshi(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack,
                ),
              ),
            ),

            // Right arrow
            AppIcons(
              icon: AppIconData.rightArrow,
              size: 20.r,
              color: AppColors.grey800,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColors.grey200,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
    );
  }

  Widget _buildOrderSummarySection(
    int quantity,
    double amount,
    double fee,
    double total,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order summary',
          style: AppTextStyle.raleway(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 16.h),
        GlassyContainer(
          backgroundColor: Colors.white,
          borderColor: Colors.white,
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              _buildSummaryItem(
                'Total tickets',
                '\$${amount.toStringAsFixed(0)}',
                subtitle: '$quantity tickets',
              ),
              SizedBox(height: 16.h),
              _buildSummaryItem('Fee & Tax', '\$${fee.toStringAsFixed(0)}'),
              SizedBox(height: 16.h),
              _buildSummaryItem(
                'Total',
                '\$${total.toStringAsFixed(0)}',
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value, {
    String? subtitle,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.satoshi(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: AppColors.lightBlack,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: AppTextStyle.satoshi(
                fontSize: isTotal ? 20.sp : 16.sp,
                fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
                color: AppColors.lightBlack,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: AppTextStyle.satoshi(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey800,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
