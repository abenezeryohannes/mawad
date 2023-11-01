import 'package:flutter/material.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/modules/poducts/addon_handler_factory.dart';
import 'package:mawad/src/modules/poducts/modifire_handler_factory.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/groupe_chip.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class SelectionAddonHandler extends StatefulWidget implements AddonHandler {
  final ProductAddons addon;

  const SelectionAddonHandler(this.addon, {Key? key}) : super(key: key);

  @override
  _SelectionAddonHandlerState createState() => _SelectionAddonHandlerState();

  @override
  Widget displayAddon(ProductAddons addon) {
    return SelectionAddonHandler(addon);
  }
}

class _SelectionAddonHandlerState extends State<SelectionAddonHandler> {
  String? selectedModifierId;
  Map<String, bool> additionalSelections = {};

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          PrimerCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChipGroup(
                  labels: widget.addon.modifiers
                      .map((modifier) => modifier.nameEng)
                      .toList(),
                  onSelectionChanged: (selectedLabel) {
                    setState(() {
                      var selectedModifier = widget.addon.modifiers.firstWhere(
                        (modifier) => modifier.nameEng == selectedLabel,
                      );
                      selectedModifierId = selectedModifier.id;

                      // Reset the additional selections when the main selection changes
                      additionalSelections.clear();
                    });
                  },
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    "${widget.addon.nameAr} :",
                    style: AppTextTheme.darkblueTitle16,
                  ),
                ),
              ],
            ),
          ),
          if (selectedModifierId != null)
            ...widget.addon.modifiers
                .firstWhere((modifier) => modifier.id == selectedModifierId)
                .modifierTags
                .map((tag) => Visibility(
                      visible: true,
                      child: ModifierHandlerFactory.create(tag),
                    ))
                .toList(),
        ],
      ),
    );
  }
}
