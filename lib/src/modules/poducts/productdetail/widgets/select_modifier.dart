import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/modules/poducts/modifire_handler_factory.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/groupe_chip.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class SelectionModifierHandler extends StatefulWidget
    implements ModifierHandler {
  final ModifierTag addon;

  const SelectionModifierHandler(this.addon, {Key? key}) : super(key: key);

  @override
  _SelectionModifierHandlerState createState() =>
      _SelectionModifierHandlerState();

  @override
  Widget displayAddon(ModifierTag addon) {
    return SelectionModifierHandler(addon);
  }
}

class _SelectionModifierHandlerState extends State<SelectionModifierHandler> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: PrimerCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Directionality(
                textDirection: TextDirection.rtl,
                child: ChipGroup(
                  labels: widget.addon.productModifierChoice.map((modifier) {
                    return modifier.nameEng;
                  }).toList(),
                  onSelectionChanged: (selectedLabel) {
                    print("Selected label: $selectedLabel");
                  },
                )),
            SizedBox(
              width: 12.w,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                "${widget.addon.nameAr} :",
                style: AppTextTheme.darkblueTitle16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
