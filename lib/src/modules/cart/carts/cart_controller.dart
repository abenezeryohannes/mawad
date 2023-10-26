import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/products.dart';
import 'package:mawad/src/data/services/localstorage_service.dart';
import 'package:mawad/src/data/services/message_services.dart';

class CartController extends GetxController {
  RxList<Product> _cartItems = RxList<Product>();
  final LocalStorageService _localStorageService = LocalStorageService();
  final messageService = MessageService();
  List<Product> get cartItems => _cartItems;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _localStorageService.initialize();
    loadFromLocalStorage();
    log(_cartItems.toString());
  }

  void addItem(Product item) {
    isLoading.value = true;
    try {
      if (!_cartItems.any((cartItem) => cartItem.id == item.id)) {
        _cartItems.add(item);
        saveToLocalStorage();

        isLoading.value = false;
        messageService.showTopUpMessage('Success', 'Item added to cart');
      } else {
        isLoading.value = false;
        messageService.showTopUpMessage('Error', 'Item already in cart');
      }
    } catch (e) {
      messageService.showTopUpMessage('Error', 'Error adding item to cart');
    }
  }

  void removeItem(String id) {
    try {
      _cartItems.removeWhere((cartItem) => cartItem.id == id);
      saveToLocalStorage();
      update();
    } catch (e) {
      messageService.showTopUpMessage('Error', 'Error removing item from cart');
    }
  }

  void updateItemQuantity(String id, int newQuantity) {
    try {
      saveToLocalStorage();
      update();
    } catch (e) {
      // TODO: Handle exception by showing some feedback to the user
    }
  }

  void clearCart() {
    try {
      _cartItems.clear();
      saveToLocalStorage();
      update();
    } catch (e) {
      // TODO: Handle exception by showing some feedback to the user
    }
  }

  Future<void> saveToLocalStorage() async {
    try {
      List<String> cartStringList =
          _cartItems.map((item) => jsonEncode(item.toMap())).toList();
      await _localStorageService.saveString(
          AppConstants.CART_ITEMS, cartStringList.join(';'));
    } catch (e) {
      // TODO: Handle exception by showing some feedback to the user
    }
  }

  Future<void> loadFromLocalStorage() async {
    try {
      String? data = _localStorageService.getString(AppConstants.CART_ITEMS);
      if (data != null && data.isNotEmpty) {
        List<String> cartStringList = data.split(';');
        _cartItems = cartStringList
            .map((itemString) => Product.fromJson(jsonDecode(itemString)))
            .toList()
            .obs;
        update();
      }
    } catch (e) {
      // TODO: Handle exception by showing some feedback to the user
    }
  }
}
