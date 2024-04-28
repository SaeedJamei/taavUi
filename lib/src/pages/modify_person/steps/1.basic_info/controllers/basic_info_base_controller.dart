import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taav_ui/taav_ui.dart';

import '../../../../shared/models/enum/page_status.dart';

abstract class BasicInfoBaseController extends GetxController {
  GlobalKey<FormState> formKey1 = GlobalKey();

  TextEditingController nameTextController = TextEditingController(),
      nationalIdTextController = TextEditingController(),
      countryCodePickerTextController = TextEditingController();

  GregorianDate birthday = GregorianDate.now();
  TaavCountryCode initialCountryCode = TaavCountryCode(code: 98);

  RxString imageString = ''.obs;
  Rxn<FilePreviewConfig> imageConfig = Rxn();
  Rx<PageStatus> pageStatus = Rx<PageStatus>(PageStatus.success);
  RxBool genderValue = RxBool(true);

  Future<void> onPickerIconTap(BuildContext context) async {
    final result = await TaavImagePicker(context).pickSingle();
    if (result != null) {
      final Uint8List byte = await result.readAsBytes();
      imageString.value = base64Encode(byte);
    }

    if (imageString.value != '') {
      imageConfig.value =
          FilePreviewConfig.memory(base64Decode(imageString.value));
    }
  }

  void onDeleteIconTap() {
    imageConfig.value = null;
  }

  void onGenderChanged({final bool? isMale}) {
    genderValue.value = isMale!;
  }

  void onRegisterPressed(void Function(String) callBackId);

  void onDateTimeSelected(GregorianDate? date) {
    birthday = date!;
  }
}
