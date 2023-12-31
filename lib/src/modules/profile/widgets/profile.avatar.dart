import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

import 'dart:math' as math;

import 'package:shimmer/shimmer.dart';

class ProfileAvatar extends StatefulWidget {
  final Function(File) onImagePicked;
  final String? imageUrl;
  final double? radius;
  final BoxFit fit;
  final Widget? placeholder;

  const ProfileAvatar({
    super.key,
    required this.onImagePicked,
    this.imageUrl,
    this.radius = 50.0,
    this.fit = BoxFit.cover,
    this.placeholder,
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedFile;

  Future<void> _selectImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedFile = File(pickedFile.path);
        });
        widget.onImagePicked(_selectedFile!);
      }
    } catch (e) {
      if (e is Exception) {
        _showErrorDialog(e.toString());
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An error occurred'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const nullValue = 'http://ordermawad.com/api/v1/file/get/';
    ImageProvider backgroundImage = const AssetImage(
      'assets/icon/image_placeholder.png',
    );

    if (_selectedFile != null) {
      backgroundImage = FileImage(_selectedFile!);
    } else if (widget.imageUrl != null && widget.imageUrl != nullValue) {
      backgroundImage = NetworkImage(widget.imageUrl!);
    }

    if (_selectedFile == null && widget.placeholder is ImageProvider) {
      backgroundImage = widget.placeholder as ImageProvider;
    }
    log("widget.imageUrl ${widget.imageUrl}");
    return GestureDetector(
      onTap: _selectImage,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: PartialCirclePainter(
              color: widget.imageUrl != null && widget.imageUrl != nullValue
                  ? AppColorTheme.yellow
                  : AppColorTheme.gray, // Border color
              strokeWidth: 4.0, // Border stroke width
            ),
            child: CircleAvatar(
              radius: widget.radius! + 10, // Increase radius for border to fit
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(
            width: widget.radius! * 2,
            child: CircleAvatar(
              radius: widget.radius,
              backgroundColor: AppColorTheme.bg,
              backgroundImage: backgroundImage,
              child: widget.imageUrl!.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.red,
                        child: const CircleAvatar(
                          radius: 50.0,
                        ),
                      ))
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class PartialCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double ratio;

  PartialCirclePainter({
    required this.color,
    required this.strokeWidth,
    this.ratio = 0.75,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * ratio,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
