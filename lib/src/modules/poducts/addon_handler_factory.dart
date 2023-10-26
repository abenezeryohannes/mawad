import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/color_selector.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/groupe_chip.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/textarea_filed.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

abstract class AddonHandler {
  Widget displayAddon(ProductAddons addon) {
    return Container();
  }
  // other methods related to handling the addon can be added here
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

class InputAddonHandler extends AddonHandler {
  final TextEditingController myController = TextEditingController();

  @override
  Widget displayAddon(ProductAddons addon) {
    return PrimerCard(
      height: 200.h,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            alignment: Alignment.centerRight,
            child: Text(
              addon.nameAr, // Using the addon name instead of hardcoded text.
              style: AppTextTheme.darkblueTitle16,
            ),
          ),
          TextAreaFiled(
            controller: myController,
            hintText: '', // You can use addon.detailsAr for hint if needed
            onChanged: (text) {
              // Handle text changes here, if needed.
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 10.h),
            alignment: Alignment.centerRight,
            child: Text(
              "* سيتم الرد على الطلب الخاص خلال يومان عمل.",
              style: AppTextTheme.graysubtitle12,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectionAddonHandler extends AddonHandler {
  @override
  Widget displayAddon(ProductAddons addon) {
    log("addon====> ${addon.toString()}");
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PrimerCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Directionality(
                textDirection: TextDirection.ltr, child: ChipGroup()),
            SizedBox(
              width: 12.w,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "اللون:",
                style: AppTextTheme.darkblueTitle16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckboxAddonHandler extends AddonHandler {
  @override
  Widget displayAddon(ProductAddons addon) {
    return Container();
  }
}

class AddonHandlerFactory {
  static Widget create(ProductAddons addon) {
    final addonHandler = createHandler(addon);
    return addonHandler.displayAddon(addon);
  }

  static AddonHandler createHandler(ProductAddons addon) {
    switch (addon.addonOption) {
      case "COLOR":
        return ColorAddonHandler();
      case "input":
        return InputAddonHandler();
      case "SELECT":
        return SelectionAddonHandler();
      case "checkbox":
        return CheckboxAddonHandler();
      default:
        throw Exception("Unknown addon type: ${addon.addonOption}");
    }
  }
}
