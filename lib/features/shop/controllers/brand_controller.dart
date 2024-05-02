import 'package:get/get.dart';
import 'package:t_store_e_com/data/repos/brands/brands_repo.dart';
import 'package:t_store_e_com/data/repos/products/products_repo.dart';
import 'package:t_store_e_com/features/shop/models/brand_model.dart';
import 'package:t_store_e_com/features/shop/models/product_model.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = false.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepo = Get.put(BrandsRepo());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  // -- load brands
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;

      final brands = await brandRepo.getAllBrands();

      allBrands.assignAll(brands);
      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // -- get brands for category

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepo.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
      return [];
    }
  }

  // get brand specific products  from your data source

  Future<List<ProductModel>> getBrandProducts(
      {required String id, int limit = -1}) async {
    try {
      final products =
          await ProductsRepo.instance.getProductsForBrand(id: id, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
      return [];
    }
  }
}
