import 'package:flutter/cupertino.dart';

import '../errors/failure.dart';

enum EmptyShowType { Horizontal, Vertical, TextOnly }

class ShowEmpty extends StatefulWidget {
  const ShowEmpty({Key? key, required this.failure, this.ErrorShowType})
      : super(key: key);
  final Failure failure;
  final ErrorShowType;

  @override
  State<ShowEmpty> createState() => _ShowEmptyState();
}

class _ShowEmptyState extends State<ShowEmpty> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.failure.message ?? "Something Went Wrong!!"),
    );
  }
}
