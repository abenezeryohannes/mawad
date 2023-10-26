import 'package:get/get.dart';
import 'package:mawad/src/core/constants/contants.dart';
import 'package:mawad/src/core/models/cart_item.dart';
import 'package:mawad/src/data/services/localstorage_service.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = RxList<CartItem>();
  final LocalStorageService _localStorageService = LocalStorageService();

  @override
  void onInit() {
    super.onInit();
    _localStorageService.initialize();
    loadFromLocalStorage();
  }

  void addItem(CartItem item) {
    if (cartItems.any((cartItem) => cartItem.id == item.id)) {
      var foundItem =
          cartItems.firstWhere((cartItem) => cartItem.id == item.id);
      foundItem.quantity++;
    } else {
      cartItems.add(item);
    }
    saveToLocalStorage();
    update();
  }

  void removeItem(String id) {
    cartItems.removeWhere((cartItem) => cartItem.id == id);
    saveToLocalStorage();
    update();
  }

  void updateItemQuantity(String id, int newQuantity) {
    var foundItem = cartItems.firstWhere((cartItem) => cartItem.id == id);
    foundItem.quantity = newQuantity;
    saveToLocalStorage();
    update();
  }

  void clearCart() {
    cartItems.clear();
    saveToLocalStorage();
    update();
  }

  Future<void> saveToLocalStorage() async {
    List<String> cartStringList = cartItems
        .map((item) =>
            '${item.id}||${item.title}||${item.price}||${item.imageUrl}||${item.quantity}')
        .toList();
    await _localStorageService.saveString(
        AppConstants.CART_ITEMS, cartStringList.join(';'));
  }

  Future<void> loadFromLocalStorage() async {
    String? data = _localStorageService.getString(AppConstants.CART_ITEMS);
    if (data != null && data.isNotEmpty) {
      List<String> cartStringList = data.split(';');
      cartItems = cartStringList
          .map((itemString) {
            var split = itemString.split('||');
            return CartItem(
              id: split[0],
              title: split[1],
              price: double.parse(split[2]),
              imageUrl: split[3],
              quantity: int.parse(split[4]),
            );
          })
          .toList()
          .obs;
      update();
    }
  }
}
