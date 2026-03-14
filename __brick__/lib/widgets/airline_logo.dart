import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class AirlineLogoWithBorder extends StatelessWidget {
  const AirlineLogoWithBorder(
    this.imageUrl, {
    super.key,
    this.size = 28,
    this.isActive = true,
    this.fit,
    this.borderColor,
    this.backgroundColor,
  });

  /// [al] value from [FlightItemModel]
  final String? imageUrl;
  final double size;
  final bool isActive;
  final BoxFit? fit;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: .circular(4),
        border: .all(color: borderColor ?? AppColors.borderColor1, width: 1),
      ),
      width: 40,
      height: 40,
      child: AirlineLogo(imageUrl, fit: fit, isActive: isActive, size: size),
    );
  }
}

class AirlineLogo extends StatelessWidget {
  const AirlineLogo(this.imageUrl, {super.key, this.size = 28, this.isActive, this.fit});

  /// [al] value from [FlightItemModel]
  final String? imageUrl;
  final double size;
  final bool? isActive;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) return const NetworkImageError();
    return SizedBox();
    // return CachedNetworkImage(
    //   imageUrl: '${(photoApiBaseUrl ?? appConfig.airlineLogoUrl)}$imageUrl',
    //   width: size,
    //   color: (isActive ?? false) == false ? Colors.white38 : null,
    //   progressIndicatorBuilder: (context, url, progress) => Center(
    //     child: Padding(
    //       padding: const .all(6),
    //       child: AspectRatio(aspectRatio: 1, child: CircularProgressIndicator(value: progress.progress)),
    //     ),
    //   ),
    //   errorWidget: (context, url, error) => const NetworkImageError(),
    //   fit: fit ?? BoxFit.contain,
    // );
  }
}

class NetworkImageError extends StatelessWidget {
  const NetworkImageError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.image_not_supported_outlined);
  }
}
