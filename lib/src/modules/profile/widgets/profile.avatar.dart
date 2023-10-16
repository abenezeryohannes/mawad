import 'package:flutter/material.dart';
import 'package:mawad/src/presentation/sharedwidgets/image.form.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar(
      {super.key,
      required this.upload,
      required this.isLoading,
      required this.editable,
      required this.deletable,
      this.localImage,
      this.onSave,
      this.placeholder,
      this.backgroundColor,
      this.radius,
      this.boxShadow,
      this.width,
      this.image,
      this.height,
      this.fit});
  final Function(String) upload;
  final Function(bool) isLoading;
  final bool editable;
  final bool deletable;
  final String? localImage;
  final double iconSize = 24;
  final Function? onSave;
  final Widget? placeholder;

  final Color? backgroundColor;
  final double? radius;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final String? image;
  final double? height;
  final BoxFit? fit;
  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: (widget.height ?? 0) + 16,
          width: (widget.width ?? 0) + 16,
          child: CircularProgressIndicator(
            value: 0.66,
            strokeWidth: 3,
            color: widget.localImage != null
                ? Theme.of(context).highlightColor
                : Theme.of(context).colorScheme.secondary,
            backgroundColor: widget.localImage != null
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        ImageForm(
          onUpload: widget.upload,
          isLoading: widget.isLoading,
          editable: widget.editable,
          deletable: widget.deletable,
          localImage: widget.localImage,
          iconSize: widget.iconSize,
          onSave: widget.onSave,
          placeholder: widget.placeholder,
          backgroundColor: widget.backgroundColor,
          radius: widget.radius,
          boxShadow: widget.boxShadow,
          width: widget.width,
          image: widget.image,
          height: widget.height,
          fit: widget.fit,
        ),
      ],
    );
  }
}
