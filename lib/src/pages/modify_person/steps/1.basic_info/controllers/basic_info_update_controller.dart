import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:taav_ui/taav_ui.dart';

import '../models/basic_info_update_dto.dart';
import '../repositories/basic_info_update_repository.dart';
import 'basic_info_base_controller.dart';

class BasicInfoUpdateController extends BasicInfoBaseController {
  BasicInfoUpdateController({required this.id});

  final String id;

  final _repository = BasicInfoUpdateRepository();

  @override
  void onInit() {
    super.onInit();
    getPerson(id);
  }

  @override
  Future<void> onRegisterPressed(void Function(String p1) callBackId) async {
    if (!(formKey1.currentState?.validate() ?? false)) {
      return;
    }
    final BasicInfoUpdateDto basicInfoInsertDto = BasicInfoUpdateDto(
      id: id,
      name: nameTextController.text,
      gender: genderValue.value,
      image: imageString.value,
      mobile: countryCodePickerTextController.text,
      nationalId: nationalIdTextController.text,
      birthday: birthday.toIso8601String(),
    );

    final result = await _repository.patchPerson(dto: basicInfoInsertDto);
    result.fold(
      Left.new,
      (r) {
        callBackId(id);
      },
    );
  }

  Future<void> getPerson(String id) async {
    final result = await _repository.getPerson(id: id);
    result.fold(
      Left.new,
      (r) {
        nameTextController.text = r.name;
        nationalIdTextController.text = r.nationalId;
        birthday = GregorianDate.parse(r.birthday);
        countryCodePickerTextController.text = r.mobile;
        imageString.value = r.image;
        genderValue.value = r.gender;
        if (r.image != '') {
          imageConfig.value = FilePreviewConfig.memory(
            base64Decode(r.image),
          );
        }
      },
    );
  }
}
