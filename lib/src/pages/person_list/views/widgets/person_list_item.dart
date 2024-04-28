import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taav_ui/taav_ui.dart';

import '../../../shared/models/person_view_model.dart';

class PersonListItem extends StatelessWidget {
  const PersonListItem({required this.item, required this.onSubmit, super.key});

  final PersonViewModel item;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _filePreview(item),
            _identityInfo(item),
            _actionButton(),
            const TaavDivider(),
          ],
        ),
      );

  Widget _actionButton() => TaavButton.outline(
        onTap: onSubmit,
        label: 'Edit',
      );

  Widget _identityInfo(PersonViewModel item) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TaavText.heading5(item.name),
          TaavText.body1(item.nationalId),
        ],
      );

  Widget _filePreview(PersonViewModel item) => TaavFilePreview.memory(
        base64Decode(item.image),
        fileExtension: 'jpg',
        showOptionsMenu: false,
        showImageRetry: false,
      );
}
