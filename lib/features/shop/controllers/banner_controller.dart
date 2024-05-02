import 'package:get/get.dart';
import 'package:t_store_e_com/data/repos/banners/banners_repo.dart';
import 'package:t_store_e_com/features/shop/models/banner_model.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class BannerController extends GetxController {
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final bannerRepo = Get.put(BannerRepo());

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updateCarouselIndex(index) {
    carousalCurrentIndex.value = index;
  }

  // fetch Banner
  Future<void> fetchBanners() async {
    try {
      // show loader
      isLoading.value = true;

      // fetch banners
      final banners = await bannerRepo.fetchBanners();

      // assign banners
      this.banners.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'OH SHIT', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
