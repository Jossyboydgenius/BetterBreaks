import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'package:better_breaks/shared/app_textstyle.dart';
import 'package:better_breaks/shared/app_images.dart';
import 'package:better_breaks/shared/widgets/shared_widgets.dart';
import 'package:better_breaks/ui/widgets/app_buttons.dart';

class MoodCheckIn extends StatefulWidget {
  final Function(double)? onMoodSelected;
  
  const MoodCheckIn({
    super.key, 
    this.onMoodSelected,
  });

  @override
  State<MoodCheckIn> createState() => _MoodCheckInState();
}

class _MoodCheckInState extends State<MoodCheckIn> {
  double _moodValue = 2; // Initial mood (expressionless)

  List<Widget> _buildMoodEmojis() {
    final List<String> emojiPaths = [
      AppImageData.sadPensiveFace,
      AppImageData.smilingFaceWithTear,
      AppImageData.expressionlessFace,
      AppImageData.relievedFace,
      AppImageData.grinningFace,
    ];

    return List.generate(
      emojiPaths.length,
      (index) {
        final isSelected = index == _moodValue.toInt();
        final size = isSelected ? 64.r : 36.r;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _moodValue = index.toDouble();
              if (widget.onMoodSelected != null) {
                widget.onMoodSelected!(_moodValue);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: size,
            height: size,
            child: AppImages(
              imagePath: emojiPaths[index],
              width: size,
              height: size,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mood check-in',
          style: AppTextStyle.satoshi(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.lightBlack,
          ),
        ),
        SizedBox(height: 16.h),
        GlassyContainer(
          backgroundColor: Colors.white,
          borderColor: Colors.white,
          padding: EdgeInsets.all(24.r),
          child: Column(
            children: [
              Text(
                'How\'s Life Treating You?',
                style: AppTextStyle.raleway(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightBlack,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              
              // Mood emojis with slider
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildMoodEmojis(),
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Slider
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 8.h,
                  activeTrackColor: AppColors.orange100,
                  inactiveTrackColor: AppColors.orange200,
                  thumbShape: RoundedRectangleThumbShape(
                    enabledThumbRadius: 14.r,
                  ),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                ),
                child: Slider(
                  min: 0,
                  max: 4,
                  divisions: 4,
                  value: _moodValue,
                  onChanged: (value) {
                    setState(() {
                      _moodValue = value;
                      if (widget.onMoodSelected != null) {
                        widget.onMoodSelected!(value);
                      }
                    });
                  },
                ),
              ),
              
              SizedBox(height: 24.h),
              
              AppButton(
                text: 'Done!',
                backgroundColor: AppColors.primary,
                onPressed: () {
                  // Save mood check-in
                  if (widget.onMoodSelected != null) {
                    widget.onMoodSelected!(_moodValue);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RoundedRectangleThumbShape extends SliderComponentShape {
  final double enabledThumbRadius;

  const RoundedRectangleThumbShape({
    required this.enabledThumbRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw shadow
    canvas.drawShadow(
      Path()..addOval(Rect.fromCircle(center: center, radius: enabledThumbRadius)),
      Colors.black.withOpacity(0.9),
      2,
      true,
    );

    // Draw thumb
    canvas.drawCircle(center, enabledThumbRadius, fillPaint);
    canvas.drawCircle(center, enabledThumbRadius, borderPaint);
  }
} 