import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/catagorie.dart';
import 'package:mawad/src/core/models/country.dart';
import 'package:mawad/src/core/models/image_model.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/data/repositories/produact_category_repo.dart';
import 'package:mawad/src/data/repositories/products.dart';
import 'package:mawad/src/data/services/cashe_services.dart';
import 'package:mawad/src/modules/poducts/product_catagory/product_categories_controller.dart';
import 'package:mawad/src/utils/helpers/icon_routes.dart';

class ProductController extends GetxController {
  final ProductsRepo _productsRepo = ProductsRepo();
  final isCategory = false.obs;

  set isCategory(value) => isCategory.value = value;

  CacheService cacheService = CacheService();
  final ProductCategoryRepo _productCategoryRepo = ProductCategoryRepo();
  final ProductCategoryController productCategoryController =
      Get.put(ProductCategoryController());

  final conmment = ''.obs;

  final TextEditingController commentController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final countries = <Country>[].obs;
  var selectedCountry = Rx<Country?>(null);
  final products = <Product>[].obs;
  final banners = <ImageModel>[].obs;
  final productDetail = Rx<Product?>(null);
  final categories = <CategoryModel>[].obs;

  final isLeading = false.obs;
  final isLeadingDetail = false.obs;

  @override
  void onReady() async {
    await fetchCountries();
    if (countries.isEmpty) {
      return;
    }

    selectedCountry.value = countries[1];
    if (selectedCountry.isBlank != true) {
      getProductByCountry(selectedCountry.value!.id);
    }
    getProductBanner();
    super.onReady();
  }

  void getProductByCountry(String id) async {
    try {
      isLeading.value = true;
      final productsData = await _productsRepo.getProductByCountry(id);
      products.value = productsData.obs;
      isLeading.value = false;
      getCategoryByCountry(id);
    } catch (error) {
      isLeading.value = false;
      // Handle error here
    }
  }

  void getProductByCategory(String id) async {
    try {
      isLeading.value = true;
      final productsData = await _productsRepo.getProductByCategory(id);
      products.value = productsData.obs;
      isLeading.value = false;
    } catch (error) {
      // Handle error here
      isLeading.value = false;
    }
  }

  void getProductBanner() async {
    try {
      isLeading.value = true;
      final bannerData = await _productsRepo.getBanner();
      banners.value = bannerData.obs;
    } catch (error) {}
  }

  void getProductDetail(String id) async {
    try {
      isLeadingDetail.value = true;

      final productsData = await _productsRepo.getProductDetail(id);
      isLeadingDetail.value = false;
      productDetail.value = productsData;
    } catch (error) {
      isLeadingDetail.value = false;
      // Handle error here
    }
  }

  void getCategoryByCountry(String id) async {
    try {
      final productsData = await _productCategoryRepo.getCategory(id);

      var allCategories = [
        CategoryModel(
          id: 'all',
          status: true,
          nameAr: 'All',
          nameEng: 'All',
          image: ImageModel(id: "2", url: IconRoutes.menu),
        )
      ];
      allCategories.addAll(productsData);
      categories.value = allCategories.obs;
    } catch (error) {}
  }

  Future fetchCountries() async {
    try {
      final countriesData = await _productsRepo.getCountries();
      countries.value = countriesData.obs;
      selectedCountry.value = countries[1];
    } catch (error) {}
  }

  void searchProduct(String id, String search) async {
    try {
      isLeading.value = true;
      products.value = (await _productsRepo.searchProduct(id, search)).obs;
    } catch (error) {
      // Handle error here
    } finally {
      isLeading.value = false;
    }
  }
}
