import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/core/constants/addonoption.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/modules/poducts/productdetail/widgets/check_box_handler.dart';
import 'package:mawad/src/modules/poducts/productdetail/widgets/counter_handler.dart';
import 'package:mawad/src/modules/poducts/productdetail/widgets/select_handler.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/color_selector.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

abstract class AddonHandler {
  Widget displayAddon(ProductAddons addon);
}

class AddonHandlerFactory {
  static Widget create(
    ProductAddons addon, {
    Function(Addon)? onAddonChanged,
  }) {
    final handler = _createHandler(
      addon,
      onAddonChanged: onAddonChanged,
    );
    return handler.displayAddon(addon);
  }

  static AddonHandler _createHandler(
    ProductAddons addon, {
    Function(Addon)? onAddonChanged,
  }) {
    switch (addon.addonOption) {
      case AddonOption.SELECT:
        return SelectionAddonHandler(
          addon,
          onSelectionChanged: (Addon selectedAddon) {
            if (onAddonChanged != null) {
              onAddonChanged.call(selectedAddon);
            }
          },
        );
      case AddonOption.CHECKBOX:
        return CheckboxAddonHandler(
          addon,
          onCheckboxChanged: (Addon selectedAddon) {
            if (onAddonChanged != null) {
              onAddonChanged.call(selectedAddon);
            }
          },
        );
      case AddonOption.COUNTER:
        return CounterAddonHandler(
          addon: addon,
          onAddonChanged: (selectedAddon) {
            if (onAddonChanged != null) {
              onAddonChanged.call(selectedAddon);
            }
          },
        );
      default:
        throw Exception("Unknown addon type: ${addon.addonOption}");
    }
  }
}

class ColorAddonHandler extends AddonHandler {
  @override
  Widget displayAddon(ProductAddons addon) {
    Color selectedColor = Colors.white;

    List<Color> colorItems = addon.modifiers.map((modifier) {
      return Color(int.parse(modifier.color.substring(1, 7), radix: 16) +
          0xFF000000); // Convert hex string to Color
    }).toList();

    return PrimerCard(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: ColorSelector(
                  selectedColor: selectedColor,
                  colorItems: colorItems,
                  onColorSelected: (colorItem) {
                    // setState logic here.
                    selectedColor = colorItem;
                  },
                ),
              ),
              SizedBox(
                width: 12.w, // Assuming you've set up screen width extensions.
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  "اللون:",
                  style: AppTextTheme.darkblueTitle16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
