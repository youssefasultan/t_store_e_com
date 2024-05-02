import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/success/sucess_screen.dart';
import 'package:t_store_e_com/data/repos/auth/auth_repo.dart';
import 'package:t_store_e_com/data/repos/order/order_repo.dart';
import 'package:t_store_e_com/features/personalization/controllers/address_controller.dart';
import 'package:t_store_e_com/features/shop/controllers/cart_controller.dart';
import 'package:t_store_e_com/features/shop/controllers/product/checkout_controller.dart';
import 'package:t_store_e_com/features/shop/models/order_model.dart';
import 'package:t_store_e_com/navigation_menu.dart';
import 'package:t_store_e_com/utils/constants/enums.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/popups/full_screen_loader.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepo = Get.put(OrderRepo());

  Future<List<OrderModel>> fetchUSerOrders() async {
    try {
      return await orderRepo.fetchUserOrders();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh SHIT', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processin your order', TImages.pencilAnimation);

      final userId = AuthRepo.instance.authUser!.uid;
      if (userId.isEmpty) return;

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      await orderRepo.saveOrder(order, userId);

      cartController.clearCart();

      Get.off(
        () => SucessScreen(
          image: TImages.orderCompletedAnimation,
          title: 'Payment sucessfull',
          subTitle: 'your item will be shipped',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh SHIT', message: e.toString());
    }
  }
}
