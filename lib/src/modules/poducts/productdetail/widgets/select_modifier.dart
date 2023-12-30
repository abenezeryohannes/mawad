import 'package:flutter/material.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/data/services/localization_service.dart';
import 'package:mawad/src/modules/poducts/modifire_handler_factory.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/groupe_chip.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class SelectionModifierHandler extends StatefulWidget
    implements ModifierHandler {
  final ModifierTag addon;
  final Modifier modifier;
  final Function(ModifierCart)? onSelectionChanged;

  const SelectionModifierHandler(this.addon, this.modifier,
      {Key? key, this.onSelectionChanged})
      : super(key: key);

  @override
  _SelectionModifierHandlerState createState() =>
      _SelectionModifierHandlerState();

  @override
  Widget displayAddon(ModifierTag addon, Modifier modifier) {
    return this;
  }
}

class _SelectionModifierHandlerState extends State<SelectionModifierHandler> {
  String? selectedValue;

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
                  labels: widget.addon.productModifierChoice
                      .map((modifier) =>
                          LocalizationService.instance.currentLocaleLangCode ==
                                  AppConstants.ENG
                              ? modifier.nameEng
                              : modifier.nameAr)
                      .toList(),
                  onSelectionChanged: (selectedLabel) {
                    var selectedModifierDetail =
                        widget.addon.productModifierChoice.firstWhere(
                            (modifier) =>
                                modifier.nameEng == selectedLabel ||
                                modifier.nameAr == selectedLabel,
                            orElse: () =>
                                widget.addon.productModifierChoice.first);

                    selectedValue = selectedModifierDetail
                        .id; // Assuming each choice has an id.

                    ModifierCart selectedModifierCart = ModifierCart(
                        modifierId: widget.modifier.id,
                        count: 0,
                        modifierChoice: [
                          ModifierChoice(
                              choseAddonId: widget.addon.id,
                              modifier: [
                                ModifierDetail(id: selectedValue!, count: 1)
                              ])
                        ]);

                    if (widget.onSelectionChanged != null) {
                      widget.onSelectionChanged!(selectedModifierCart);
                    }
                  },
                )),
            const SizedBox(width: 12), // Assuming 12 is a predefined width
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                "${LocalizationService.instance.currentLocaleLangCode == AppConstants.ENG ? widget.addon.nameEng : widget.addon.nameAr} :",
                style: AppTextTheme.darkblueTitle16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
