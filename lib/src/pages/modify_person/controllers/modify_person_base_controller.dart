import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taav_map/taav_map_api.dart';
import 'package:taav_ui/taav_ui.dart';

import '../../shared/models/enum/page_status.dart';
import '../models/state_view_model.dart';
import '../repositories/modify_person_repository.dart';

abstract class ModifyPersonBaseController extends GetxController {
  StateViewModel state = StateViewModel(id: 3939, name: 'فارس', countryId: 103);

  Rxn<FilePreviewConfig> imageConfig = Rxn();

  FileDetails? fileDetails;

  RxString imageString = ''.obs;

  TextEditingController nameTextController = TextEditingController(),
      nationalIdTextController = TextEditingController(),
      countryCodePickerTextController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  RxBool genderValue = RxBool(true);

  TaavCountryCode initialCountryCode = TaavCountryCode(code: 98);

  GregorianDate birthday = GregorianDate.now();

  Rxn<LatLng> selectedPoint = Rxn();

  Rx<PageStatus> pageStatus = Rx<PageStatus>(PageStatus.success);

  final ModifyPersonRepository _repository = ModifyPersonRepository();

  Future<void> onPickerIconTap(BuildContext context) async {
    final FileDetails? result = await TaavImagePicker(context).pickSingle();

    final Uint8List byte = await result!.readAsBytes();
    imageString.value = base64Encode(byte);
    fileDetails = result.isNot_null ? result : null;

    if (fileDetails != null) {
      imageConfig.value =
          FilePreviewConfig.memory(base64Decode(imageString.value));
    }
  }

  void onDeleteIconTap() {
    imageConfig.value = null;
  }

  void onRetryTap() {
    getPerson();
  }

  Future<List<StateViewModel>> getCountries(
    final String searchText,
    final int page,
  ) async {
    final result = await _repository.getCountry(
      searchText: searchText,
      page: page,
    );

    return result.right ?? [];
  }

  void onCountrySelected(List<StateViewModel>? value) {
    if (value == null) {
      return;
    }

    state = value.first;
  }

  void onGenderChanged({final bool? isMale}) {
    genderValue.value = isMale ?? true;
  }

  void getPerson();

  void onRegisterPressed();
}
