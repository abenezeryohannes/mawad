import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/favorite/favorite_list.dart';
import 'package:mawad/src/modules/favorite/fevorite_controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';

class FavoritePage extends StatelessWidget {
  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      // showBackButton: true,
      body: Container(
        child: Column(
          children: [
            Obx(() {
              if (favoritesController.favorites.isEmpty) {
                return Container(
                  margin: EdgeInsets.only(top: Get.height * 0.3),
                  alignment: Alignment.center,
                  child: const Text('No favorites added yet.'),
                );
              }
              return FavoriteProductsList(
                productList: favoritesController.favorites,
              );
            }),
          ],
        ),
      ),
    );
  }
}
