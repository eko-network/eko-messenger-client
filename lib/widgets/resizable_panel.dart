import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ResizablePanelController extends ChangeNotifier {
  double? _width;
  bool _isSnapped = false;

  double? _defaultWidth;
  double? _maxWidth;

  double? get width => _width;
  bool get isSnapped => _isSnapped;

  void _initialize({required double? defaultWidth, required double maxWidth}) {
    _defaultWidth = defaultWidth;
    _maxWidth = maxWidth;
    _width = defaultWidth ?? maxWidth;
  }

  void _updateWidth(double width, bool isSnapped) {
    _width = width;
    _isSnapped = isSnapped;
    notifyListeners();
  }

  void expand() {
    if (_isSnapped) {
      _width = _defaultWidth ?? _maxWidth;
      _isSnapped = false;
      notifyListeners();
    }
  }
}

class ResizablePanel extends StatefulWidget {
  final Widget firstPanel;
  final Widget secondPanel;
  final double minWidth;
  final double maxWidth;
  final double snapWidth;
  final double? defaultWidth;
  final ResizablePanelController? controller;

  const ResizablePanel({
    super.key,
    required this.firstPanel,
    required this.secondPanel,
    required this.minWidth,
    required this.maxWidth,
    required this.snapWidth,
    this.defaultWidth,
    this.controller,
  }) : assert(snapWidth < minWidth, 'snapWidth must be less than minWidth'),
       assert(
         minWidth <= maxWidth,
         'minWidth must be less than or equal to maxWidth',
       ),
       assert(
         defaultWidth == null || defaultWidth <= maxWidth,
         "defaultWidth must be less than maxWidth",
       ),
       assert(
         defaultWidth == null || defaultWidth >= minWidth,
         "defaultWidth must be greater than minWidth",
       );

  @override
  State<ResizablePanel> createState() => _ResizablePanelState();
}

class _ResizablePanelState extends State<ResizablePanel> {
  late ResizablePanelController _controller;
  bool _isInternalController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ResizablePanelController();
      _isInternalController = true;
    } else {
      _controller = widget.controller!;
    }
    _controller._initialize(
      defaultWidth: widget.defaultWidth,
      maxWidth: widget.maxWidth,
    );
  }

  @override
  void dispose() {
    if (_isInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleDragUpdate(
    DragUpdateDetails details,
    BoxConstraints constraints,
  ) {
    double currentWidth = _controller._width ?? widget.maxWidth;
    bool currentlySnapped = _controller._isSnapped;

    double newWidth = currentWidth + details.delta.dx;

    if (currentlySnapped) {
      // If currently snapped and user is expanding, snap to minWidth
      if (details.delta.dx > 0) {
        _controller._updateWidth(widget.minWidth, false);
      } else {
        // Keep it snapped if trying to shrink further
        _controller._updateWidth(widget.snapWidth, true);
      }
    } else {
      // Normal resizing
      if (newWidth < widget.minWidth) {
        // If shrinking below minWidth, snap to snapWidth
        _controller._updateWidth(widget.snapWidth, true);
      } else if (newWidth > widget.maxWidth) {
        // Clamp to maxWidth
        _controller._updateWidth(widget.maxWidth, false);
      } else {
        // Normal resize within bounds
        _controller._updateWidth(newWidth, false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final currentWidth = _controller._width ?? widget.maxWidth;
            // Ensure the panel width fits within available space
            final effectiveWidth = currentWidth.clamp(
              widget.snapWidth,
              constraints.maxWidth -
                  100, // Leave at least 100px for second panel
            );

            return Row(
              children: [
                SizedBox(width: effectiveWidth, child: widget.firstPanel),
                GestureDetector(
                  onHorizontalDragUpdate: (details) =>
                      _handleDragUpdate(details, constraints),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: Container(
                      width: 8,
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          width: 1,
                          color: ShadTheme.of(context).colorScheme.muted,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: widget.secondPanel),
              ],
            );
          },
        );
      },
    );
  }
}
