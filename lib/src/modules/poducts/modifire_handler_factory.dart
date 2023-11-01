import 'package:flutter/material.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/modules/poducts/productdetail/widgets/check_box_modifier_tag.dart';
import 'package:mawad/src/modules/poducts/productdetail/widgets/select_modifier.dart';

abstract class ModifierHandler {
  Widget displayAddon(ModifierTag addon);
  // other methods related to handling the addon can be added here
}

class ModifierHandlerFactory {
  static Widget create(ModifierTag addon) {
    final handler = _createHandler(addon);
    return handler.displayAddon(addon);
  }

  static ModifierHandler _createHandler(ModifierTag addon) {
    switch (addon.option) {
      case "SELECT":
        return SelectionModifierHandler(addon);
      case "CHECKBOX":
        return CheckboxModifierHandler(addon);
      default:
        throw Exception("Unknown addon type: ${addon.option}");
    }
  }
}
