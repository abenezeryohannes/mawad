import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

class FavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback? onTap;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    this.onTap,
  });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Card(
        color: AppColorTheme.white,
        child: Container(
          padding: EdgeInsets.all(6.r),
          child: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
            size: 24.r,
          ),
        ),
      ),
    );
  }
}
