import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/shared/app_colors.dart';
import 'dart:math' as math;

class Confetti extends StatefulWidget {
  final int duration;
  final int confettiCount;
  final List<Color>? colors;
  final bool active;

  const Confetti({
    super.key,
    this.duration = 30000,
    this.confettiCount = 150, // More confetti for better effect
    this.colors,
    this.active = true,
  });

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti>
    with SingleTickerProviderStateMixin {
  // Animation controller for continuous animation
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  // Confetti pieces data
  late final List<ConfettiPiece> _confettiPieces = [];
  final _random = math.Random();

  @override
  void initState() {
    super.initState();

    // Generate confetti pieces data
    _generateConfetti();

    // Create animation controller for continuous looping animation
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    // Start animation immediately as soon as widget is initialized
    if (widget.active) {
      _animationController.forward();

      // After the duration time, slow down and stop the animation
      Future.delayed(Duration(milliseconds: widget.duration), () {
        if (mounted) {
          _animationController.fling(velocity: -0.3); // Slow down
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted) {
              _animationController.stop();
            }
          });
        }
      });
    }
  }

  void _generateConfetti() {
    final colors = widget.colors ??
        [
          AppColors.primary,
          AppColors.lightGreen,
          AppColors.orange,
          AppColors.lightPurple,
          Colors.pink.shade300,
          Colors.yellow.shade300,
          Colors.cyanAccent,
        ];

    for (int i = 0; i < widget.confettiCount; i++) {
      // Random starting positions across the top of the screen with some variation
      final startX = _random.nextDouble() * 1.sw;

      // Start positions already distributed within the visible screen
      // This makes confetti visible immediately
      final startY = _random.nextDouble() * 0.7.sh -
          0.6.sh; // From -70% screen height to top of screen

      // Random angles for different falling patterns
      final angle =
          _random.nextDouble() * 0.3 - 0.15; // Between -0.15 and 0.15 radians

      // Much faster falling speed for immediate visible effect
      final speed =
          0.6 + _random.nextDouble() * 0.6; // Between 0.6 and 1.2 (normalized)

      // Smaller confetti with variance in size
      final size = (3 + _random.nextDouble() * 5).r; // Between 3 and 8

      // Random rotation speed
      final rotationSpeed =
          (_random.nextDouble() * 0.15) * (_random.nextBool() ? 1 : -1);

      // No delay for initial pieces to ensure immediate visibility
      // Only add minimal delay for some pieces to create a staggered effect
      final delay =
          i < widget.confettiCount / 3 ? 0 : _random.nextDouble() * 0.2;

      // Random shape (circle, rectangle, or small rectangle)
      final shapeType = _random.nextInt(3);

      // Random color
      final color = colors[_random.nextInt(colors.length)];

      // Random opacity
      final opacity = 0.6 +
          _random.nextDouble() *
              0.4; // Between 0.6 and 1.0 for better visibility

      _confettiPieces.add(
        ConfettiPiece(
          startX: startX,
          startY: startY,
          angle: angle,
          speed: speed,
          size: size,
          rotationSpeed: rotationSpeed,
          delay: delay.toDouble(),
          shapeType: shapeType,
          color: color,
          opacity: opacity,
        ),
      );
    }
  }

  @override
  void didUpdateWidget(Confetti oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.active != oldWidget.active) {
      if (widget.active) {
        _animationController.forward();
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: ConfettiPainter(
            _confettiPieces,
            _animation.value,
            MediaQuery.of(context).size,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

// Class to represent a single confetti piece
class ConfettiPiece {
  final double startX;
  final double startY;
  final double angle;
  final double speed;
  final double size;
  final double rotationSpeed;
  final double delay;
  final int shapeType; // 0: circle, 1: square, 2: rectangle
  final Color color;
  final double opacity;

  ConfettiPiece({
    required this.startX,
    required this.startY,
    required this.angle,
    required this.speed,
    required this.size,
    required this.rotationSpeed,
    required this.delay,
    required this.shapeType,
    required this.color,
    required this.opacity,
  });
}

// Custom painter to draw all confetti
class ConfettiPainter extends CustomPainter {
  final List<ConfettiPiece> confetti;
  final double animationValue;
  final Size screenSize;

  ConfettiPainter(this.confetti, this.animationValue, this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    for (var piece in confetti) {
      // Calculate current position based on animation value, piece speed, and delay
      double adjustedAnimationValue =
          (animationValue - piece.delay).clamp(0.0, 1.0);
      if (adjustedAnimationValue <= 0) continue; // Skip if not started yet

      // Calculate position with some horizontal drift based on angle
      double x = piece.startX +
          (piece.angle * screenSize.height * adjustedAnimationValue * 0.5);
      double y = piece.startY +
          (screenSize.height * adjustedAnimationValue * piece.speed);

      // If piece has fallen below screen, wrap to top with new x position for continuous effect
      if (y > screenSize.height) {
        double wrappedAnimValue = (adjustedAnimationValue % 1.0);
        y = piece.startY + (screenSize.height * wrappedAnimValue * piece.speed);
        // Slightly different position on re-entry for variety
        x = piece.startX * (0.8 + (adjustedAnimationValue * 0.4)) +
            (piece.angle * screenSize.height * wrappedAnimValue * 0.5);
      }

      // Calculate rotation based on rotation speed
      double rotation =
          adjustedAnimationValue * piece.rotationSpeed * 10; // More rotation

      // Create paint for the confetti
      final paint = Paint()
        ..color = piece.color.withOpacity(piece.opacity)
        ..style = PaintingStyle.fill;

      // Save canvas state before rotation
      canvas.save();

      // Move to confetti position and rotate
      canvas.translate(x, y);
      canvas.rotate(rotation);

      // Draw shape based on shape type
      switch (piece.shapeType) {
        case 0: // Circle
          canvas.drawCircle(Offset.zero, piece.size / 2, paint);
          break;
        case 1: // Square
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset.zero,
              width: piece.size,
              height: piece.size,
            ),
            paint,
          );
          break;
        case 2: // Rectangle
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset.zero,
              width: piece.size * 0.5,
              height: piece.size * 1.5,
            ),
            paint,
          );
          break;
      }

      // Restore canvas to original state
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

// Immediate visibility improvements:
// Increased the number of confetti pieces from 100 to 150 for a more dramatic effect
// Positioned confetti pieces throughout the visible screen at startup (from -70% screen height to top)
// Removed delay for the first third of confetti pieces so they appear instantly
// Speed enhancements:
// Doubled the falling speed (from 0.3-0.7 to 0.6-1.2 range)
// This makes the confetti drop much faster and more noticeable right away
// Visual improvements:
// Increased rotation speed by 50% for more dynamic movement
// Increased the minimum opacity from 0.4 to 0.6 for better visibility
// Staggered effect:
// Kept a minimal delay (up to 0.2 seconds) for some pieces to maintain a natural staggered falling effect
// The first third of pieces have zero delay to ensure immediate visibility
// These changes will make the confetti:
// Appear immediately when the success screen loads (no waiting)
// Fall much faster and more visibly
// Create a more dynamic and engaging celebration effect
