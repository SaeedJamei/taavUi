import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taav_bootstrap/taav_bootstrap.dart';
import 'package:taav_ui/taav_ui.dart';

import '../../shared/models/person_view_model.dart';
import '../controllers/person_list_controller.dart';

class PersonListPage extends GetView<PersonListController> {
  const PersonListPage({super.key});

  @override
  Widget build(BuildContext context) => TaavScaffold(
        appBar: AppBar(
          title: const TaavText.heading5('Person List'),
          backgroundColor: Colors.teal,
        ),
        floatingActionButton: TaavIconButton(
          onTap: controller.onAddButtonTap,
          icon: FontAwesomeIcons.plus,
        ),
        body: Obx(
          () => _body(context),
        ),
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
        itemBuilder: (context, item, index) => _items(item, index),
        onRefreshData: _onRefreshData,
        showError: controller.showError.value,
        emptyText: 'it\'s empty',
      );

  Padding _items(PersonViewModel item, int index) => Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TaavFilePreview.memory(
            base64Decode(item.image),
            fileExtension: 'jpg',
            showOptionsMenu: false,
            showImageRetry: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TaavText.heading5(item.name),
              TaavText.body1(item.nationalId),
            ],
          ),
          TaavButton.outline(
            onTap: () => controller.onEditPressed(item, index),
            label: 'Edit',
          ),
          const TaavDivider(),
        ],
      ),
    );

  Widget largeSize() => TaavGridView<PersonViewModel>(
        key: controller.gridKey,
        items: controller.personList,
        itemBuilder: (context, item, index) => _items(item, index),
        crossAxisItemSize: 300,
        crossAxisCount: const CrossAxisCount(xs: 2, lg: 4),
        onRefreshData: _onRefreshData,
        showError: controller.showError.value,
        emptyText: 'it\'s empty',
      );

  Future<void> _onRefreshData() async{
    await controller.updateList();
  }
}
