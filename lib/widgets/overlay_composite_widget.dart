import 'package:flutter/material.dart';

class OverlayCompositeWidget<T> extends StatefulWidget {
  final Widget Function(VoidCallback) builder;
  final Widget Function(VoidCallback) overlayWidget;
  final double? menuWidth;
  final double? menuHeight;
  final double? topMargin;
  final double? alignedPositionMargin;
  final Alignment? overlayAlign;
  final double? borderRadius;

  const OverlayCompositeWidget(
      {Key? key,
      required this.builder,
      required this.overlayWidget,
      this.menuWidth,
      this.menuHeight,
      this.topMargin,
      this.alignedPositionMargin,
      this.overlayAlign,
      this.borderRadius})
      : super(key: key);

  @override
  OverlayCompositeWidgetState<T> createState() =>
      OverlayCompositeWidgetState<T>();
}

class OverlayCompositeWidgetState<T> extends State<OverlayCompositeWidget<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final _overlayKey = GlobalKey();
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleDropdown,
        child: widget.builder(() => _toggleDropdown(close: true)),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    Offset widgetOffset = renderBox.localToGlobal(Offset.zero);
    double screenHeight = MediaQuery.of(context).size.height;
    double yOffsetDialog = widgetOffset.dy + (widget.menuHeight ?? 250);
    double yOffset = (screenHeight - yOffsetDialog) > 0
        ? (size.height + 5)
        : (-(widget.menuHeight ?? 250) - 5);
    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTapDown: _handleTapDown,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned(
                height: widget.menuHeight,
                width: widget.menuWidth,
                child: CompositedTransformFollower(
                  offset: Offset(
                      size.width - (widget.alignedPositionMargin ?? 0),
                      yOffset),
                  followerAnchor: widget.overlayAlign ?? Alignment.topRight,
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: 100000000000,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius ?? 0.00)),
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: Container(
                        key: _overlayKey,
                        child: widget
                            .overlayWidget(() => _toggleDropdown(close: true)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      this._overlayEntry?.remove();
      if (mounted) {
        setState(() {
          _isOpen = false;
        });
      }
    } else {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context).insert(this._overlayEntry!);
      setState(() => _isOpen = true);
    }
  }

  void _handleTapDown(TapDownDetails details) {
    final RenderBox widgetRenderBox =
        _overlayKey.currentContext?.findRenderObject() as RenderBox;
    final Offset localOffset =
        widgetRenderBox.globalToLocal(details.globalPosition);
    if (!widgetRenderBox.paintBounds.contains(localOffset)) {
      _toggleDropdown(close: true);
    }
  }
}
