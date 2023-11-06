import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

import 'dart:math' as math;

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
    ImageProvider backgroundImage = const AssetImage(
      'assets/icon/image_placeholder.png',
    );

    if (_selectedFile != null) {
      backgroundImage = FileImage(_selectedFile!); // Image from file
    } else if (widget.imageUrl != null) {
      backgroundImage = NetworkImage(widget.imageUrl!); // Image from network
    }

    // If there is a custom placeholder, it should be an ImageProvider
    if (_selectedFile == null && widget.placeholder is ImageProvider) {
      backgroundImage = widget.placeholder as ImageProvider;
    }

    return GestureDetector(
      onTap: _selectImage,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: PartialCirclePainter(
              color: _selectedFile != null
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
              child: _selectedFile == null
                  ? null
                  : Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedFile = null;
                          });
                          widget.onImagePicked.call(_selectedFile!);
                        },
                        child: Icon(Icons.remove_circle,
                            color: AppColorTheme.yellow, size: 20),
                      ),
                    ),
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
      -math.pi / 2, // Starting from the top center of the circle
      2 * math.pi * ratio, // 75% of the full circle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
