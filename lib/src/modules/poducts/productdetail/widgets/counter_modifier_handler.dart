import 'package:flutter/material.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/product_addon.dart';
import 'package:mawad/src/modules/cart/widgets/item.count.controller.dart';
import 'package:mawad/src/modules/poducts/modifire_handler_factory.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class CounterModifier extends StatefulWidget implements ModifierHandler {
  final ModifierTag addon;
  final Modifier modifier;
  final Function(ModifierCart) onSelectionChanged;
  const CounterModifier({
    Key? key,
    required this.addon,
    required this.modifier,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _CounterModifierState createState() => _CounterModifierState();

  @override
  Widget displayAddon(ModifierTag addon, Modifier modifier) {
    return this;
  }
}

class _CounterModifierState extends State<CounterModifier> {
  Map<String, int> modifierCounts = {};

  @override
  void initState() {
    super.initState();
    for (var modifier in widget.addon.productModifierChoice) {
      modifierCounts[modifier.id] = 0;
    }
  }

  void _updateCount(String modifierId, int change) {
    int newCount = (modifierCounts[modifierId] ?? 0) + change;
    if (newCount >= 0) {
      setState(() {
        modifierCounts[modifierId] = newCount;
      });

      List<ModifierDetail> modifierDetails = modifierCounts.entries
          .where((entry) => entry.value > 0)
          .map((entry) => ModifierDetail(id: entry.key, count: entry.value))
          .toList();

      ModifierCart modifierCart = ModifierCart(
        modifierId: widget.modifier.id,
        count: _totalModifierCount(),
        modifierChoice: [
          ModifierChoice(
              choseAddonId: widget.addon.id, modifier: modifierDetails)
        ],
      );

      widget.onSelectionChanged(modifierCart);
    }
  }

  int _totalModifierCount() {
    return modifierCounts.values.fold(0, (sum, count) => sum + count);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.addon.productModifierChoice.map((modifier) {
        return Directionality(
          textDirection: TextDirection.rtl,
          // width: double.infinity,
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
                  canAdd: _totalModifierCount() < widget.addon.maxAllowed,
                  minCount: 0,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    modifier.nameEng,
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
