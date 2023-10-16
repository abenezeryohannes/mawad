import 'dart:async';

import 'package:flutter/material.dart';

import 'animate.dart';

class FadeAnimation extends StatefulWidget {
  FadeAnimation(
      {Key? key,
      required this.child,
      required this.delay,
      required this.milli,
      required this.begin,
      required this.end,
      required this.start,
      required this.finish,
      required this.controller})
      : super(key: key);

  final Widget child;
  final int delay;
  final int milli;
  final Offset begin;
  final Offset end;
  final double start;
  final double finish;
  final StreamController<Animate> controller;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late StreamSubscription _controllerSubscriber;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.milli),
      vsync: this,
    );

    _controllerSubscriber =
        widget.controller.stream.asBroadcastStream().listen((event) {
      if (event == Animate.forward) {
        //print('event forward ' + event.toString());
        _controller.forward();
      } else if (event == Animate.reverse) {
        //print('event backward ' + event.toString());
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _controllerSubscriber.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: widget.begin,
        end: widget.end,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      )),
      child: FadeTransition(
          opacity: Tween<double>(
            begin: widget.start,
            end: widget.finish,
          ).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          )),
          child: widget.child),
    );
  }
}
