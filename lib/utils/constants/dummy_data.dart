import 'package:t_store_e_com/features/shop/models/banner_model.dart';
import 'package:t_store_e_com/features/shop/models/category_model.dart';
import 'package:t_store_e_com/routes/routes.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';

class DummyData {
  static final List<BannerModel> banners = [
    BannerModel(
        imageUrl: TImages.banner1, targetScreen: TRoutes.order, active: false),
    BannerModel(
        imageUrl: TImages.banner2, targetScreen: TRoutes.cart, active: true),
    BannerModel(
        imageUrl: TImages.banner3,
        targetScreen: TRoutes.favorites,
        active: true),
    BannerModel(
        imageUrl: TImages.banner4, targetScreen: TRoutes.search, active: true),
    BannerModel(
        imageUrl: TImages.banner5,
        targetScreen: TRoutes.settings,
        active: true),
    BannerModel(
        imageUrl: TImages.banner6,
        targetScreen: TRoutes.userAddress,
        active: true),
    BannerModel(
        imageUrl: TImages.banner8, targetScreen: TRoutes.order, active: false),
  ];

  static final List<CategoryModel> categories = [
    /// categories
    CategoryModel(
      id: '1',
      name: 'Sports',
      image: TImages.sportIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '5',
      name: 'furniture',
      image: TImages.furnitureIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '2',
      name: 'Electronics',
      image: TImages.electronicsIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '3',
      name: 'Clothes',
      image: TImages.clothIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '4',
      name: 'Animals',
      image: TImages.animalIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '6',
      name: 'Shoes',
      image: TImages.shoeIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '7',
      name: 'Cosmetics',
      image: TImages.cosmeticsIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '14',
      name: 'Jewelry',
      image: TImages.jeweleryIcon,
      isFeatured: true,
    ),

    /// sub-categories
    // sports
    CategoryModel(
      id: '8',
      name: 'Sport Shoes',
      image: TImages.sportIcon,
      parentId: '1',
      isFeatured: false,
    ),
    CategoryModel(
      id: '9',
      name: 'Track Suits',
      image: TImages.sportIcon,
      parentId: '1',
      isFeatured: false,
    ),
    CategoryModel(
      id: '10',
      name: 'Sport Equipments',
      image: TImages.sportIcon,
      parentId: '1',
      isFeatured: false,
    ),
    // furniture
    CategoryModel(
      id: '11',
      name: 'Bedroom',
      image: TImages.furnitureIcon,
      parentId: '5',
      isFeatured: false,
    ),
    CategoryModel(
      id: '12',
      name: 'Kitchen',
      image: TImages.furnitureIcon,
      parentId: '5',
      isFeatured: false,
    ),
    CategoryModel(
      id: '13',
      name: 'Office',
      image: TImages.furnitureIcon,
      parentId: '5',
      isFeatured: false,
    ),

    // electronics
    CategoryModel(
      id: '14',
      name: 'Laptops',
      image: TImages.electronicsIcon,
      parentId: '2',
      isFeatured: false,
    ),
    CategoryModel(
      id: '15',
      name: 'Mobiles',
      image: TImages.electronicsIcon,
      parentId: '2',
      isFeatured: false,
    ),
  ];
}
