import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:shimmer/shimmer.dart';

Widget buildAppBarSkeleton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          height: 20,
          color: Colors.white,
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 20,
          color: Colors.white,
        ),
      ],
    ),
  );
}

Widget buildBannerSkeleton(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 200,
      color: Colors.white,
    ),
  );
}

Widget buildFavoriteProductsListSkeleton(BuildContext context) {
  int itemCount = 6; // Decide how many placeholders you want to show

  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
    ),
    itemCount: itemCount,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget buildCategorySkeleton(BuildContext context) {
  int itemCount = 10; // The number of placeholders you want

  return Container(
    color: AppColorTheme.bg,
    margin: const EdgeInsets.only(top: 10),
    width: MediaQuery.of(context).size.width,
    height: 150.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.r),
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.white,
            ),
            width: 100.w, // Set a fixed width for the skeleton item
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 80.w,
                  height: 8.h,
                  color: Colors.grey,
                ),
                SizedBox(height: 4.h),
                Container(
                  width: 60.w,
                  height: 8.h,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget buildProductDetailSkeleton() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: [
        buildImageCarouselSkeleton(),
        buildProductInfoSkeleton(),
        buildProductPriceAndDescriptionSkeleton(),
        buildDescriptionsSkeleton(),
        buildButtonSkeleton(),
        const SizedBox(height: 10), // Spacing at the bottom
      ],
    ),
  );
}

Widget buildImageCarouselSkeleton() {
  return Container(
    height: 290, // Match the height of your carousel
    color: Colors.grey[300],
    margin: const EdgeInsets.symmetric(vertical: 8),
  );
}

Widget buildProductInfoSkeleton() {
  return Container(
    padding: const EdgeInsets.all(25),
    child: Row(
      children: [
        Expanded(
          child: Container(height: 20, color: Colors.grey[300]),
        ),
        Container(
            width: 40,
            height: 20,
            color: Colors.grey[300]), // For the favorite button
      ],
    ),
  );
}

Widget buildProductPriceAndDescriptionSkeleton() {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Row(
      children: [
        Expanded(
          child: Container(height: 20, color: Colors.grey[300]),
        ),
        Container(
            width: 40,
            height: 40,
            color: Colors.grey[300]), // For the quantity selector
      ],
    ),
  );
}

Widget buildDescriptionsSkeleton() {
  return Container(
    padding: const EdgeInsets.all(15),
    child: Container(
        height: 100, color: Colors.grey[300]), // Adjust the height as needed
  );
}

Widget buildButtonSkeleton() {
  return Container(
    height: 50, // Match the height of your button
    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    color: Colors.grey[300],
  );
}
