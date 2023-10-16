import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/otp/otp_page.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_binding.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_page.dart';
import 'package:mawad/src/modules/favorite/favorite_product_binding.dart';
import 'package:mawad/src/modules/favorite/pages/favorite.page.dart';
import 'package:mawad/src/modules/poducts/product_catagory/product_catagory.dart';
import 'package:mawad/src/modules/poducts/product_catagory/product_categories_binding.dart';
import 'package:mawad/src/modules/poducts/productdetail/productdetail.dart';
import 'package:mawad/src/modules/main.page.dart';
import 'package:mawad/src/modules/profile/order/orderdetail/order_detail.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [...authpage, ...mainpage, ...profile];

  static final authpage = [
    GetPage(
        name: AppRoutes.register,
        page: () => const RegisterWithPhonePage(),
        binding: RegisterWithPhoneBinding()),
    GetPage(
        name: AppRoutes.otp,
        page: () => const OtpPage(),
        binding: RegisterWithPhoneBinding()),
  ];
  static final mainpage = [
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailPage(),
    ),
    GetPage(
        name: AppRoutes.productCategory,
        page: () => const ProductCategory(),
        binding: ProductCategoriesBinding()),
    GetPage(
        name: AppRoutes.favproduct,
        page: () => FavoritePage(),
        binding: FavoriteProductBinding()),
  ];

  static final profile = [
    GetPage(
      name: AppRoutes.orderDetail,
      page: () => const OrderDetail(),
    ),
  ];
}
