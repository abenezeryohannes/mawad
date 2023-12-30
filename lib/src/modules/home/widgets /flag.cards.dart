import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/country.dart';
import 'package:mawad/src/data/services/localization_service.dart';

class FlagCard extends StatefulWidget {
  const FlagCard({
    super.key,
    required this.country,
    this.selected = false,
    required this.onFlagSelected,
    this.size = 65,
  });

  final bool selected;
  final double size;
  final Country country;
  final Function(Country) onFlagSelected;
  @override
  State<FlagCard> createState() => _FlagCardState();
}

class _FlagCardState extends State<FlagCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onFlagSelected(widget.country);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 90.r,
            height: 90.r,
            child: Stack(
              children: [
                if (widget.selected)
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 90.r,
                      height: 90.r,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          border: Border.all(
                              color: Theme.of(context).hintColor, width: 3)),
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 40.r,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: SvgPicture.network(
                        "${AppConstants.IMAGER_URL}/${widget.country.attachment.id}",
                        fit: BoxFit.cover,
                        width: 78.r,
                        height: 78.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: .0, bottom: 5),
            child: Text(
              LocalizationService.instance.currentLocaleLangCode ==
                      AppConstants.ENG
                  ? widget.country.nameEng
                  : widget.country.nameAr,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
