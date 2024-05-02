import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/features/shop/models/payment_method_model.dart';
import 'package:t_store_e_com/features/shop/screens/checkout/widgets/payment_method_tile.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'PayPal', img: TImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.lg),
            child: Column(
              children: [
                const SectionHeader(
                    title: 'Select Payment Method', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwSections),
                PAymentMethodTile(
                  payment: PaymentMethodModel(
                    name: 'PayPal',
                    img: TImages.paypal,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PAymentMethodTile(
                  payment: PaymentMethodModel(
                    name: 'Google Pay',
                    img: TImages.googlePay,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PAymentMethodTile(
                  payment: PaymentMethodModel(
                    name: 'Apple Pay',
                    img: TImages.applePay,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PAymentMethodTile(
                  payment: PaymentMethodModel(
                    name: 'Visa',
                    img: TImages.visa,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems/2),
                PAymentMethodTile(
                  payment: PaymentMethodModel(
                    name: 'Master Card',
                    img: TImages.masterCard,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),
        );
      },
    );
  }
}
