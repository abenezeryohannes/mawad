import 'package:get/get.dart';
import 'package:mawad/src/modules/auth/otp/otp_page.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_binding.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_page.dart';
import 'package:mawad/src/modules/cart/carts/cart_binding.dart';
import 'package:mawad/src/modules/cart/checkout/checkout_binding.dart';
import 'package:mawad/src/modules/cart/checkout/checkout_page.dart';
import 'package:mawad/src/modules/cart/page/carts.page.dart';
import 'package:mawad/src/modules/favorite/favorite_product_binding.dart';
import 'package:mawad/src/modules/favorite/pages/favorite.page.dart';
import 'package:mawad/src/modules/poducts/product_catagory/product_catagory.dart';
import 'package:mawad/src/modules/poducts/product_catagory/product_categories_binding.dart';
import 'package:mawad/src/modules/poducts/productdetail/productdetail.dart';
import 'package:mawad/src/modules/main.page.dart';
import 'package:mawad/src/modules/profile/my_address/address.page.dart';
import 'package:mawad/src/modules/profile/my_address/address_binding.dart';
import 'package:mawad/src/modules/profile/order/orderdetail/order_detail.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    ...authpage,
    ...mainpage,
    ...profile,
    ...cart
  ];

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
      bindings: [
        RegisterWithPhoneBinding(),
        ProductCategoriesBinding(),
        FavoriteProductBinding(),
        CartBinding()
      ],
    ),
    GetPage(
        name: AppRoutes.productDetail,
        page: () => const ProductDetailPage(),
        bindings: [
          RegisterWithPhoneBinding(),
          ProductCategoriesBinding(),
          FavoriteProductBinding(),
          CartBinding(),
        ]),
    GetPage(
        name: AppRoutes.productCategory,
        page: () => const ProductCategory(),
        bindings: [
          ProductCategoriesBinding(),
          RegisterWithPhoneBinding(),
          FavoriteProductBinding(),
          CartBinding(),
        ]),
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
    GetPage(
        name: AppRoutes.address,
        page: () => const AddressPage(),
        binding: AddressBinding()),
  ];
  static final cart = [
    GetPage(
      name: AppRoutes.checkout,
      page: () => CheckoutPage(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartsPage(),
      binding: CartBinding(),
    ),
  ];
}
