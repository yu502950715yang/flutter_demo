import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetImage extends StatelessWidget {
  const NetImage({
    super.key,
    required this.url,
    this.headers,
    this.boxFit = BoxFit.fill,
    this.placeholder,
    this.errorWidget,
  });

  /// 图片网络地址
  final String url;

  /// 请求头
  final Map<String, String>? headers;

  /// 图片裁剪方式
  final BoxFit? boxFit;

  /// 默认展示widget
  final Widget? placeholder;

  /// 加载失败展示widg
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      httpHeaders: headers,
      fit: boxFit,
      placeholder: (context, url) {
        return placeholder ??
            Container(
              color: Colors.grey.shade300,
            );
      },
      errorWidget: (context, url, error) {
        return errorWidget ??
            Container(
              color: Colors.grey.shade300,
              child: Image.asset('assets/images/img_loading_failed.png'),
            );
      },
    );
  }
}
