import 'package:flutter/material.dart';

import 'delayed_animation_tween.dart';
import 'g_scale_y.dart';

/// A bar-style wave spinner.
///
/// Prefer the `G*` spinner widgets for new code.
class GBarWaveSpinner extends StatefulWidget {
  /// Bar color. Defaults to the active theme primary color.
  final Color? color;

  /// Wave origin.
  final GBarWaveSpinnerType type;

  /// Number of bars.
  final int itemCount;

  /// Height of the spinner.
  final double size;

  /// Optional builder for custom bar widgets.
  final IndexedWidgetBuilder? itemBuilder;

  /// Duration for one full animation cycle.
  final Duration duration;

  /// Optional external controller.
  ///
  /// When provided, the caller owns disposal.
  final AnimationController? controller;

  const GBarWaveSpinner({
    super.key,
    this.color,
    this.type = GBarWaveSpinnerType.start,
    this.size = 50.0,
    this.itemBuilder,
    this.itemCount = 5,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  }) : assert(itemBuilder == null || color == null, 'Provide either itemBuilder or color, but not both.'),
       assert(itemCount >= 2, 'itemCount cannot be less than 2.'),
       assert(size > 0, 'size must be greater than zero.');

  @override
  State<GBarWaveSpinner> createState() => _GBarWaveSpinnerState();
}

/// Wave animation origin for [GBarWaveSpinner].
enum GBarWaveSpinnerType {
  /// Wave starts from the leading edge.
  start,

  /// Wave starts from the trailing edge.
  end,

  /// Wave starts from the center.
  center,
}

class _GBarWaveSpinnerState extends State<GBarWaveSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    final List<double> bars = getAnimationDelay(widget.itemCount);
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 1.25, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bars.length, (i) {
            return GScaleY(
              scaleY: DelayedAnimationTween(begin: .4, end: 1.0, delay: bars[i]).animate(_controller),
              child: SizedBox.fromSize(size: Size(widget.size / widget.itemCount, widget.size), child: _itemBuilder(i)),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  List<double> getAnimationDelay(int itemCount) {
    switch (widget.type) {
      case GBarWaveSpinnerType.start:
        return _startAnimationDelay(itemCount);
      case GBarWaveSpinnerType.end:
        return _endAnimationDelay(itemCount);
      case GBarWaveSpinnerType.center:
        return _centerAnimationDelay(itemCount);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))..repeat();
  }

  List<double> _centerAnimationDelay(int count) {
    return <double>[
      ...List<double>.generate(count ~/ 2, (index) => -1.0 + (index * 0.2) + 0.2).reversed,
      if (count.isOdd) -1.0,
      ...List<double>.generate(count ~/ 2, (index) => -1.0 + (index * 0.2) + 0.2),
    ];
  }

  List<double> _endAnimationDelay(int count) {
    return <double>[
      ...List<double>.generate(count ~/ 2, (index) => -1.0 + (index * 0.1) + 0.1).reversed,
      if (count.isOdd) -1.0,
      ...List<double>.generate(count ~/ 2, (index) => -1.0 - (index * 0.1) - (count.isOdd ? 0.1 : 0.0)),
    ];
  }

  Widget _itemBuilder(int index) =>
      widget.itemBuilder != null
          ? widget.itemBuilder!(context, index)
          : DecoratedBox(decoration: BoxDecoration(color: widget.color ?? Theme.of(context).colorScheme.primary));

  List<double> _startAnimationDelay(int count) {
    return <double>[
      ...List<double>.generate(count ~/ 2, (index) => -1.0 - (index * 0.1) - 0.1).reversed,
      if (count.isOdd) -1.0,
      ...List<double>.generate(count ~/ 2, (index) => -1.0 + (index * 0.1) + (count.isOdd ? 0.1 : 0.0)),
    ];
  }
}
