import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';

import '../widgets/profile.item.card.dart';
import 'address.manager.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20.0),
                      child: ProfileItemCard(
                        title: 'Address',
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Image.asset(
                            'assets/icon/home_location.png',
                            width: 20,
                            height: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
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
            IconButton.filled(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColorTheme.yellow),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))))),
              onPressed: () => Get.to(() => const AddressManager()),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
