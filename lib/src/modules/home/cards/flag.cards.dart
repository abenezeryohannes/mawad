import 'package:flutter/material.dart';
import 'package:mawad/src/core/models/country.dart';

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
            width: widget.size,
            height: widget.size,
            child: Stack(
              children: [
                if (widget.selected)
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          border: Border.all(
                              color: Theme.of(context).hintColor, width: 3)),
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Image.asset(
                      // widget.country.attachment.name,
                      "assets/icon/flag.png",
                      width: widget.size - 12,
                      height: widget.size - 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: .0, bottom: 5),
            child: Text(
              widget.country.nameEng,
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
