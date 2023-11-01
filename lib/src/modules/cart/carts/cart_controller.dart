import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/data/services/localstorage_service.dart';
import 'package:mawad/src/data/services/message_services.dart';

class CartController extends GetxController {
  final RxList<CartItem> _cartItems = RxList<CartItem>();
  final LocalStorageService _localStorageService = LocalStorageService();
  final messageService = MessageService();
  List<CartItem> get cartItems => _cartItems;
  final isLoading = false.obs;
  var subtotal = 0.0.obs;
  var shippingFees = 0.0.obs;
  var total = 0.0.obs;
  double standardShippingFee = 10.0; // set a fixed shipping fee
  double freeShippingThreshold =
      100.0; // free shipping for orders above this amount

  @override
  void onInit() {
    super.onInit();
    _localStorageService.initialize();
    loadFromLocalStorage();
    ever(_cartItems, (_) => calculateTotals());
  }

  void calculateTotals() {
    subtotal.value = _cartItems.fold(0,
        (total, current) => total + (current.product.price * current.quantity));

    // Calculate shipping based on rules, e.g., free shipping over a certain amount
    if (subtotal.value > freeShippingThreshold) {
      shippingFees.value = 0.0;
    } else {
      shippingFees.value =
          standardShippingFee; // This could also be dynamic based on items or user location
    }

    total.value = subtotal.value + shippingFees.value;
  }

  // Add other methods for cart management like addItem(), removeItem(), clearCart(), etc.

  void addItem(CartItem item) {
    isLoading.value = true;
    log('Attempting to add item: ${item.product.nameEng}');
    try {
      // Check if the item is already in the cart
      int index = _cartItems
          .indexWhere((cartItem) => cartItem.product.id == item.product.id);
      if (index != -1) {
        log('Item already in cart. No changes made to quantity.');
      } else {
        // New item, add to cart with its initial quantity
        _cartItems.add(item);
        log('New item added to cart: ${item.product.nameEng}');
        messageService.showTopUpMessage('Success', 'New item added to cart');
      }
      saveToLocalStorage();
      update(); // Ensure UI is updated with new cart state
    } catch (e) {
      log('Error adding item to cart: $e');
      messageService.showTopUpMessage('Error', 'Error adding item to cart: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void removeItem(String id) {
    try {
      _cartItems.removeWhere((cartItem) => cartItem.product.id == id);
      saveToLocalStorage();
      update();
    } catch (e) {
      messageService.showTopUpMessage('Error', 'Error removing item from cart');
    }
  }

  void updateItemQuantity(String id, int newQuantity) {
    try {
      final itemIndex = _cartItems.indexWhere((item) => item.product.id == id);
      if (itemIndex != -1) {
        _cartItems[itemIndex].quantity = newQuantity;
        saveToLocalStorage();
        calculateTotals();
        update(); // Notify listeners about changes
      }
    } catch (e) {
      messageService.showTopUpMessage('Error', 'Error updating item quantity');
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
      log('Cart saved: ${cartStringList.join(';')}');
    } catch (e) {
      log('Error saving to local storage: $e');
      // TODO: Handle exception by showing some feedback to the user
    }
  }

  Future<void> loadFromLocalStorage() async {
    isLoading.value = true;
    try {
      String? data = _localStorageService.getString(AppConstants.CART_ITEMS);
      calculateTotals();
      if (data != null && data.isNotEmpty) {
        List<String> cartStringList = data.split(';');
        List<CartItem> loadedItems = [];

        for (String itemString in cartStringList) {
          if (itemString.isNotEmpty) {
            try {
              // Explicitly check if itemString is valid JSON
              final itemMap = jsonDecode(itemString);
              if (itemMap is! Map<String, dynamic>) {
                log('Invalid item format: $itemMap');
                continue; // Skip this item and go to the next one
              }
              loadedItems.add(CartItem.fromJson(itemMap));
            } catch (decodeError) {
              log('Error decoding item: $decodeError');
            }
          }
        }

        if (loadedItems.isNotEmpty) {
          _cartItems.assignAll(loadedItems);
        }
      }
    } catch (e) {
      log('Error loading from local storage: $e');
    } finally {
      isLoading.value = false;
      update(); // Notify listeners to update UI
    }
  }
}
