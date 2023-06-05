import 'dart:async';

import 'package:flutter/material.dart';

class CupertinoTabBar extends StatefulWidget {
  /// tabbar背景颜色
  final Color backgroundColor;

  /// 移动选择栏的颜色
  final Color foregroundColor;

  /// tabs
  final List<Widget> widgets;

  /// 获取当前索引function
  final Function valueGetter;

  /// 点击回调
  /// int 当前索引值
  final Function(int) onTap;

  /// 为true时在tab中间添加分割线
  final bool useSeparators;

  /// true显示阴影
  final bool useShadow;

  /// 每两个tab中间的间距
  final double innerHorizontalPadding;

  /// 每个tab垂直上下间距
  final double innerVerticalPadding;

  final BorderRadius borderRadius;

  /// tab切换动画的曲线
  final Curve curve;

  /// 动画持续时间
  final Duration duration;

  ///如果您希望此[CupertinoTabBar]展开以填充可用间隙，请将此值设置为true。不要将[allowExpand]和[allowScrollable]都设置为true。
  final bool allowExpand;

  ///如果您想允许此[CupertinoTabBar]滚动，请将此值设置为true。不要将[allowExpand]和[allowScrollable]都设置为true。
  final bool allowScrollable;

  ///如果您希望此[CupertinoTabBar]的大小受到限制，即使[allowScrollable]设置为true，也要将此值设置为true。
  final bool fittedWhenScrollable;

  ///如果您希望此[CupertinoTabBar]提醒用户它可以与动画一起滚动，请将此值设置为true。
  final bool animateWhenScrollable;

  ///如果您希望此[CupertinoTabBar]继续提醒用户它可以通过动画滚动，直到用户滚动为止，请将此值设置为true。
  final bool animateUntilScrolled;

  ///如果[allowScrollable]设置为true，则将在此[CupertinoTabBar]的左侧和右侧显示的间隙。
  final double outerHorizontalPadding;

  ///如果[allowScrollable]设置为true，则将在此[CupertinoTabBar]的顶部和底部显示的间隙。
  final double outerVerticalPadding;

  const CupertinoTabBar({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.widgets,
    required this.valueGetter,
    required this.onTap,
    this.useSeparators = false,
    this.useShadow = true,
    this.innerHorizontalPadding = 10.0,
    this.innerVerticalPadding = 10.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.curve = Curves.linearToEaseOut,
    this.duration = const Duration(milliseconds: 350),
    this.allowExpand = false,
    this.allowScrollable = false,
    this.fittedWhenScrollable = false,
    this.animateWhenScrollable = true,
    this.animateUntilScrolled = true,
    this.outerHorizontalPadding = 10.0,
    this.outerVerticalPadding = 0.0,
  });

  @override
  State<CupertinoTabBar> createState() => _CupertinoTabBarState();
}

