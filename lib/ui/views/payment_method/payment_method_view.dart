import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_back_button.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:better_breaks/ui/views/payment_method/widgets/saved_card.dart';
import 'package:better_breaks/ui/views/payment_method/widgets/add_card.dart';
import 'package:better_breaks/ui/views/payment_method/widgets/card_form.dart';

class PaymentMethodView extends StatefulWidget {
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
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  // View states
  bool _showCreditCardDetails = false;
  bool _showAddCardForm = false;

  // Card data
  final List<Map<String, String>> _savedCards = [
    {
      'cardNumber': '5642987654321234',
      'cardHolderName': 'Adam Gregory',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double fee = 5.0; // Standard fee for the order
    final double orderTotal = widget.totalAmount + fee;

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
                  if (_showCreditCardDetails) ...[
                    // Credit Card section header
                    Text(
                      'Credit card',
                      style: AppTextStyle.raleway(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Credit card form or saved cards list
                    if (_showAddCardForm) ...[
                      // Form to add a new card
                      CardForm(
                        onSave: _saveNewCard,
                      ),
                    ] else ...[
                      // Show saved cards individually
                      ..._savedCards.map((card) => SavedCard(
                            cardNumber: card['cardNumber']!,
                            cardHolderName: card['cardHolderName']!,
                            onTap: () => _processPayment('Credit Card'),
                          )),

                      // Add new card button
                      AddCard(
                        onTap: () {
                          setState(() {
                            _showAddCardForm = true;
                          });
                        },
                      ),
                    ],
                  ] else ...[
                    // Payment methods selection
                    _buildPaymentMethodsSection(context),
                  ],

                  SizedBox(height: 24.h),

                  // Always show order summary
                  _buildOrderSummarySection(
                      widget.quantity, widget.totalAmount, fee, orderTotal),
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
              onPressed: () {
                if (_showAddCardForm) {
                  setState(() {
                    _showAddCardForm = false;
                  });
                } else if (_showCreditCardDetails) {
                  setState(() {
                    _showCreditCardDetails = false;
                  });
                } else {
                  Navigator.pop(context);
                }
              },
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
            onTap: () {
              setState(() {
                _showCreditCardDetails = true;
              });
            },
          ),
          _buildDivider(),
          _buildPaymentMethodItem(
            context,
            icon: AppIconData.googlePay,
            title: 'Google pay',
            onTap: () => _processPayment('Google Pay'),
          ),
          _buildDivider(),
          _buildPaymentMethodItem(
            context,
            icon: AppIconData.applePay,
            title: 'Apple pay',
            isLast: true,
            onTap: () => _processPayment('Apple Pay'),
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
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            // Payment method icon
            AppIcons(
              icon: icon,
              size: title.contains('Google') || title.contains('Apple')
                  ? 42.r
                  : 24.r,
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
              size: 16.r,
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
                fontSize: isTotal ? 18.sp : 16.sp,
                fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
                color: AppColors.lightBlack,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: AppTextStyle.satoshi(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey800,
                ),
              ),
          ],
        ),
      ],
    );
  }

  void _saveNewCard(
      String name, String cardNumber, String cvv, String expiryDate) {
    setState(() {
      // Add the new card to saved cards
      _savedCards.add({
        'cardNumber': cardNumber.replaceAll(' ', ''),
        'cardHolderName': name,
      });

      // Return to saved cards view
      _showAddCardForm = false;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Card added successfully!'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _processPayment(String paymentMethod) {
    // Show payment confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Payment processed via $paymentMethod for ${widget.eventTitle}!'),
        backgroundColor: AppColors.primary,
      ),
    );

    // Return to home screen
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
