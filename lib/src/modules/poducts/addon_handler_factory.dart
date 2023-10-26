import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/checkbox_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/color_selector.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/groupe_chip.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/textarea_filed.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';

abstract class AddonHandler {
  Widget displayAddon(ProductAddons addon);
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
              "هل لديك مواصفات خاصة؟",
              style: AppTextTheme.darkblueTitle16,
            ),
          ),
          TextAreaFiled(
            controller:
                myController, // You need to create a TextEditingController
            hintText: '',
            onChanged: (text) {
              // Handle text changes here
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
  @override
  Widget build(BuildContext context) {
    // Accessing the addon from the widget property
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PrimerCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Directionality(
                textDirection: TextDirection.ltr,
                child: ChipGroup(
                  labels: widget.addon.modifiers.map((modifier) {
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
              textDirection: TextDirection.rtl,
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

class CheckboxAddonHandler extends StatefulWidget implements AddonHandler {
  final ProductAddons addon;

  const CheckboxAddonHandler(this.addon, {Key? key}) : super(key: key);

  @override
  _CheckboxAddonHandlerState createState() => _CheckboxAddonHandlerState();

  @override
  Widget displayAddon(ProductAddons addon) {
    return CheckboxAddonHandler(addon);
  }
}

class _CheckboxAddonHandlerState extends State<CheckboxAddonHandler> {
  bool get isClicked => _isClicked;
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isClicked = !_isClicked;
        });
      },
      child: PrimerCard(
        child: CheckboxIcon(
          title: widget.addon.nameEng,
          textStyle: AppTextTheme.darkblueTitle16,
          onClicked: (p0) {
            setState(() {
              _isClicked = p0;
            });
          },
          isClicked: isClicked,
          checkedIconPath: IconRoutes.wood,
          iconPath: IconRoutes.checkbox,
        ),
      ),
    );
  }
}

class AddonHandlerFactory {
  static Widget create(ProductAddons addon) {
    final handler = _createHandler(addon);
    return handler.displayAddon(addon);
  }

  static AddonHandler _createHandler(ProductAddons addon) {
    switch (addon.addonOption) {
      case "COLOR":
        return ColorAddonHandler();
      case "input":
        return InputAddonHandler();
      case "SELECT":
        return SelectionAddonHandler(addon);
      case "CHECKBOX":
        return CheckboxAddonHandler(addon);
      default:
        throw Exception("Unknown addon type: ${addon.addonOption}");
    }

    // ... other conditions for different widgets
  }
}
