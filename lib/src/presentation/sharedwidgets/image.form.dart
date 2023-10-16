import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mawad/src/utils/utils.dart';

import 'custom.shimmer.dart';

class ImageForm extends StatefulWidget {
  const ImageForm(
      {super.key,
      this.backgroundColor,
      this.radius,
      this.boxShadow,
      this.width,
      this.image,
      this.height,
      this.fit,
      required this.onUpload,
      required this.isLoading,
      this.localImage,
      this.deletable = false,
      this.editable = true,
      this.iconSize = 24,
      this.onSave,
      this.placeholder});

  final Color? backgroundColor;
  final double? radius;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;
  final String? image;
  final BoxFit? fit;
  final bool deletable;
  final bool editable;
  final double iconSize;
  final Widget? placeholder;

  final String? localImage;
  final Function(String) onUpload;
  final Function(bool) isLoading;
  final Function? onSave;
  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  String? _getImageString() {
    return ((widget.localImage?.length ?? 0) > 0)
        ? widget.localImage
        : widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widget.height ?? 120),
      width: (widget.width ?? 120),
      child: Stack(
        children: [
          Container(
            height: widget.height ?? 120,
            width: widget.width ?? 120,
            decoration: BoxDecoration(
                boxShadow: widget.boxShadow,
                color: widget.backgroundColor ?? Theme.of(context).cardColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.radius ?? 0))),
            child: widget.localImage != null || widget.image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(widget.radius ?? 0),
                    child: _getImage(context, _getImageString()))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(widget.radius ?? 0),
                    child: InkWell(
                        onTap: () async {
                          await Util.GetImage(
                              context, widget.isLoading, widget.onUpload);
                        },
                        child: widget.placeholder)),
          ),
          if (widget.editable &&
              !(widget.placeholder != null && widget.image == null))
            Align(
              alignment: Alignment.center,
              child: _editing(),
            )
        ],
      ),
    );
  }

  Widget _editing() {
    return Container(
      height: widget.height ?? 120,
      width: widget.width ?? 120,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.localImage != null)
            SizedBox(
              width: (widget.width ?? 120) / 10,
            ),
          if (widget.localImage != null)
            InkWell(
                onTap: () async {
                  if (widget.onSave != null) {
                    widget.onSave!();
                  }
                },
                child: Icon(
                  Icons.check,
                  size: widget.iconSize,
                  color: Theme.of(context).colorScheme.secondary,
                )),
          SizedBox(
            width: (widget.width ?? 120) / 10,
          ),
          InkWell(
              onTap: () async {
                await Util.GetImage(context, widget.isLoading, widget.onUpload);
              },
              child: Icon(
                Icons.edit,
                size: widget.iconSize,
                color: Theme.of(context).hintColor,
              )),
          SizedBox(
            width: (widget.width ?? 120) / 10,
          ),
          if (widget.deletable)
            InkWell(
                onTap: () {},
                child: Icon(
                  Icons.delete,
                  size: widget.iconSize,
                  color: Theme.of(context).hintColor,
                )),
        ],
      ),
    );
  }

  Widget _getImage(BuildContext context, String? url) {
    if (url == null) {
      return Image.asset(
        'assets/img/placeholder.jpeg',
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
      );
    } else if (url.contains('http')) {
      return Image.network(
        url,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
        // frameBuilder: ,
        loadingBuilder: (context, child, loadingProgress) =>
            _loading(child, loadingProgress),
        errorBuilder: (context, error, stackTrace) => _error(error),
      );
    } else if (url.contains('assets')) {
      return Image.asset(
        url,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _error(error),
      );
    } else if (File(url).existsSync()) {
      return Image.file(
        File(url),
        width: widget.width,
        fit: BoxFit.cover,
        height: widget.height,
        errorBuilder: (context, error, stackTrace) => _error(error),
      );
    } else {
      return Image.asset(
        'assets/icon/error.png',
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _error(error),
      );
    }
  }

  Widget _show(ImageChunkEvent? _) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).disabledColor,
            borderRadius:
                BorderRadius.all(Radius.circular(widget.radius ?? 0))),
        width: widget.width,
        height: widget.height);
  }

  Widget _loading(Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    } else {
      return CustomShimmer(
        show: true,
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).disabledColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.radius ?? 0))),
            width: widget.width,
            height: widget.height),
      );
    }
  }

  Widget _error(Object? error) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 0))),
      width: widget.width,
      height: widget.height,
      child: Icon(
        Icons.error,
        size: (widget.height ?? 200) / 4,
      ),
    );
  }
}
