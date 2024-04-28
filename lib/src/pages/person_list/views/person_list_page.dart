import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taav_bootstrap/taav_bootstrap.dart';
import 'package:taav_ui/taav_ui.dart';

import '../../shared/models/person_view_model.dart';
import '../controllers/person_list_controller.dart';
import 'widgets/person_list_item.dart';

class PersonListPage extends GetView<PersonListController> {
  const PersonListPage({super.key});

  @override
  Widget build(BuildContext context) => TaavScaffold(
        appBar: _appBar(),
        floatingActionButton: _floatingActionButton(),
        body: Obx(() => _body(context)),
      );

  Widget _body(BuildContext context) => Breakpoint.either(
        context,
        breakpoint: Breakpoint.largeTablet,
        before: smallSize,
        after: largeSize,
      );

  Widget smallSize() => TaavListView<PersonViewModel>(
        key: controller.listKey,
        items: controller.personList,
        itemBuilder: _itemBuilder,
        onRefreshData: controller.updateList,
        showError: controller.showError.value,
        emptyText: 'No item found.',
      );

  Widget largeSize() => TaavGridView<PersonViewModel>(
        key: controller.gridKey,
        items: controller.personList,
        itemBuilder: _itemBuilder,
        crossAxisItemSize: 300,
        crossAxisCount: const CrossAxisCount(xs: 2, lg: 4),
        onRefreshData: controller.updateList,
        showError: controller.showError.value,
        emptyText: 'No item found.',
      );

  Widget _itemBuilder(_, PersonViewModel item, int index) => PersonListItem(
        item: item,
        onSubmit: () => controller.onEditPressed(item: item, index: index),
      );

  Widget _floatingActionButton() => TaavIconButton(
        onTap: controller.onAddButtonTap,
        icon: FontAwesomeIcons.plus,
      );

  AppBar _appBar() => AppBar(
        title: const TaavText.heading5('Person List'),
        backgroundColor: Colors.teal,
      );
}
