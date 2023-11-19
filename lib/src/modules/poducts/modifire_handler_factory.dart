import 'package:flutter/material.dart';
import 'package:mawad/src/core/constants/addonoption.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/modules/poducts/productdetail/widgets/check_box_modifier_tag.dart';
import 'package:mawad/src/modules/poducts/productdetail/widgets/counter_modifier_handler.dart';
import 'package:mawad/src/modules/poducts/productdetail/widgets/select_modifier.dart';

abstract class ModifierHandler {
  Widget displayAddon(ModifierTag addon, Modifier modifier);
}

class ModifierHandlerFactory {
  static Widget create(ModifierTag addon, Modifier modifier,
      {Function(ModifierCart)? onModifierChanged}) {
    final handler = _createHandler(
      addon,
      modifier,
      onModifierChanged: onModifierChanged,
    );
    return handler.displayAddon(addon, modifier);
  }

  static ModifierHandler _createHandler(ModifierTag addon, Modifier modifier,
      {Function(ModifierCart)? onModifierChanged}) {
    switch (addon.option) {
      case AddonOption.SELECT:
        return SelectionModifierHandler(
          addon,
          modifier,
          onSelectionChanged: (value) {
            if (onModifierChanged != null) {
              onModifierChanged.call(value);
            }
          },
        );
      case AddonOption.CHECKBOX:
        return CheckboxModifierHandler(
          addon,
          modifier,
          onCheckboxChanged: (List<ModifierCart> value) {
            if (onModifierChanged != null) {
              onModifierChanged.call(value.first);
            }
          },
        );
      case AddonOption.COUNTER:
        return CounterModifier(
          addon: addon,
          modifier: modifier,
          onSelectionChanged: (value) {
            if (onModifierChanged != null) {
              onModifierChanged.call(value);
            }
          },
        );
      default:
        throw Exception("Unknown modifier type: ${addon.option}");
    }
  }
}
