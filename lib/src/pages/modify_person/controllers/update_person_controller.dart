import 'dart:convert';

import 'package:get/get.dart';
import 'package:taav_map/taav_map_api.dart';
import 'package:taav_ui/taav_ui.dart';

import '../../shared/models/enum/page_status.dart';
import '../models/person_dto.dart';
import '../models/state_dto.dart';
import '../repositories/modify_person_repository.dart';
import 'modify_person_base_controller.dart';

class UpdatePersonController extends ModifyPersonBaseController {
  UpdatePersonController({required this.personId});

  String personId;

  final ModifyPersonRepository _repository = ModifyPersonRepository();

  @override
  void onInit() {
    super.onInit();
    getPerson();
  }

  @override
  Future<void> onRegisterPressed() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    final StateDto stateDto =
        StateDto(id: state.id, countryId: state.countryId, name: state.name);
    final PersonDto dto = PersonDto(
      id: personId,
      name: nameTextController.text,
      nationalId: nationalIdTextController.text,
      gender: genderValue.value,
      image: imageString.value,
      mobile: countryCodePickerTextController.text,
      state: stateDto,
      birthday: birthday.toIso8601String(),
      lat: selectedPoint.value?.latitude.toString() ?? '',
      long: selectedPoint.value?.longitude.toString() ?? '',
    );
    final result = await _repository.patchPerson(dto: dto);
    Get.back(result: result.right);
  }

  @override
  Future<void> getPerson() async {
    super.pageStatus.value = PageStatus.loading;
    final result = await _repository.getPerson(id: personId);
    result.fold((l) {
      super.pageStatus.value = PageStatus.error;
    }, (r) {
      super.pageStatus.value = PageStatus.success;
      super.nameTextController.text = r.name;
      super.birthday = GregorianDate.parse(r.birthday);
      super.state = r.state;
      super.nationalIdTextController.text = r.nationalId;
      super.countryCodePickerTextController.text = r.mobile;
      super.genderValue.value = r.gender;
      if (r.image != '') {
        super.imageConfig.value =
            FilePreviewConfig.memory(base64Decode(r.image));
      }
      super.imageString.value = r.image;
      super.selectedPoint.value =
          LatLng(double.parse(r.lat), double.parse(r.long));
    });
  }
}
