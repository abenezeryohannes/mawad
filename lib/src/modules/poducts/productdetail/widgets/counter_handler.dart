import 'package:flutter/material.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/data/services/localization_service.dart';
import 'package:mawad/src/modules/cart/widgets/item.count.controller.dart';
import 'package:mawad/src/modules/poducts/addon_handler_factory.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class CounterAddonHandler extends StatefulWidget implements AddonHandler {
  final ProductAddons addon;
  final Function(Addon) onAddonChanged;

  const CounterAddonHandler({
    Key? key,
    required this.addon,
    required this.onAddonChanged,
  }) : super(key: key);

  @override
  _CounterAddonHandlerState createState() => _CounterAddonHandlerState();

  @override
  Widget displayAddon(ProductAddons addon) {
    return this;
  }
}

class _CounterAddonHandlerState extends State<CounterAddonHandler> {
  Map<String, int> modifierCounts = {};
  int currentCount = 0;
  @override
  void initState() {
    super.initState();
    for (var modifier in widget.addon.modifiers) {
      modifierCounts[modifier.id] = 0;
    }
  }

  void _updateCount(String modifierId, int change) {
    int newCount = (modifierCounts[modifierId] ?? 0) + change;
    int newTotalCount =
        _totalModifierCount() - (modifierCounts[modifierId] ?? 0) + newCount;

    if (newCount >= 0 && newTotalCount <= widget.addon.maxAllowed) {
      setState(() {
        modifierCounts[modifierId] = newCount;
      });

      List<ModifierCart> modifiers = modifierCounts.entries
          .where((entry) => entry.value > 0)
          .map((entry) => ModifierCart(
              modifierId: entry.key,
              count: entry.value,
              modifierChoice: [] // Populate as per your requirements
              ))
          .toList();

      Addon addon = Addon(
        addonId: widget.addon.id,
        modifiers: modifiers,
      );

      widget.onAddonChanged(addon);
    }
  }

  int _totalModifierCount() {
    return modifierCounts.values.fold(0, (sum, count) => sum + count);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.addon.modifiers.map((modifier) {
        return SizedBox(
          child: PrimerCard(
            radius: 10,
            child: Row(
              children: [
                ItemCountController(
                  maxCount: widget.addon.maxAllowed -
                      _totalModifierCount() +
                      (modifierCounts[modifier.id] ?? 0),
                  initialValue: modifierCounts[modifier.id] ?? 0,
                  onChange: (newCount) => _updateCount(modifier.id,
                      newCount - (modifierCounts[modifier.id] ?? 0)),
                  backgroundColor: AppColorTheme.lightGray3,
                  iconColor: Colors.white,
                  minCount: 0,
                  canAdd: _totalModifierCount() < widget.addon.maxAllowed,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    LocalizationService.instance.currentLocaleLangCode ==
                            AppConstants.ENG
                        ? modifier.nameEng
                        : modifier.nameAr,
                    style: AppTextTheme.darkblueTitle16,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
