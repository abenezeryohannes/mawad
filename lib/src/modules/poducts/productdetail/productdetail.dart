import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/color_item.dart';
import 'package:mawad/src/modules/cart/widgets/item.count.controller.dart';
import 'package:mawad/src/presentation/sharedwidgets/big.text.button.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/checkbox_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/chip_button.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/color_selector.dart';
import 'package:mawad/src/presentation/sharedwidgets/cards/primery_cards.dart';
import 'package:mawad/src/presentation/sharedwidgets/input/textarea_filed.dart';
import 'package:mawad/src/presentation/sharedwidgets/scaffold/main_scaffold.dart';
import 'package:mawad/src/presentation/theme/app_color.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';
import 'package:mawad/src/utils/hex_color.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentSlide = 0;
  bool isClicked = false;
  ColorItem selectedColor = ColorItem(1, HexColor("#F9DDCB"));
  final myController = TextEditingController();
  List<ColorItem> colorItems = [
    ColorItem(1, HexColor("#F9DDCB")),
    ColorItem(2, HexColor("#DBD9C7")),
    ColorItem(3, HexColor("#72462A")),
    ColorItem(4, HexColor("#33302D")),
    ColorItem(5, HexColor("#DBDAD9")),
  ];

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      // backgroundColor: AppColorTheme.lightGray3,
      showBackButton: true,
      title: "Product Detail",
      haveTitle: true,
      body: buildProductDetailBody(),
    );
  }

  Widget buildProductDetailBody() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            buildImageCarousel(),
            buildProductInfo(),
            buildProductPriceAndDescription(),
            buildCustomizationOptions(),
            buildSpecialRequests(),
            const SizedBox(
              height: 10,
            ),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Widget buildImageCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true, // Set to true to show one image at a time
        aspectRatio: 16 / 3, // Adjust the aspect ratio as needed
        viewportFraction: 1.0,

        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        scrollPhysics: const ScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        height: 290.0.h,
        onPageChanged: (index, reason) {
          setState(() {
            currentSlide = index;
          });
        },
      ),
      items: carouselList(),
    );
  }

  List<Widget> carouselList() {
    return [1, 2, 3].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return SizedBox(
            child: Stack(
              children: [
                // Image
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.network(
                      "https://picsum.photos/200/300",
                      fit: BoxFit.fitWidth,
                      repeat: ImageRepeat.noRepeat,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 25.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdditionalProductData("Wood", IconRoutes.wood),
                      AdditionalProductData("45 cm", IconRoutes.arrowTop),
                      AdditionalProductData("30 cm", IconRoutes.arrowLeft),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Container(
                          width: index == 1 ? 42.0 : 24,
                          height: 4.0,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: i == index ? Colors.black : Colors.white,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }).toList();
  }

  Widget AdditionalProductData(String dataTitle, String dataIcon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColorTheme.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            child: SvgPicture.asset(dataIcon),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(dataTitle),
          ),
        ],
      ),
    );
  }

  Widget buildProductInfo() {
    return Container(
      padding: EdgeInsets.all(25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: const Text("غرفة نوم",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Card(
            color: AppColorTheme.white,
            child: Container(
              padding: EdgeInsets.all(6.r),
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 24.r,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductPriceAndDescription() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 23.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(" 219.00 د.ك", style: AppTextTheme.dark18),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: ItemCountController(
                    backgroundColor: AppColorTheme.lightGray,
                    iconColor: AppColorTheme.white,
                    value: 3,
                    iconSize: 14,
                    onChange: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: const Text(
            "غرفة نوم متكاملة فردية أو مزدوجة، تحتوي على سرير وعدد 2 طاولة سرير جانبية، وعدد 1 خزانة ملابس تتكون من 6 أبواب.",
            textAlign: TextAlign.start,
          ),
        ),
        // buildServiceRequestCheckbox(),
      ],
    );
  }

  Widget buildCustomizationOptions() {
    return Column(
      children: [
        buildServiceRequestCheckbox(),
        buildColorSelector(),
        buildChipGroup(),
      ],
    );
  }

  Widget buildServiceRequestCheckbox() {
    return PrimerCard(
      child: CheckboxIcon(
        title: "طلب خدمة أخذ المقاس",
        textStyle: AppTextTheme.darkblueTitle16,
        onClicked: (v) {
          setState(() {
            isClicked = !isClicked;
          });
        },
        isClicked: isClicked,
        checkedIconPath: IconRoutes.wood,
        iconPath: IconRoutes.checkbox,
      ),
    );
  }

  Widget buildColorSelector() {
    return PrimerCard(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: ColorSelector(
                  selectedColor: selectedColor,
                  colorItems: colorItems,
                  onColorSelected: (colorItem) {
                    setState(() {
                      selectedColor = colorItem;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  "اللون:",
                  style: AppTextTheme.darkblueTitle16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChipGroup() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PrimerCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Directionality(
                textDirection: TextDirection.ltr, child: ChipGroup()),
            SizedBox(
              width: 12.w,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "اللون:",
                style: AppTextTheme.darkblueTitle16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSpecialRequests() {
    return PrimerCard(
      height: 200.h,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            alignment: Alignment.centerRight,
            child: Text(
              "هل لديك مواصفات خاصة؟",
              style: AppTextTheme.darkblueTitle16,
            ),
          ),
          TextAreaFiled(
            controller:
                myController, // You need to create a TextEditingController
            hintText: '',
            onChanged: (text) {
              // Handle text changes here
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 10.h),
            alignment: Alignment.centerRight,
            child: Text(
              "* سيتم الرد على الطلب الخاص خلال يومان عمل.",
              style: AppTextTheme.graysubtitle12,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton() {
    return SizedBox(
      child: BigTextButton(
        text: 'أضف للسلة',
        fontWight: FontWeight.bold,
        cornerRadius: 24,
        elevation: 0,
        backgroudColor: Theme.of(context).colorScheme.secondary,
        borderColor: Theme.of(context).cardColor,
        textColor: Theme.of(context).colorScheme.onBackground,
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        horizontalMargin:
            const EdgeInsets.only(left: 30, right: 30, bottom: 10),
        onClick: () {},
      ),
    );
  }
  // Implement other helper functions as needed.
}

class ChipGroup extends StatefulWidget {
  const ChipGroup({super.key});

  @override
  _ChipGroupState createState() => _ChipGroupState();
}

class _ChipGroupState extends State<ChipGroup> {
  int selectedChipIndex = 0; // Initialize to -1 for no selection

  void handleChipSelection(int index) {
    setState(() {
      selectedChipIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChipButton(
          label: "غرفة مزدوجة",
          isSelected: selectedChipIndex == 0,
          onPressed: () {
            handleChipSelection(0);
          },
        ),
        SizedBox(
          width: 10.w,
        ),
        ChipButton(
          label: "غرفة أحادية",
          isSelected: selectedChipIndex == 1,
          onPressed: () {
            handleChipSelection(1);
          },
        ),
        // Add more ChipButtons as needed
      ],
    );
  }
}
