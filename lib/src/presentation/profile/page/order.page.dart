import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/profile/widgets/tab.custom.dart';

import '../cards/profile.item.card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int selectedTab = 0;
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TabCustom(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 20,
                  selectedIndex: selectedTab,
                  items: ['this is title 1', 'this is title 2'],
                  onItemSelected: (int index) {
                    setState(() {
                      selectedTab = index;
                    });
                  }),
            ),
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
                        title: 'Sample text',
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Image.asset(
                            'assets/icon/box.png',
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
          ],
        ),
      ),
    );
  }
}
