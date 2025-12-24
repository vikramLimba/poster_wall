import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final double borderRadius;
  final double blurSigma;
  final EdgeInsets padding;
  final Gradient? gradient;
  final Color? borderColor;
  final double borderWidth;
  final BoxShadow? boxShadow;
  final bool clip;

  const GlassContainer({
    super.key,
    this.width,
    this.height,
    this.child,
    this.borderRadius = 28.0,
    this.blurSigma = 8.0,
    this.padding = const EdgeInsets.all(0.0),
    this.gradient,
    this.borderColor = Colors.white,
    this.borderWidth = 0.5,
    this.boxShadow,
    this.clip = true,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      gradient:
          gradient ??
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: .12),
              Colors.white.withValues(alpha: 0.06),
            ],
          ),
      borderRadius: BorderRadius.circular(borderRadius),
      border: borderColor != null
          ? Border.all(
              color: borderColor!.withValues(alpha: 0.3),
              width: borderWidth,
            )
          : null,
      boxShadow: boxShadow != null ? [boxShadow!] : null,
    );

    final container = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: decoration,
      child: child,
    );

    final clipped = clip
        ? ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: container,
          )
        : container;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Material(type: MaterialType.transparency, child: clipped),
      ),
    );
  }
}
