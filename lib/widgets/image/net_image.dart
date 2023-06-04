import 'package:flutter/material.dart';

class NetImage extends StatelessWidget {
  const NetImage({
    super.key,
    required this.url,
    this.headers,
    this.boxFit = BoxFit.fill,
    this.loadingWidget,
    this.errorWidget,
  });

  /// 图片网络地址
  final String url;

  /// 请求头
  final Map<String, String>? headers;

  /// 图片裁剪方式
  final BoxFit? boxFit;

  /// 加载中展示widget
  final Widget? loadingWidget;

  /// 加载失败展示widg
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      headers: headers,
      fit: boxFit,
      loadingBuilder: (context, child, loadingProgress) {
        return loadingWidget ??
            Container(
              color: Colors.grey.shade300,
            );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              color: Colors.grey.shade300,
            );
      },
    );
  }
}
