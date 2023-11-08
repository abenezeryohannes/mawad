import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/image_model.dart';
import 'package:mawad/src/modules/home/widgets%20/home_skeleton.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/app_button.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

class ImageBanner extends StatelessWidget {
  final List<ImageModel> imagePath;
  final VoidCallback? onButtonPressed;

  const ImageBanner({
    super.key,
    required this.imagePath,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true, // Set to true to show one image at a time
        aspectRatio: 16 / 3, // Adjust the aspect ratio as needed
        viewportFraction: 1.0,

        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        scrollPhysics: const ScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        height: 174.0.h,
        onPageChanged: (index, reason) {
          // setState(() {
          //   currentSlide = index;
          // });
        },
      ),
      items: imagePath.isNotEmpty
          ? banner(imagePath)
          : List.generate(1, (index) => buildBannerSkeleton(context)),
    );
  }

  List<Widget> banner(List<ImageModel> banner) {
    return banner
        .map((ban) => Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: ban.url.isNotEmpty
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            ban.url,
                            fit: BoxFit.cover,
                            height: 150,
                            width: Get.width * (11 / 12),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: AppButton(
                            radius: 20.r,
                            height: 39.h,
                            width: 130.w,
                            text: "شاهد المزيد",
                            textStyle: AppTextTheme.brown12,
                            onPressed: () {
                              onButtonPressed!();
                            },
                            color: AppColorTheme.white,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ))
        .toList();
  }
}
