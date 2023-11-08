import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/country.dart';
import 'package:mawad/src/modules/home/widgets%20/flag.cards.dart';

import '../../../presentation/sharedwidgets/big.text.button.dart';

class ChangeCountryBottomSheet extends StatefulWidget {
  final List<Country> countries;
  final Function(Country) onCountrySelected;
  final Country? initialSelectedCountry;
  const ChangeCountryBottomSheet({
    required this.countries,
    required this.onCountrySelected,
    this.initialSelectedCountry,
    super.key,
  });

  @override
  State<ChangeCountryBottomSheet> createState() =>
      _ChangeCountryBottomSheetState();
}

class _ChangeCountryBottomSheetState extends State<ChangeCountryBottomSheet> {
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialSelectedCountry;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        alignment: Alignment.bottomCenter,
        width: Get.width,
        height: Get.height * (6 / 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 150), // Adjust the horizontal value to your needs
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary, width: 3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              child: Text(
                'Browse products from other countries',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.countries.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.9,
              ),
              padding: const EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (context, index) {
                final country = widget.countries[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlagCard(
                    country: country,
                    selected: country == _selectedCountry,
                    onFlagSelected: (selectedCountry) {
                      setState(() {
                        _selectedCountry = selectedCountry;
                      });
                    },
                  ),
                );
              },
            ),
            BigTextButton(
                text: 'Select country',
                fontWight: FontWeight.bold,
                cornerRadius: 24,
                elevation: 0,
                backgroudColor: Theme.of(context).colorScheme.primaryContainer,
                borderColor: Theme.of(context).cardColor,
                textColor: Theme.of(context).colorScheme.onPrimaryContainer,
                padding: const EdgeInsets.only(top: 17, bottom: 17),
                horizontalMargin: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 20, top: 10),
                onClick: () {
                  if (_selectedCountry != null) {
                    widget.onCountrySelected(_selectedCountry!);
                    Get.back();
                  }
                }),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
