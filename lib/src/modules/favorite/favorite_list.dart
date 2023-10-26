import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/modules/favorite/fevorite_controller.dart';
import 'package:mawad/src/modules/home/cards/product.card.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';

class FavoriteProductsList extends StatelessWidget {
  final FavoritesController favoritesController = Get.find();
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
              child: ProductCard(
                product: product,
                onTap: () {
                  Get.toNamed(AppRoutes.productDetail, arguments: product.id);
                },
                onFavoriteChanged: (isFav) {
                  favoritesController.toggleFavorite(product);
                },
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
