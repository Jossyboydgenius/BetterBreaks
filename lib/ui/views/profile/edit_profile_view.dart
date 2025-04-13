import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_icons.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';
import 'package:better_breaks/ui/widgets/glassy_container.dart';
import 'package:better_breaks/ui/widgets/app_input.dart';

class EditProfileView extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialLocation;
  final String initialBreakBalance;
  final VoidCallback? onSave;

  const EditProfileView({
    super.key,
    this.initialName = '',
    this.initialEmail = '',
    this.initialLocation = '',
    this.initialBreakBalance = '',
    this.onSave,
  });

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _locationController;
  late TextEditingController _breakBalanceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _locationController = TextEditingController(text: widget.initialLocation);
    _breakBalanceController =
        TextEditingController(text: widget.initialBreakBalance);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _breakBalanceController.dispose();
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
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassyContainer(
                    backgroundColor: Colors.white,
                    borderColor: Colors.white,
                    padding: EdgeInsets.all(24.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name field
                        _buildInputField(
                          label: 'Name',
                          controller: _nameController,
                          placeholder: 'Full name',
                        ),

                        SizedBox(height: 24.h),

                        // Email Address field
                        _buildInputField(
                          label: 'Email Address',
                          controller: _emailController,
                          placeholder: 'Your email address',
                        ),

                        SizedBox(height: 24.h),

                        // Location field
                        _buildInputField(
                          label: 'Location',
                          controller: _locationController,
                          placeholder: 'Your location',
                        ),

                        // Change location link
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              // Handle change location
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Text(
                                'Change location',
                                style: AppTextStyle.satoshi(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Break Balance field
                        _buildInputField(
                          label: 'Break Balance',
                          controller: _breakBalanceController,
                          placeholder: 'Available days',
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Save button (outside of the glassy container)
                  AppButton(
                    text: 'Save',
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      // Save the profile
                      widget.onSave?.call();
                      Navigator.pop(context);
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
            'Profile',
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: AppTextStyle.satoshi(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 8.h),

        // App Input field
        AppInput(
          controller: controller,
          hintText: placeholder,
          fillColor: Colors.white.withOpacity(0.7),
        ),
      ],
    );
  }
}
