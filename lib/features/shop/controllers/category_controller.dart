import 'package:get/get.dart';
import 'package:t_store_e_com/data/repos/categories/category_repo.dart';
import 'package:t_store_e_com/data/repos/products/products_repo.dart';
import 'package:t_store_e_com/features/shop/models/category_model.dart';
import 'package:t_store_e_com/features/shop/models/product_model.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _catergoryRepo = Get.put(CategoryRepo());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// load categories
  Future<void> fetchCategories() async {
    try {
      // show loader
      isLoading.value = true;

      // fetch categories
      final categories = await _catergoryRepo.getAllCategories();

      // update categories
      allCategories.assignAll(categories);

      // filter categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// load selected category data
  Future<List<CategoryModel>> getSubCategoryProducts(String categoryId) async {
    try {
      final subCategory = await _catergoryRepo.getSubCategories(categoryId);

      return subCategory;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
      return [];
    }
  }

  /// get category or sub category products
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = -1}) async {
    try {
      final products = await ProductsRepo.instance
          .getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
      return [];
    }
  }
}
