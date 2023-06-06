import 'dart:io';

import 'package:flutter/material.dart';

/// 去除安卓中滚动视图上下拉的水波纹
class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    }
    return super.buildOverscrollIndicator(context, child, details);
  }
}
