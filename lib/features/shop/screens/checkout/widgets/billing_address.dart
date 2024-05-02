import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/features/personalization/controllers/address_controller.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'ShippingAddress',
          buttonTitle: 'Change',
          onActionButtonPressed: () =>
              addressController.selectNewAddressPopUp(context),
        ),
        if (addressController.selectedAddress.value.id.isNotEmpty)
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(addressController.selectedAddress.value.name,
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),
                    Text(
                      addressController.selectedAddress.value.phoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(
                      Icons.location_history,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),
                    Expanded(
                      child: Text(
                        addressController.selectedAddress.value.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        else
          Text(
            'Select Address',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }
}
