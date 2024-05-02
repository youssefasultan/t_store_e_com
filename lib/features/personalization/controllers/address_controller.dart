import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_e_com/common/widgets/loaders/circular_loader.dart';
import 'package:t_store_e_com/common/widgets/texts/seaction_header.dart';
import 'package:t_store_e_com/data/repos/address/address_repo.dart';
import 'package:t_store_e_com/features/personalization/models/address_model.dart';
import 'package:t_store_e_com/features/personalization/screens/address/add_new_address.dart';
import 'package:t_store_e_com/features/personalization/screens/address/widgets/single_address_card.dart';
import 'package:t_store_e_com/utils/constants/image_strings.dart';
import 'package:t_store_e_com/utils/constants/sizes.dart';
import 'package:t_store_e_com/utils/helpers/cloud_helper_functions.dart';
import 'package:t_store_e_com/utils/helpers/network_manager.dart';
import 'package:t_store_e_com/utils/popups/full_screen_loader.dart';
import 'package:t_store_e_com/utils/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final addressRepo = Get.put(AddressRepo());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;

  Future<List<AddressModel>> allUserAddress() async {
    try {
      final addresses = await addressRepo.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Adderss not found!', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel address) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const TCircularLoader(),
      );

      // clear the selected address from db

      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepo.updateSelectedFeild(selectedAddress.value.id, false);
      }

      // assign selected address
      address.selectedAddress = true;
      selectedAddress.value = address;
      // set selected feild to true
      await addressRepo.updateSelectedFeild(selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error in Selection', message: e.toString());
    }
  }

  Future addNewAddress() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Stroung Address..', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        name: name.text.trim(),
        id: '',
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepo.addAddress(address);

      address.id = id;
      await selectAddress(address);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'OH YEAH',
        message: 'Address has been added successfully',
      );

      refreshData.toggle();

      resetFormFeilds();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'OH SHIT',
        message: e.toString(),
      );
    }
  }

  Future<dynamic> selectNewAddressPopUp(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
                title: 'Select Address', showActionButton: false),
            FutureBuilder(
              future: allUserAddress(),
              builder: (_, snapshot) {
                final response = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) => SingleAddressCard(
                    address: snapshot.data![index],
                    onTap: () async {
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: TSizes.defaultSpace / 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const AddNewAddressScreen()),
                child: const Text('Add New Address'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetFormFeilds() {
    name.clear();
    phoneNumber.clear();
    state.clear();
    street.clear();
    city.clear();
    postalCode.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
