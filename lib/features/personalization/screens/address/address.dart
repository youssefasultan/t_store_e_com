import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_e_com/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store_e_com/features/personalization/controllers/address_controller.dart';
import 'package:t_store_e_com/features/personalization/screens/address/add_new_address.dart';
import 'package:t_store_e_com/features/personalization/screens/address/widgets/single_address_card.dart';
import 'package:t_store_e_com/utils/constants/colors.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/cloud_helper_functions.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: CustomAppBar(
        title:
            Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.allUserAddress(),
              builder: (context, snapshot) {
                final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (widget != null) return widget;

                final addresses = snapshot.data!;

                return ListView.builder(
                  itemCount: addresses.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => SingleAddressCard(
                      address: addresses[index],
                      onTap: () => controller.selectAddress(addresses[index])),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: const Icon(
          Iconsax.add,
          color: TColors.white,
        ),
      ),
    );
  }
}
