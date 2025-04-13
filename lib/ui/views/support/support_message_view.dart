import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';

class SupportMessageView extends StatefulWidget {
  const SupportMessageView({super.key});

  @override
  State<SupportMessageView> createState() => _SupportMessageViewState();
}

class _SupportMessageViewState extends State<SupportMessageView> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar
          _buildTopBar(context),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message input container
                  Expanded(
                    child: _buildMessageInput(),
                  ),

                  SizedBox(height: 24.h),

                  // Send button
                  AppButton(
                    text: 'Send',
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      // Handle sending message
                      if (_messageController.text.isNotEmpty) {
                        // Here you would send the message to your backend
                        // For now, we'll just go back to the previous screen
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Message sent successfully'),
                            backgroundColor: AppColors.green,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
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
        left: 24.w,
        right: 24.w,
        top: MediaQuery.of(context).padding.top + 16.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AppIcons(
              icon: AppIconData.back,
              size: 16.r,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          // Title
          Text(
            'Send us a message',
            style: AppTextStyle.raleway(
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return GlassyContainer(
      backgroundColor: Colors.white,
      borderColor: Colors.white,
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Message icon and label
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppIcons(
                    icon: AppIconData.message,
                    size: 22.r,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'What would you like to tell us?',
                style: AppTextStyle.raleway(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightBlack,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Text field for message input
          Expanded(
            child: TextField(
              controller: _messageController,
              maxLines: null, // Allow multiple lines
              expands: true, // Expand to fill available space
              decoration: InputDecoration(
                hintText: 'Type something ....',
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: AppColors.grey600,
                  fontFamily: 'Satoshi',
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTextStyle.satoshi(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.lightBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
