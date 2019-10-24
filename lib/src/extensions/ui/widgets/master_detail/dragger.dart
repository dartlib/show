import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef DragEndCallback = void Function(DraggableDetails details);
typedef DragUpdateCallback = void Function(Offset position, Offset delta);

class Dragger<T> extends StatefulWidget {
  const Dragger({
    Key key,
    @required this.child,
    this.axis,
    this.affinity,
    this.maxSimultaneousDrags,
    this.onDragStarted,
    this.onDragUpdate,
    this.onDragEnd,
  })  : assert(child != null),
        assert(maxSimultaneousDrags == null || maxSimultaneousDrags >= 0),
        super(key: key);

  final Axis axis;
  final Widget child;
  final Axis affinity;
  final int maxSimultaneousDrags;
  final VoidCallback onDragStarted;
  final DragEndCallback onDragEnd;
  final DragUpdateCallback onDragUpdate;

  @protected
  MultiDragGestureRecognizer<MultiDragPointerState> createRecognizer(
      GestureMultiDragStartCallback onStart) {
    switch (affinity) {
      case Axis.horizontal:
        return HorizontalMultiDragGestureRecognizer()..onStart = onStart;
      case Axis.vertical:
        return VerticalMultiDragGestureRecognizer()..onStart = onStart;
    }
    return ImmediateMultiDragGestureRecognizer()..onStart = onStart;
  }

  @override
  _DraggerState<T> createState() => _DraggerState<T>();
}

class _DraggerState<T> extends State<Dragger<T>> {
  @override
  void initState() {
    super.initState();
    _recognizer = widget.createRecognizer(_startDrag);
  }

  @override
  void dispose() {
    _disposeRecognizerIfInactive();
    super.dispose();
  }

  GestureRecognizer _recognizer;
  int _activeCount = 0;

  void _disposeRecognizerIfInactive() {
    if (_activeCount > 0) return;
    _recognizer.dispose();
    _recognizer = null;
  }

  void _routePointer(PointerDownEvent event) {
    if (widget.maxSimultaneousDrags != null &&
        _activeCount >= widget.maxSimultaneousDrags) return;
    _recognizer.addPointer(event);
  }

  _NopDrag<T> _startDrag(Offset position) {
    if (widget.maxSimultaneousDrags != null &&
        _activeCount >= widget.maxSimultaneousDrags) return null;
    final dragStartPoint = Offset.zero;

    setState(() {
      _activeCount += 1;
    });

    final avatar = _NopDrag<T>(
      axis: widget.axis,
      initialPosition: position,
      dragStartPoint: dragStartPoint,
      onUpdateDrag: widget.onDragUpdate,
      onDragEnd: (Velocity velocity, Offset offset) {
        if (mounted) {
          setState(() {
            _activeCount -= 1;
          });
        } else {
          _activeCount -= 1;
          _disposeRecognizerIfInactive();
        }
        if (mounted && widget.onDragEnd != null) {
          widget.onDragEnd(
            DraggableDetails(
              velocity: velocity,
              offset: offset,
            ),
          );
        }
      },
    );
    if (widget.onDragStarted != null) widget.onDragStarted();
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    final canDrag = widget.maxSimultaneousDrags == null ||
        _activeCount < widget.maxSimultaneousDrags;
    return Listener(
      onPointerDown: canDrag ? _routePointer : null,
      child: widget.child,
    );
  }
}

class DraggableDetails {
  DraggableDetails({
    this.wasAccepted = false,
    @required this.velocity,
    @required this.offset,
  })  : assert(velocity != null),
        assert(offset != null);

  final bool wasAccepted;

  final Velocity velocity;

  final Offset offset;
}

enum _DragEndKind { dropped, canceled }
typedef _OnDragEnd = void Function(Velocity velocity, Offset offset);

class _NopDrag<T> extends Drag {
  final Function(Offset position, Offset delta) onUpdateDrag;
  final _OnDragEnd onDragEnd;
  final Axis axis;
  final Offset dragStartPoint;

  Offset _position;
  Offset _lastOffset;

  _NopDrag({
    this.axis,
    Offset initialPosition,
    this.dragStartPoint = Offset.zero,
    this.onDragEnd,
    this.onUpdateDrag,
  }) : assert(dragStartPoint != null) {
    _position = initialPosition;
    onUpdateDrag(initialPosition, Offset.zero);
  }

  @override
  void update(DragUpdateDetails details) {
    _position += _restrictAxis(details.delta);
    _lastOffset = _position - dragStartPoint;

    if (onUpdateDrag != null) {
      onUpdateDrag(_position, details.delta);
    }
  }

  @override
  void end(DragEndDetails details) {
    finishDrag(
      _DragEndKind.dropped,
      _restrictVelocityAxis(details.velocity),
    );
  }

  @override
  void cancel() {
    finishDrag(_DragEndKind.canceled);
  }

  void finishDrag(_DragEndKind endKind, [Velocity velocity]) {
    if (onDragEnd != null) {
      onDragEnd(velocity ?? Velocity.zero, _lastOffset);
    }
  }

  Velocity _restrictVelocityAxis(Velocity velocity) {
    if (axis == null) {
      return velocity;
    }
    return Velocity(
      pixelsPerSecond: _restrictAxis(velocity.pixelsPerSecond),
    );
  }

  Offset _restrictAxis(Offset offset) {
    if (axis == null) {
      return offset;
    }
    if (axis == Axis.horizontal) {
      return Offset(offset.dx, 0.0);
    }
    return Offset(0.0, offset.dy);
  }
}
