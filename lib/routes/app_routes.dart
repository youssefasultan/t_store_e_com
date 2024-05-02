import 'package:get/get.dart';
import 'package:t_store_e_com/features/authentication/screens/login/login.dart';
import 'package:t_store_e_com/features/authentication/screens/onboarding/onboarding.dart';
import 'package:t_store_e_com/features/authentication/screens/password_config.dart/forget_password.dart';
import 'package:t_store_e_com/features/authentication/screens/signup/signup.dart';
import 'package:t_store_e_com/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store_e_com/features/personalization/screens/address/address.dart';
import 'package:t_store_e_com/features/personalization/screens/profile/profile.dart';
import 'package:t_store_e_com/features/personalization/screens/settings/settings.dart';
import 'package:t_store_e_com/features/shop/screens/cart/cart.dart';
import 'package:t_store_e_com/features/shop/screens/checkout/checkout.dart';
import 'package:t_store_e_com/features/shop/screens/home/home.dart';
import 'package:t_store_e_com/features/shop/screens/order/order.dart';
import 'package:t_store_e_com/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:t_store_e_com/features/shop/screens/store/store.dart';
import 'package:t_store_e_com/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    // GetPage(name: TRoutes.favorites, page: () => const FavouriteScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),
    GetPage(
        name: TRoutes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const AddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignUpScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
        name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];
}
