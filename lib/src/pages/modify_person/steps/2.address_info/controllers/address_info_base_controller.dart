import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taav_map/taav_map_api.dart';

import '../../../../shared/models/state_view_model.dart';
import '../models/address_info_update_dto.dart';
import '../models/state_dto.dart';
import '../repositories/address_info_base_repository.dart';
import '../repositories/address_info_insert_repository.dart';

abstract class AddressInfoBaseController extends GetxController {
  final _repository = AddressInfoBaseRepository();
  final _repository2 = AddressInfoInsertRepository();

  GlobalKey<FormState> formKey = GlobalKey();

  Rxn<LatLng> selectedPoint = Rxn();
  Rx<StateViewModel> state = Rx<StateViewModel>(
    StateViewModel(id: 3939, name: 'فارس', countryId: 103),
  );

  Future<void> onRegisterPressed(String id) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    final StateDto stateDto = StateDto(
      id: state.value.id,
      countryId: state.value.countryId,
      name: state.value.name,
    );
    final AddressInfoUpdateDto dto = AddressInfoUpdateDto(
      id: id,
      state: stateDto,
      lat: selectedPoint.value?.latitude.toString() ?? '',
      long: selectedPoint.value?.longitude.toString() ?? '',
    );
    final result = await _repository2.patchPerson(dto: dto);
    result.fold(
      Left.new,
      (r) => Get.back(result: r),
    );
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

    state.value = value.first;
  }
}
