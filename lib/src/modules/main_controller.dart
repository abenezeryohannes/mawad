import 'package:get/get.dart';
import 'package:mawad/src/core/models/country.dart';
import 'package:mawad/src/data/repositories/products.dart';
import 'package:mawad/src/modules/poducts/product/product_controller.dart';

class MainController extends GetxController {
  final ProductsRepo _productsRepo = ProductsRepo();
  final ProductController _productController = Get.put(ProductController());
  final countries = <Country>[].obs;
  var selectedCountry = Rx<Country?>(null);

  @override
  void onReady() async {
    await fetchCountries();
    if (countries.isEmpty) {
      return;
    }
    //Todo this will be change later
    selectedCountry = countries[1].obs;
    if (selectedCountry.isBlank != true) {
      _productController.getCategoryByCountry(selectedCountry.value!.id);
      _productController.getProductByCountry(selectedCountry.value!.id);
    }
    super.onReady();
  }

  Future fetchCountries() async {
    try {
      final countriesData = await _productsRepo.getCountries();
      countries.value = countriesData.obs;
    } catch (error) {
      // Handle error here
    }
  }
}