class _CupertinoTabBarState extends State<CupertinoTabBar>
    with SingleTickerProviderStateMixin {
  late List<GlobalKey> _globalKeys;
  double? _maxWidth;
  double? _maxHeight;
  double? _fullWidth;
  double? _fullHeight;
  double? _preferredHeight;
  double? _preferredWidth;
  double? _usedHeight;
  double? _usedWidth;
  double? _singleHeight;
  late double _singleWidth;
  double? _outerContainerHeight;
  double? _outerContainerWidth;
  double? _innerContainerHeight;
  double? _innerContainerWidth;
  double? _separatorHeight;
  double? _separatorWidth;
  double? _indicatorHeight;
  double? _indicatorWidth;
  late bool _showSelf;

  ScrollController? _scrollController;
  late double _initialScrollOffset;
  late bool _userHasScrolled;

  AnimationController? _animationController;
  Timer? _animationTimer;
  late List<double> _tresholds;

  bool get _shouldBeExpanded => widget.allowExpand && !widget.allowScrollable;
  bool get _shouldBeScrollable =>
      !widget.allowExpand &&
      widget.allowScrollable &&
      _preferredWidth! > _fullWidth!;
  bool get _shouldBeFitted => widget.fittedWhenScrollable;
  bool get _shouldBeAnimated => widget.animateWhenScrollable;
  bool get _shouldCalculateFullDimensions =>
      widget.allowExpand || widget.allowScrollable;

  bool get _isScrollByUser =>
      _animationController == null || !_animationController!.isAnimating;
  bool get _shouldBeReanimated =>
      widget.animateUntilScrolled &&
      !_userHasScrolled &&
      _animationController!.isCompleted;

  bool get _shouldBeRescrolled => _scrollController!.offset != _offset;
  double get _offset {
    double scrollControllerOffset =
        _scrollController != null && _scrollController!.positions.isNotEmpty
            ? _scrollController!.offset
            : 0.0;
    double areaStartingPoint = scrollControllerOffset;
    double areaEndingPoint = areaStartingPoint + _fullWidth!;
    double tabStartingPoint = widget.outerHorizontalPadding / 2.0 +
        _singleWidth * widget.valueGetter();
    double tabEndingPoint =
        tabStartingPoint + _singleWidth + widget.outerHorizontalPadding / 2.0;
    double targetOffset = scrollControllerOffset;
    if (tabEndingPoint > areaEndingPoint - _singleWidth * 0.25) {
      targetOffset += (tabEndingPoint - areaEndingPoint) + _singleWidth * 1.25;
    } else if (tabStartingPoint < areaStartingPoint + _singleWidth * 0.25) {
      targetOffset -=
          (areaStartingPoint - tabStartingPoint) + _singleWidth * 1.25;
    }
    targetOffset = targetOffset.clamp(0.0,
        _preferredWidth! - _fullWidth! + widget.outerHorizontalPadding * 2);
    return targetOffset;
  }

  bool get _isRTL => Directionality.of(context) == TextDirection.rtl;
  Alignment get _alignment => Alignment(
      (_isRTL ? -1 : 1) *
          (-1.0 + widget.valueGetter() / (widget.widgets.length - 1) * 2),
      0.0);

  void _startAnimation() {
    _animationTimer = Timer(const Duration(seconds: 4),
        () => _animationController!.forward(from: 0.0));
  }

  void _stopAnimation() {
    _userHasScrolled = true;
    _animationController?.stop();
    _animationTimer?.cancel();
  }

  void _applyAnimation() {
    if (_animationController!.value < _tresholds[0]) {
      _scrollController!
          .jumpTo(_initialScrollOffset + _animationController!.value);
    } else if (_animationController!.value >= _tresholds[0] &&
        _animationController!.value < _tresholds[1]) {
      _scrollController!.jumpTo(_initialScrollOffset +
          _tresholds[0] -
          (_animationController!.value - _tresholds[0]));
    } else if (_animationController!.value >= _tresholds[1] &&
        _animationController!.value < _tresholds[2]) {
      _scrollController!.jumpTo(_initialScrollOffset -
          _tresholds[0] +
          (_animationController!.value - _tresholds[1]));
    } else if (_animationController!.value >= _tresholds[2] &&
        _animationController!.value < _animationController!.upperBound * 0.95) {
      _scrollController!.jumpTo(_initialScrollOffset +
          _tresholds[0] -
          (_animationController!.value - _tresholds[2]));
    } else {
      _scrollController!.jumpTo(_initialScrollOffset);
    }
  }

  void scrollControllerListener() {
    if (!_userHasScrolled && _isScrollByUser) {
      _stopAnimation();
    }
  }

  void animationListener() {
    setState(() {
      if (_animationController!.isAnimating) {
        _applyAnimation();
      }
      if (_shouldBeReanimated) {
        _startAnimation();
      }
    });
  }

  void onPostFrameCallback(Duration duration) {
    if (!_showSelf) {
      setState(() {
        _maxWidth = 0;
        _maxHeight = 0;
        for (int i = 0; i < widget.widgets.length; i++) {
          RenderBox renderBox =
              _globalKeys[i].currentContext!.findRenderObject() as RenderBox;
          if (renderBox.size.width > _maxWidth!) {
            _maxWidth = renderBox.size.width;
          }
          if (renderBox.size.height > _maxHeight!) {
            _maxHeight = renderBox.size.height;
          }
        }
        _maxWidth = _maxWidth! + widget.innerHorizontalPadding * 2.0;
        _maxHeight = _maxHeight! + widget.innerVerticalPadding * 2.0;

        if (_shouldCalculateFullDimensions) {
          RenderBox renderBox =
              _globalKeys.last.currentContext!.findRenderObject() as RenderBox;
          _fullWidth = renderBox.size.width > _maxWidth!
              ? renderBox.size.width
              : _maxWidth;
          _fullHeight = renderBox.size.height > _maxHeight!
              ? renderBox.size.height
              : _maxHeight;
        }

        _preferredHeight = _maxHeight;
        _preferredWidth = _maxWidth! * widget.widgets.length;

        _usedHeight = _preferredHeight;
        _usedWidth = _shouldBeExpanded ? _fullWidth : _preferredWidth;

        _singleHeight = _usedHeight;
        _singleWidth = _usedWidth! / widget.widgets.length;

        _outerContainerHeight = _fullHeight;
        _outerContainerWidth = _fullWidth;

        _innerContainerHeight = _preferredHeight;
        _innerContainerWidth = _preferredWidth;

        _separatorHeight = _maxHeight! / 2.0;
        _separatorWidth = 1.0;

        _indicatorHeight = _singleHeight;
        _indicatorWidth = _singleWidth - (widget.useSeparators ? 4.0 : 0.0);

        _showSelf = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _globalKeys = [];
    for (int i = 0; i < widget.widgets.length; i++) {
      _globalKeys.add(GlobalKey());
    }
    if (_shouldCalculateFullDimensions) {
      _globalKeys.add(GlobalKey());
    }
    _showSelf = false;
    WidgetsBinding.instance.addPostFrameCallback(onPostFrameCallback);
  }

  @override
  void dispose() {
    if (_scrollController != null) _scrollController!.dispose();
    if (_animationController != null) _animationController!.dispose();
    super.dispose();
  }

  void onTap(int index) {
    widget.onTap(index);
    if (_shouldBeScrollable && _shouldBeRescrolled) {
      _scrollController!.animateTo(_offset,
          duration: widget.duration, curve: Curves.decelerate);
    }
  }

  Widget _wrapByRegularOuterContainer(Widget child) {
    return _RegularOuterContainer(
      child,
      _outerContainerHeight,
      _outerContainerWidth,
    );
  }

  Widget _wrapByFittedOuterContainer(Widget child) {
    return _FittedOuterContainer(
      child,
      _outerContainerHeight,
      _outerContainerWidth,
      widget.outerHorizontalPadding,
      widget.outerVerticalPadding,
      widget.borderRadius,
    );
  }

  Widget _wrapByRegularMiddleContainer(Widget child) {
    return _RegularMiddleContainer(
      _scrollController,
      child,
      widget.outerHorizontalPadding,
      widget.outerVerticalPadding,
    );
  }

  Widget _wrapByFittedMiddleContainer(Widget child) {
    return _FittedMiddleContainer(
      _scrollController,
      child,
    );
  }

  Widget _wrapByRegularInnerContainer(Widget child) {
    return _RegularInnerContainer(
      child,
      _innerContainerHeight,
      _innerContainerWidth,
      widget.backgroundColor,
      widget.borderRadius,
    );
  }

  Widget _wrapByExpandedInnerContainer(Widget child) {
    return _ExpandedInnerContainer(
      child,
      _maxHeight,
      widget.backgroundColor,
      widget.borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_showSelf) {
      return Stack(
        children: List<Widget>.generate(
            _shouldCalculateFullDimensions
                ? widget.widgets.length + 1
                : widget.widgets.length, (int index) {
          if (index < widget.widgets.length) {
            return Container(
              key: _globalKeys[index],
              child: widget.widgets[index],
            );
          } else {
            return Container(
              key: _globalKeys[index],
              constraints: const BoxConstraints.expand(height: 1),
            );
          }
        }),
      );
    } else {
      Widget widget = Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          _Indicator(
            _alignment,
            this.widget.duration,
            this.widget.curve,
            _indicatorHeight,
            _indicatorWidth,
            this.widget.foregroundColor,
            this.widget.borderRadius,
            this.widget.useShadow,
          ),
          Row(
            children: List<Widget>.generate(
                this.widget.useSeparators
                    ? this.widget.widgets.length * 2 - 1
                    : this.widget.widgets.length, (int index) {
              if (!this.widget.useSeparators || index % 2 == 0) {
                int trueIndex =
                    !this.widget.useSeparators ? index : (index / 2.0).floor();
                return _Tab(
                  this.widget.widgets[trueIndex],
                  onTap,
                  trueIndex,
                );
              } else {
                return _Separator(
                  _separatorHeight,
                  _separatorWidth,
                  this.widget.foregroundColor,
                );
              }
            }),
          ),
        ],
      );

      if (_shouldBeScrollable) {
        if (_scrollController == null) {
          _scrollController = ScrollController(initialScrollOffset: _offset)
            ..addListener(scrollControllerListener);
          _initialScrollOffset = _offset;
          _userHasScrolled = false;
        }
        if (_shouldBeAnimated) {
          if (_animationController == null) {
            _animationController = AnimationController(
              vsync: this,
              lowerBound: 0.0,
              upperBound: _singleWidth * 2.0,
              duration: const Duration(milliseconds: 500),
            )..addListener(animationListener);
            _animationTimer = Timer(const Duration(seconds: 2),
                () => _animationController!.forward(from: 0.0));
            _tresholds = [
              _animationController!.upperBound / 6.0,
              _animationController!.upperBound / 6.0 * 3.0,
              _animationController!.upperBound / 6.0 * 5.0,
            ];
          }
        }
      }

      if (_shouldBeScrollable) {
        if (_shouldBeFitted) {
          return _wrapByFittedOuterContainer(
            _wrapByFittedMiddleContainer(
              _wrapByRegularInnerContainer(
                widget,
              ),
            ),
          );
        }
        return _wrapByRegularOuterContainer(
          _wrapByRegularMiddleContainer(
            _wrapByRegularInnerContainer(
              widget,
            ),
          ),
        );
      }
      if (_shouldBeExpanded) {
        return _wrapByExpandedInnerContainer(
          widget,
        );
      }
      return _wrapByRegularInnerContainer(
        widget,
      );
    }
  }
}

class _Separator extends StatelessWidget {
  final double? _height;
  final double? _width;
  final Color _color;

  const _Separator(
    this._height,
    this._width,
    this._color,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      color: _color,
    );
  }
}

