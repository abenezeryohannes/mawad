import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/cart/cards/cart.item.card.dart';
import 'package:mawad/src/presentation/cart/cards/cart.total.card.dart';

import '../../../appcore/widgets/big.text.button.dart';

class CartsPage extends StatefulWidget {
  const CartsPage({super.key});

  @override
  State<CartsPage> createState() => _CartsPageState();
}

class _CartsPageState extends State<CartsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _appBar(),
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20.0, bottom: 10),
                    child: CartItemCard(
                      onValueChange: (val) {},
                      countable: index != 3,
                    ),
                  );
                }),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 9),
              child: CartTotalCard(items: []),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, left: 5, right: 5),
              child: Text(
                'Total is total is total is total is total ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
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
                onClick: () {}),
          ],
        ),
      )),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5.0, bottom: 5),
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
            IconButton(
                color: Theme.of(context).colorScheme.onBackground,
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                onPressed: () {},
                icon: Image.asset(
                  'assets/icon/remove.png',
                  width: 24,
                  height: 24,
                ))
          ],
        ),
      ),
    );
  }
}
