import 'package:flutter/material.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/data/services/localization_service.dart';
import 'package:mawad/src/modules/poducts/modifire_handler_factory.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/checkbox_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';

class CheckboxModifierHandler extends StatefulWidget
    implements ModifierHandler {
  final ModifierTag addon;
  final Modifier modifier;
  final Function(List<ModifierCart>)? onCheckboxChanged;

  const CheckboxModifierHandler(this.addon, this.modifier,
      {Key? key, this.onCheckboxChanged})
      : super(key: key);

  @override
  _CheckboxModifierHandlerState createState() =>
      _CheckboxModifierHandlerState();

  @override
  Widget displayAddon(ModifierTag addon, Modifier modifier) {
    return this;
  }
}

class _CheckboxModifierHandlerState extends State<CheckboxModifierHandler> {
  Set<String> selectedModifierIds = <String>{};

  void toggleModifierId(String id) {
    setState(() {
      bool isSelected = selectedModifierIds.contains(id);
      if (isSelected) {
        selectedModifierIds.remove(id);
      } else if (selectedModifierIds.length < widget.addon.maxAllowed) {
        selectedModifierIds.add(id);
      }
    });

    if (widget.onCheckboxChanged != null) {
      List<ModifierDetail> modifierDetails =
          selectedModifierIds.map((selectedId) {
        return ModifierDetail(id: selectedId, count: 1);
      }).toList();

      ModifierCart selectedModifierCart = ModifierCart(
          modifierId: widget.modifier.id,
          count: 0,
          modifierChoice: [
            ModifierChoice(
                choseAddonId: widget.addon.id, modifier: modifierDetails)
          ]);

      widget.onCheckboxChanged!([selectedModifierCart]);
    }
  }

  bool isDisabled(String id) {
    return selectedModifierIds.length >= widget.addon.maxAllowed &&
        !selectedModifierIds.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: widget.addon.productModifierChoice
          .map(
            (mod) => GestureDetector(
              onTap: () => toggleModifierId(mod.id),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: PrimerCard(
                  child: CheckboxIcon(
                    isDisabled: isDisabled(mod.id),
                    disabledTextStyle: AppTextTheme.lightGray17,
                    title: LocalizationService.instance.currentLocaleLangCode ==
                            AppConstants.ENG
                        ? mod.nameEng
                        : mod.nameAr,
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
    );
  }
}
