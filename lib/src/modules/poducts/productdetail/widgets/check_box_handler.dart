import 'package:flutter/material.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/modules/poducts/addon_handler_factory.dart';
import 'package:mawad/src/modules/poducts/modifire_handler_factory.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/checkbox_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';

class CheckboxAddonHandler extends StatefulWidget implements AddonHandler {
  final ProductAddons addon;
  final Function(Addon)? onCheckboxChanged;
  final Function(ModifierCart)? onModifierChanged;
  const CheckboxAddonHandler(
    this.addon, {
    Key? key,
    this.onCheckboxChanged,
    this.onModifierChanged,
  }) : super(key: key);

  @override
  _CheckboxAddonHandlerState createState() => _CheckboxAddonHandlerState();

  @override
  Widget displayAddon(ProductAddons addon) {
    return CheckboxAddonHandler(
      addon,
      onCheckboxChanged: onCheckboxChanged,
      onModifierChanged: onModifierChanged,
    );
  }
}

class _CheckboxAddonHandlerState extends State<CheckboxAddonHandler> {
  Set<String> selectedModifierIds = <String>{};

  void toggleModifierId(String id) {
    setState(() {
      if (selectedModifierIds.contains(id)) {
        selectedModifierIds.remove(id);
      } else if (selectedModifierIds.length < widget.addon.maxAllowed) {
        selectedModifierIds.add(id);
      }
    });

    // Update the Addon object on each change
    if (widget.onCheckboxChanged != null) {
      List<ModifierCart> modifiers = selectedModifierIds.map((selectedId) {
        return ModifierCart(
            modifierId: selectedId, count: 1, modifierChoice: []);
      }).toList();

      Addon addon = Addon(
        addonId: widget.addon.id,
        modifiers: modifiers,
      );

      widget.onCheckboxChanged!(addon);
    }
  }

  bool isDisabled(String id) {
    return selectedModifierIds.length >= widget.addon.maxAllowed &&
        !selectedModifierIds.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...widget.addon.modifiers
            .map(
              (mod) => GestureDetector(
                onTap: () => toggleModifierId(mod.id),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: PrimerCard(
                    child: CheckboxIcon(
                      isDisabled: isDisabled(mod.id),
                      disabledTextStyle: AppTextTheme.lightGray17,
                      title: mod.nameEng,
                      textStyle: AppTextTheme.darkblueTitle16,
                      onClicked: (_) => toggleModifierId(mod.id),
                      isClicked: selectedModifierIds.contains(mod.id),
                      checkedIconPath: IconRoutes.checkedBox,
                      iconPath: IconRoutes.checkbox,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        ...widget.addon.modifiers
            .expand((modifier) => modifier.modifierTags.map((tag) {
                  return Visibility(
                    visible: selectedModifierIds.contains(modifier.id),
                    child: ModifierHandlerFactory.create(
                      tag,
                      modifier,
                      onModifierChanged: (value) {
                        widget.onModifierChanged?.call(value);
                      },
                    ),
                  );
                }))
            .toList(),
      ],
    );
  }
}
