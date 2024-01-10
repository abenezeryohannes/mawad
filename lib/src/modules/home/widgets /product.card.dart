import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';

import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/data/services/localization_service.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/utils/utils.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final bool isFavorite;
  final ValueChanged<bool>? onFavoriteChanged;
  final bool isEnabled; // Add this line

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
    this.onFavoriteChanged,
    this.isFavorite = false,
    this.isEnabled = true, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * (5 / 12),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.network(
                      product.images.isNotEmpty
                          ? product.images.first.url
                          : AppConstants.Placeholde,
                      fit: BoxFit.cover,
                      height: Get.width * (5 / 12),
                      errorBuilder: (context, error, stackTrace) {
                        // Return a placeholder widget when an error occurs
                        return Image.network(
                          AppConstants.Placeholde,
                          fit: BoxFit.cover,
                          height: Get.width * (5 / 12),
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Get.locale?.languageCode == 'ar'
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: GestureDetector(
                    onTap: isEnabled
                        ? () => onFavoriteChanged?.call(!isFavorite)
                        : () => onFavoriteChanged?.call(false),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        size: 20,
                        color: isFavorite
                            ? AppColorTheme.red
                            : Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      LocalizationService.instance.currentLocaleLangCode ==
                              AppConstants.ENG
                          ? product.nameEng
                          : product.nameAr,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      LocalizationService.instance.currentLocaleLangCode ==
                              AppConstants.ENG
                          ? product.detailsEng ?? ''
                          : product.detailsAr ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            '${'KWD'.tr} ${Util.formatNumberWithCommas(product.price.toString())}',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
