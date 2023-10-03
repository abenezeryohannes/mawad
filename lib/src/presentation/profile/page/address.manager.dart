import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../appcore/widgets/big.text.button.dart';
import '../widgets/profile.text.input.dart';

class AddressManager extends StatefulWidget {
  const AddressManager({super.key});

  @override
  State<AddressManager> createState() => _AddressManagerState();
}

class _AddressManagerState extends State<AddressManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(),
              ProfileTextInput(
                  label: 'This is label',
                  placeholder: 'This is placeholder',
                  onChange: (text) {}),
              ProfileTextInput(
                  label: 'This is label',
                  placeholder: 'This is placeholder',
                  onChange: (text) {}),
              ProfileTextInput(
                  label: 'This is label',
                  placeholder: 'This is placeholder',
                  onChange: (text) {}),
              ProfileTextInput(
                  label: 'This is label',
                  placeholder: 'This is placeholder',
                  onChange: (text) {}),
              ProfileTextInput(
                  label: 'This is label',
                  placeholder: 'This is placeholder',
                  onChange: (text) {}),
              ProfileTextInput(
                  label: 'This is label',
                  placeholder: 'This is placeholder',
                  onChange: (text) {}),
              const SizedBox(
                height: 20,
              ),
              BigTextButton(
                  text: 'This is the button',
                  fontWight: FontWeight.bold,
                  cornerRadius: 24,
                  elevation: 0,
                  backgroudColor: Theme.of(context).colorScheme.secondary,
                  borderColor: Theme.of(context).cardColor,
                  textColor: Theme.of(context).colorScheme.onBackground,
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  horizontalMargin:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  onClick: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20, right: 20, top: 10.0, bottom: 10),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.chevron_left,
                  size: 32,
                )),
            Expanded(
              child: Text(
                'This is title',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
