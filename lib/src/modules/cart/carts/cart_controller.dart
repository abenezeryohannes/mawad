import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/data/repositories/products.dart';
import 'package:mawad/src/data/services/localstorage_service.dart';
import 'package:mawad/src/data/services/message_services.dart';

class CartController extends GetxController {
  final RxList<CartItem> _cartItems = RxList<CartItem>();
  final LocalStorageService _localStorageService = LocalStorageService.instance;
  final MessageService messageService = MessageService();
  final _otherServices = <OtherServices>[].obs;
  final ProductsRepo _productsRepo = ProductsRepo();
  final _listOfOtherServices = <String>[].obs;

  final selectedAddons = <Addon>[].obs;

  final isLoading = false.obs;
  final subtotal = 0.0.obs;
  final shippingFees = 0.0.obs;
  final total = 0.0.obs;
  final double standardShippingFee = 10.0;
  final double freeShippingThreshold = 100.0;

  List<CartItem> get cartItems => _cartItems.toList();
  List<OtherServices> get otherServices => _otherServices.toList();
  List<String> get listOfOtherServices => _listOfOtherServices.toList();

  void toggleOtherService(String serviceId, bool isChecked) {
    if (isChecked) {
      _listOfOtherServices.add(serviceId);
    } else {
      _listOfOtherServices.remove(serviceId);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _localStorageService.initialize();
    loadFromLocalStorage();
    ever(_cartItems, (_) => calculateTotals());
  }

  void calculateTotals() {
    double newSubtotal = _cartItems.fold(0,
        (total, current) => total + (current.product.price * current.quantity));
    double newShippingFees =
        newSubtotal > freeShippingThreshold ? 0.0 : standardShippingFee;
    double newTotal = newSubtotal + newShippingFees;

    subtotal.value = newSubtotal;
    shippingFees.value = newShippingFees;
    total.value = newTotal;
  }

  void addItem(CartItem item) {
    isLoading.value = true;
    try {
      String itemKey = '${item.product.id}-${item.product.id}';

      int index = _cartItems.indexWhere((cartItem) =>
          '${cartItem.product.id}-${cartItem.product.id}' == itemKey);

      if (index != -1) {
        _cartItems[index].quantity = item.quantity; // Set the new quantity
        messageService.showTopUpMessage(
            'Info'.tr, 'Item quantity updated in cart.'.tr);
      } else {
        _cartItems.add(item);
        messageService.showTopUpMessage(
            'Success'.tr, 'New item added to cart'.tr);
      }
      saveToLocalStorage();
      update();
    } catch (e) {
      log('Error adding item to cart: $e');
    } finally {
      isLoading.value = false;
    }
  }

  int getQuantityOfProductInCart(String productId) {
    CartItem? cartItem = _cartItems.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem.empity(),
    );

    return cartItem.quantity ?? 0;
  }

  void removeItem(String id) {
    _cartItems.removeWhere((cartItem) => cartItem.product.id == id);
    calculateTotals(); // Update totals when an item is removed
    saveToLocalStorage();
    update();
  }

  void updateItemQuantity(String id, int newQuantity) {
    final cartItem =
        _cartItems.firstWhereOrNull((item) => item.product.id == id);
    if (cartItem != null && newQuantity > 0) {
      cartItem.quantity = newQuantity;
      calculateTotals();
      saveToLocalStorage();
      update();
    } else {
      messageService.showTopUpMessage('Error', 'Invalid item or quantity');
    }
  }

  void clearCart() {
    _cartItems.clear();
    calculateTotals();
    saveToLocalStorage();
    update();
  }

  Future<void> saveToLocalStorage() async {
    try {
      await _localStorageService.saveString(AppConstants.CART_ITEMS,
          _cartItems.map((item) => jsonEncode(item.toMap())).join(';'));
      log('Cart saved to local storage');
    } catch (e) {
      log('Error saving to local storage: $e');

      messageService.showTopUpMessage(
          'Error', 'Error saving cart to local storage');
    }
  }

  Future<void> loadFromLocalStorage() async {
    isLoading.value = true;
    try {
      String? data = _localStorageService.getString(AppConstants.CART_ITEMS);
      if (data != null && data.isNotEmpty) {
        var cartStringList = data.split(';').where((item) => item.isNotEmpty);
        var loadedItems = cartStringList.map((itemString) {
          return CartItem.fromJson(jsonDecode(itemString));
        }).toList();

        _cartItems.assignAll(loadedItems);

        getOtherServices(_cartItems.map((item) => item.product.id).toList());
        calculateTotals();
      }
    } catch (e) {
      log('Error loading from local storage: $e');

      messageService.showTopUpMessage(
          'Error', 'Error loading cart from local storage');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  //get the other services
  void getOtherServices(List<String> ids) async {
    try {
      final result = await _productsRepo.getOtherServices(ids);
      _otherServices.value = result;
    } catch (error) {
      log('Error fetching products getOtherServices: $error');
      rethrow;
    }
  }

  void handleAddon(Addon addonChange) {
    if (addonChange.modifiers.isEmpty) {
      selectedAddons.value = selectedAddons
          .where((addon) => addon.addonId != addonChange.addonId)
          .toList();
    } else {
      var updatedSelectedAddons = selectedAddons
          .where((addon) => addon.addonId != addonChange.addonId)
          .toList();

      updatedSelectedAddons.add(addonChange);

      selectedAddons.value = updatedSelectedAddons;
    }
  }
}
