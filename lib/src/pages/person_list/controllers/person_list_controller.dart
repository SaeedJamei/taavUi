import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taav_ui/taav_ui.dart';

import '../../../infrastructiors/route/route_names.dart';
import '../../shared/models/person_view_model.dart';
import '../repositories/person_list_repository.dart';

class PersonListController extends GetxController {
  GlobalKey<TaavListViewState<PersonViewModel>> listKey = GlobalKey();
  GlobalKey<TaavGridViewState<PersonViewModel>> gridKey = GlobalKey();
  RxList<PersonViewModel> personList = <PersonViewModel>[].obs;
  RxBool showError = RxBool(false);
  final PersonListRepository _repository = PersonListRepository();

  @override
  void onInit() {
    super.onInit();
    updateList();
  }

  Future<void> onAddButtonTap() async {
    final result = await Get.toNamed<dynamic>(
      '${RouteNames.personList}${RouteNames.insertPerson}',
    );

    if (result is! PersonViewModel) {
      return;
    }

    gridKey.currentState?.addItem(result);
    listKey.currentState?.addItem(result);
  }

  void onRetryTap() {
    updateList();
  }

  Future<void> updateList() async {
    showError.value = false;
    final result = await _repository.getPersons();

    result.fold(
      (left) => showError.value = true,
      (right) {
        listKey.currentState?.clearAllItems();
        gridKey.currentState?.clearAllItems();
        listKey.currentState?.addAll(right);
        gridKey.currentState?.addAll(right);
      },
    );
  }

  Future<void> onEditPressed({
    required PersonViewModel item,
    required int index,
  }) async {
    const TaavRoute route = TaavRoute(
      '${RouteNames.personList}${RouteNames.updatePerson}',
    );

    final result = await route.toName<dynamic>(parameters: {'id': item.id});

    if (result is! PersonViewModel) {
      return;
    }

    gridKey.currentState?[index] = result;
    listKey.currentState?[index] = result;
  }
}
