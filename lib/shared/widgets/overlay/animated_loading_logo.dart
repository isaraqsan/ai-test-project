import 'package:flutter/material.dart';
import 'package:gibas/core/app/color_palette.dart';

class AnimatedLoadingIcon extends StatefulWidget {
  final double size;
  final Color trackColor;
  final Color progressColor;
  final Color? backgroundColor;
  final IconData icon;

  const AnimatedLoadingIcon({
    super.key,
    this.size = 100,
    this.trackColor = Colors.grey,
    this.progressColor = ColorPalette.primary,
    this.backgroundColor,
    this.icon = Icons.auto_awesome_outlined, 
  });

  @override
  State<AnimatedLoadingIcon> createState() => _AnimatedLoadingIconState();
}

class _AnimatedLoadingIconState extends State<AnimatedLoadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            
            Container(
              width: widget.size * 0.9,
              height: widget.size * 0.9,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
            
            Icon(
              widget.icon,
              size: widget.size * 0.5,
              color: widget.progressColor,
            ),
            
            RotationTransition(
              turns: _controller,
              child: CustomPaint(
                painter: _CircleProgressPainter(
                  progress: 0.65, 
                  trackColor: widget.trackColor,
                  progressColor: widget.progressColor,
                  strokeWidth: 3,
                ),
                size: Size(widget.size, widget.size),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  _CircleProgressPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.1416 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1416 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.progressColor != progressColor ||
      oldDelegate.strokeWidth != strokeWidth;
}
