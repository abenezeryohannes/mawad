import 'package:flutter/material.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/data/services/localization_service.dart';
import 'package:mawad/src/modules/poducts/addon_handler_factory.dart';
import 'package:mawad/src/modules/poducts/modifire_handler_factory.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/groupe_chip.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class SelectionAddonHandler extends StatefulWidget implements AddonHandler {
  final ProductAddons addon;

  final Function(Addon)? onSelectionChanged; // Add this line
  final Function(dynamic)? onModifierChanged; // Add this line

  const SelectionAddonHandler(
    this.addon, {
    Key? key,
    this.onSelectionChanged,
    this.onModifierChanged,
  }) : super(key: key);

  @override
  _SelectionAddonHandlerState createState() => _SelectionAddonHandlerState();

  @override
  Widget displayAddon(ProductAddons addon) {
    return SelectionAddonHandler(
      addon,
      onSelectionChanged: onSelectionChanged,
      onModifierChanged: onModifierChanged,
    );
  }
}

class _SelectionAddonHandlerState extends State<SelectionAddonHandler> {
  String? selectedModifierId;
  Map<String, dynamic> additionalSelections = {};
  ModifierCart? selectedModifier;
  void handleModifierChange(ModifierCart modifier) {
    setState(() {
      selectedModifier = modifier;
    });

    Addon addon = Addon(
      addonId: widget.addon.id,
      modifiers: [selectedModifier!],
    );
    widget.onSelectionChanged?.call(addon);
  }

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
                      .map((modifier) =>
                          LocalizationService.instance.currentLocaleLangCode ==
                                  AppConstants.ENG
                              ? modifier.nameEng
                              : modifier.nameAr)
                      .toList(),
                  onSelectionChanged: (selectedLabel) {
                    setState(() {
                      var selectedModifier = widget.addon.modifiers.firstWhere(
                        (modifier) =>
                            modifier.nameEng == selectedLabel ||
                            modifier.nameAr == selectedLabel,
                      );
                      selectedModifierId = selectedModifier.id;

                      additionalSelections.clear();

                      widget.onSelectionChanged?.call(
                        Addon(
                          addonId: widget.addon.id,
                          modifiers: [
                            ModifierCart(
                                modifierId: selectedModifierId!,
                                count: selectedModifier.index,
                                modifierChoice: [])
                          ],
                        ),
                      );
                    });
                  },
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    "${LocalizationService.instance.currentLocaleLangCode == AppConstants.ENG ? widget.addon.nameEng : widget.addon.nameAr} :",
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
                .map((tag) => ModifierHandlerFactory.create(
                    tag,
                    widget.addon.modifiers.firstWhere(
                      (modifier) => modifier.id == selectedModifierId,
                    ),
                    onModifierChanged: handleModifierChange))
                .toList(),
        ],
      ),
    );
  }
}
