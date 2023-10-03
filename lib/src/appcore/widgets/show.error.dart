import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../errors/failure.dart';

enum ErrorShowType { Horizontal, Vertical, TextOnly }

class ShowError extends StatefulWidget {
  const ShowError(
      {Key? key,
      required this.failure,
      this.ErrorShowType,
      this.onRetry,
      this.height = 800})
      : super(key: key);
  final Failure failure;
  final Function? onRetry;
  final double? height;
  final ErrorShowType;

  @override
  State<ShowError> createState() => _ShowErrorState();
}

class _ShowErrorState extends State<ShowError> {
  @override
  Widget build(BuildContext context) {
    switch (widget.ErrorShowType) {
      case ErrorShowType.TextOnly:
        return Center(child: _text());
      case ErrorShowType.Horizontal:
        return Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _img(),
            const SizedBox(height: 40),
            Flexible(child: _text())
          ],
        ));
      default:
        return SizedBox(
          height: widget.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _img(),
              const SizedBox(height: 40),
              Flexible(child: _text())
            ],
          ),
        );
    }
  }

  Widget _img() {
    if (widget.failure.runtimeType == CacheFailure ||
        widget.failure.runtimeType == NetworkFailure) {
      return ColorFiltered(
        colorFilter:
            ColorFilter.mode(Colors.red.withOpacity(1), BlendMode.color),
        child: Image.asset(
          "assets/img/no_connection.png",
          height: (widget.ErrorShowType == ErrorShowType.Horizontal) ? 50 : 100,
        ),
      );
    }
    if (widget.failure.runtimeType == NoDataFailure) {
      return Image.asset(
        "assets/icon/empty.png",
        height: (widget.ErrorShowType == ErrorShowType.Horizontal) ? 50 : 100,
      );
    } else {
      return ColorFiltered(
        colorFilter:
            ColorFilter.mode(Colors.red.withOpacity(1), BlendMode.color),
        child: Image.asset(
          "assets/icon/error.png",
          height: (widget.ErrorShowType == ErrorShowType.Horizontal) ? 50 : 100,
        ),
      );
    }
  }

  Widget _text() {
    if (widget.failure.runtimeType == NoDataFailure) {
      return Column(
        children: [
          Text(
            (widget.failure.message ?? "no_data_exception").tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(widget.failure.message?.tr ?? "Something Went Wrong!!".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ],
      );
    }
  }
}
