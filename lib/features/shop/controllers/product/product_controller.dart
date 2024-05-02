import 'package:get/get.dart';
import 'package:t_store_e_com/data/repos/products/products_repo.dart';
import 'package:t_store_e_com/features/shop/models/product_model.dart';
import 'package:t_store_e_com/utils/constants/enums.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final isLoading = false.obs;
  final productRepo = Get.put(ProductsRepo());

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;

      // fetch products

      final products = await productRepo.getFeaturedProducts();

      // assign products
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      // fetch products

      final products = await productRepo.getAllFeaturedProducts();
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
      return [];
    }
  }

  // get product price
  String getProductPrice(ProductModel productModel) {
    double smallestPrice = double.infinity;
    double lagestprice = 0.0;

    if (productModel.productType == ProductType.single.toString()) {
      return (productModel.salePrice > 0
              ? productModel.salePrice
              : productModel.price)
          .toString();
    } else {
      for (var variation in productModel.productVariations!) {
        // determine the price of variation
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // update range
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > lagestprice) {
          lagestprice = priceToConsider;
        }
      }

      if (smallestPrice.isEqual(lagestprice)) {
        return lagestprice.toString();
      } else {
        return '$smallestPrice - $lagestprice';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0.0) return null;

    return (((originalPrice - salePrice) / originalPrice) * 100)
        .toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
