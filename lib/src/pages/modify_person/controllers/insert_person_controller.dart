import 'package:get/get.dart';
import 'package:taav_ui/taav_ui.dart';

import '../models/person_dto.dart';
import '../models/state_dto.dart';
import '../repositories/modify_person_repository.dart';
import 'modify_person_base_controller.dart';

class InsertPersonController extends ModifyPersonBaseController {
  final ModifyPersonRepository _repository = ModifyPersonRepository();

  @override
  Future<void> onRegisterPressed() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    final StateDto stateDto =
        StateDto(id: state.id, name: state.name, countryId: state.countryId);
    final PersonDto dto = PersonDto(
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
    final result = await _repository.postPerson(dto: dto);
    Get.back(result: result.right);
  }

  @override
  void getPerson() => emptyCallback();
}
