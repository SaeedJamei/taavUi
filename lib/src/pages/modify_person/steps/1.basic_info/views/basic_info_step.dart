import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taav_ui/taav_ui.dart';

import '../controllers/basic_info_base_controller.dart';

class BasicInfoStep<T extends BasicInfoBaseController> extends GetView<T> {
  const BasicInfoStep({required this.callBackId, super.key});

  final void Function(String) callBackId;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            _avatar(context),
            _vSpacer(),
            Form(
              key: controller.formKey1,
              child: Column(
                children: [
                  _name(),
                  _nationId(),
                  _mobile(),
                  _birthday(),
                  _genderRadio(),
                ],
              ),
            ),
            _vSpacer(),
            TaavButton.filled(
              label: 'register',
              onTap: () => controller.onRegisterPressed(callBackId),
            ),
          ],
        ),
      );

  Widget _vSpacer() => const SizedBox(
        height: 20,
      );

  Widget _birthday() => TaavCalendarPickerTextField(
        mode: TaavCalendarPickerMode.date,
        initialCalendarMode: TaavCalendarViewerMode.month,
        minDate: GregorianDate.now().add(const Duration(days: -20000)),
        initDate: GregorianDate.now().add(const Duration(days: -1)),
        selectedDate: controller.birthday,
        maxDate: GregorianDate.now().add(const Duration(days: 1)),
        hint: 'Date of your birthday',
        isRequired: true,
        requiredErrorMessage: 'this is required',
        onDateTimeSelected: controller.onDateTimeSelected,
        calendarMode: TaavCalendarMode.jalali,
      );

  Widget _mobile() => TaavCountryCodePicker(
        controller: controller.countryCodePickerTextController,
        requiredErrorMessage: 'mobile is required',
        invalidNumberMessage: 'invalid',
        isRequired: true,
        disableHint: true,
        label: 'Mobile',
        onCountryCodeSelected: (code) => controller.initialCountryCode = code,
        // initialCode: _initialCode,
        initialCountryCode: TaavCountryCode(code: 98),
      );

  Widget _nationId() => TaavTextField(
        label: 'National-id',
        controller: controller.nationalIdTextController,
        taavInputFormatter: TaavInputFormatter.digit,
        isRequired: true,
        requiredErrorMessage: 'this is required',
      );

  Widget _name() => TaavTextField(
        label: 'Name',
        controller: controller.nameTextController,
        isRequired: true,
        requiredErrorMessage: 'this is required',
      );

  Widget _avatar(BuildContext context) => Obx(
        () => TaavAvatarPicker.image(
          imageConfig: controller.imageConfig.value,
          size: const Size(120, 120),
          deleteIconSize: TaavWidgetSize.tiny,
          pickerIconSize: TaavWidgetSize.small,
          shape: BoxShape.circle,
          showOnDeleteDialog: true,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          onDeleteIconTap: controller.onDeleteIconTap,
          defaultImage: const ColoredBox(color: TaavColors.grey),
          onPickerIconTap: () => controller.onPickerIconTap(context),
        ),
      );

  Widget _genderRadio() => Obx(
        () => TaavRadioGroup(
          items: const {
            true: 'Man',
            false: 'Woman',
          },
          fillParent: true,
          groupValue: controller.genderValue.value,
          onChanged: (final value) => controller.onGenderChanged(isMale: value),
          itemPadding: EdgeInsets.zero,
          axisDirection: Axis.vertical,
        ),
      );
}
