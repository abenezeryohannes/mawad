import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:mawad/src/modules/home/cards/flag.cards.dart';

import '../../../presentation/sharedwidgets/big.text.button.dart';

class ChangeCountryBottomSheet extends StatefulWidget {
  const ChangeCountryBottomSheet({super.key});

  @override
  State<ChangeCountryBottomSheet> createState() =>
      _ChangeCountryBottomSheetState();
}

class _ChangeCountryBottomSheetState extends State<ChangeCountryBottomSheet> {
  String? privacy;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).maybePop();
      },
      backgroundColor: Theme.of(context).disabledColor,
      startingOpacity: 0.2,
      direction: DismissiblePageDismissDirection.down,
      isFullScreen: false,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * (6 / 12),
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * (5 / 12)),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Theme.of(context).colorScheme.secondary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: MediaQuery.of(context).size.width * (5 / 12)),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onPrimary,
                          width: 3)),
                ),

                ///
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(
                    'Country Names Title here',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),

                ///
                GridView.count(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 0.9,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlagCard(
                        selected: index == 0,
                      ),
                    );
                  }),
                ),

                ///

                BigTextButton(
                    text: 'This is the button',
                    fontWight: FontWeight.bold,
                    cornerRadius: 24,
                    elevation: 0,
                    backgroudColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    borderColor: Theme.of(context).cardColor,
                    textColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    padding: const EdgeInsets.only(top: 17, bottom: 17),
                    horizontalMargin: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 20, top: 10),
                    onClick: () {})

                ///
              ],
            )),
      ),
    );
  }
}
