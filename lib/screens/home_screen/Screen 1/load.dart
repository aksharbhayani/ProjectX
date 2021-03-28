import 'package:flutter/material.dart';

///
/// Widget for displaying loading animation and doing background work at the same time.
///
class EzTransition extends StatefulWidget {
  EzTransition(this.toProcess, {this.backgroundColor});

  final Widget toProcess;

  final Color backgroundColor;

  @override
  _EzTransitionState createState() => _EzTransitionState();
}

class _EzTransitionState extends State<EzTransition> {
  @override
  void initState() {
    super.initState();
    widget.toProcess;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getBackgroundColor(),
    );
  }

  Color getBackgroundColor() {
    return widget.backgroundColor == null
        ? Theme.of(context).backgroundColor
        : widget.backgroundColor;
  }
}
