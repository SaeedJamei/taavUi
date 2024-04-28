import 'package:either_dart/either.dart';

import '../models/basic_info_insert_dto.dart';
import '../repositories/basic_info_insert_repository.dart';
import 'basic_info_base_controller.dart';

class BasicInfoInsertController extends BasicInfoBaseController {
  final _repository = BasicInfoInsertRepository();

  @override
  Future<void> onRegisterPressed(void Function(String) callBackId) async {
    if (!(formKey1.currentState?.validate() ?? false)) {
      return;
    }
    final BasicInfoInsertDto basicInfoInsertDto = BasicInfoInsertDto(
      name: nameTextController.text,
      gender: genderValue.value,
      image: imageString.value,
      mobile: countryCodePickerTextController.text,
      nationalId: nationalIdTextController.text,
      birthday: birthday.toIso8601String(),
    );

    final result = await _repository.postPerson(dto: basicInfoInsertDto);
    result.fold(
      Left.new,
      (r) {
        callBackId(r['id']);
      },
    );
  }
}
