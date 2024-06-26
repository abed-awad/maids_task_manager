import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/helpers/icon_path.dart';
import 'package:task_manager/widgets/loading.dart';

class CustomCachedNetworkWidget extends StatelessWidget {
  final String link;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CustomCachedNetworkWidget({
    super.key,
    required this.link,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return link.isEmpty
        ? const SizedBox()
        : CachedNetworkImage(
            imageUrl: link,
            fit: fit ?? BoxFit.cover,
            width: width,
            height: height,
            placeholder: (context, url) => const LoadingWidget(),
            errorWidget: (context, error, _) =>
                SvgPicture.asset(IconsPathHelper.error),
          );
  }
}
