import 'dart:convert';

import 'package:get/get.dart';
import 'package:t_store_e_com/data/repos/products/products_repo.dart';
import 'package:t_store_e_com/features/shop/models/product_model.dart';
import 'package:t_store_e_com/utils/local_storage/storage_utilities.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();

    initFavorties();
  }

  Future<void> initFavorties() async {
    final json = TLocalStroage.instance().readDate('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;

      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoritesProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      TLoaders.customToast(message: 'Product has been added to wishlist');
    } else {
      TLocalStroage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      TLoaders.customToast(message: 'Product has been removed from wishlist');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = jsonEncode(favorites);
    TLocalStroage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductsRepo.instance
        .getFavoriteProducts(favorites.keys.toList());
  }
}
