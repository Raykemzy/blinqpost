import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppImageLoader extends StatefulWidget {
  final String url;
  final BoxFit fit;
  final double? width, height;
  final BorderRadius? radius;
  final Widget? errorWidget;
  const AppImageLoader({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.radius,
    this.errorWidget,
  });

  @override
  State<AppImageLoader> createState() => _AppImageLoaderState();
}

class _AppImageLoaderState extends State<AppImageLoader> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.radius ?? const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Image(
          image: FastCachedImageProvider(widget.url),
          fit: widget.fit,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Center(
              child: SizedBox(
                width: 30.w,
                height: 30.h,
                child: const CupertinoActivityIndicator(),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Center(
            child: widget.errorWidget ?? const Text("Unable to load media"),
          ),
        ),
      ),
    );
  }
}
