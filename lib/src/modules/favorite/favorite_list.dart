import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/favorite/fevorite_controller.dart';
import 'package:mawad/src/modules/home/cards/product.card.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';

class FavoriteProductsList extends StatelessWidget {
  final FavoritesController favoritesController =
      Get.find<FavoritesController>();
  final RegisterWithPhoneController authController =
      Get.put(RegisterWithPhoneController());
  final RxList<Product>
      productList; // Pass a list of products, not just sampleProduct

  FavoriteProductsList({Key? key, required this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        return GridView.count(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          children: productList.map((product) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<bool>(
                future:
                    authController.isAuth(), // Here you call the async method
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Obx(() {
                        return ProductCard(
                          isEnabled: snapshot.data!,
                          isFavorite: favoritesController.isFavorite(product),
                          product: product,
                          onTap: () {
                            Get.toNamed(AppRoutes.productDetail,
                                arguments: product.id);
                          },
                          onFavoriteChanged: (isFav) {
                            if (snapshot.data!) {
                              favoritesController.toggleFavorite(product);
                            } else {
                              log('not auth');
                              Get.toNamed(AppRoutes.register);
                            }
                          },
                        );
                      });
                    } else if (snapshot.hasError) {
                      return ProductCard(
                        isEnabled: false,
                        product: product,
                      );
                    }
                  }
                  // While waiting for the Future, show a loading indicator or a disabled ProductCard
                  return const CircularProgressIndicator(); // or ProductCard with isEnabled: false
                },
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