class _Tab extends StatelessWidget {
  final Widget _child;
  final Function(int) _onTap;
  final int _index;

  const _Tab(
    this._child,
    this._onTap,
    this._index,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: _child,
        onTap: () => _onTap(_index),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final Alignment _alignment;
  final Duration _duration;
  final Curve _curve;
  final double? _height;
  final double? _width;
  final Color _color;
  final BorderRadius _borderRadius;
  final bool _useShadow;

  const _Indicator(
    this._alignment,
    this._duration,
    this._curve,
    this._height,
    this._width,
    this._color,
    this._borderRadius,
    this._useShadow,
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: _alignment,
      duration: _duration,
      curve: _curve,
      child: Padding(
        padding: _useShadow
            ? const EdgeInsets.only(
                left: 2.0, top: 2.0, right: 3.0, bottom: 4.0)
            : const EdgeInsets.all(2.0),
        child: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
            boxShadow: _useShadow
                ? [
                    const BoxShadow(
                      color: Color.fromARGB(170, 0, 0, 0),
                      offset: Offset(2.0, 4.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.5,
                    ),
                  ]
                : null,
          ),
        ),
      ),
    );
  }
}

class _ExpandedInnerContainer extends StatelessWidget {
  final Widget _child;
  final double? _maxHeight;
  final Color _color;
  final BorderRadius _borderRadius;

  const _ExpandedInnerContainer(
    this._child,
    this._maxHeight,
    this._color,
    this._borderRadius,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: _maxHeight),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
      ),
      child: _child,
    );
  }
}

class _RegularInnerContainer extends StatelessWidget {
  final Widget _child;
  final double? _height;
  final double? _width;
  final Color _color;
  final BorderRadius _borderRadius;

  const _RegularInnerContainer(
    this._child,
    this._height,
    this._width,
    this._color,
    this._borderRadius,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
      ),
      child: _child,
    );
  }
}

class _FittedMiddleContainer extends StatelessWidget {
  final ScrollController? _scrollController;
  final Widget _child;

  const _FittedMiddleContainer(
    this._scrollController,
    this._child,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: _child,
    );
  }
}

class _RegularMiddleContainer extends StatelessWidget {
  final ScrollController? _scrollController;
  final Widget _child;
  final double _horizontalPadding;
  final double _verticalPadding;

  const _RegularMiddleContainer(
    this._scrollController,
    this._child,
    this._horizontalPadding,
    this._verticalPadding,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(
            left: _horizontalPadding,
            top: _verticalPadding,
            right: _horizontalPadding,
            bottom: _verticalPadding),
        child: _child,
      ),
    );
  }
}

class _FittedOuterContainer extends StatelessWidget {
  final Widget _child;
  final double? _height;
  final double? _width;
  final double _horizontalPadding;
  final double _verticalPadding;
  final BorderRadius _borderRadius;

  const _FittedOuterContainer(
    this._child,
    this._height,
    this._width,
    this._horizontalPadding,
    this._verticalPadding,
    this._borderRadius,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: Padding(
        padding: EdgeInsets.only(
            left: _horizontalPadding,
            top: _verticalPadding,
            right: _horizontalPadding,
            bottom: _verticalPadding),
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: _child,
        ),
      ),
    );
  }
}

class _RegularOuterContainer extends StatelessWidget {
  final Widget _child;
  final double? _height;
  final double? _width;

  const _RegularOuterContainer(
    this._child,
    this._height,
    this._width,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: _child,
    );
  }
}
