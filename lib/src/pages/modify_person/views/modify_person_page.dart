import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taav_bootstrap/taav_bootstrap.dart';
import 'package:taav_map/taav_map_api.dart';
import 'package:taav_ui/taav_ui.dart';

import '../../shared/models/enum/page_status.dart';
import '../controllers/modify_person_base_controller.dart';
import '../models/state_view_model.dart';

class ModifyPersonPage<T extends ModifyPersonBaseController>
    extends GetView<T> {
  const ModifyPersonPage({super.key});

  @override
  Widget build(BuildContext context) => TaavScaffold(
        appBar: AppBar(
          title: const TaavText.heading5('Modify'),
        ),
        body: Obx(() => _body(context)),
      );

  Widget _body(BuildContext context) {
    if (controller.pageStatus.value == PageStatus.loading) {
      return const TaavCircularPercentIndicator();
    }

    if (controller.pageStatus.value == PageStatus.error) {
      return Center(
        child: TaavButton(
          onTap: controller.onRetryTap,
          label: 'Retry',
        ),
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _avatar(context),
            _vSpacer(),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  _name(),
                  _nationId(),
                  _mobile(),
                  _birthday(),
                  _stateDropDown(),
                  _genderRadio(),
                ],
              ),
            ),
            _vSpacer(),
            _map(context),
            _vSpacer(),
            TaavButton.filled(
              label: 'register',
              onTap: controller.onRegisterPressed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _vSpacer() => const SizedBox(
        height: 20,
      );

  Widget _map(BuildContext context) => SizedBox(
        height: 200,
        child: TaavMap(
          options: TaavMapOptions(
            center: controller.selectedPoint.value ??
                const LatLng(29.60093, 52.530655),
            zoom: controller.selectedPoint.value == null ? 11.3 : 14.0,
            onTap: (final value) => controller.selectedPoint.value = value,
          ),
          nonRotatedChildren: [
            _markerLayerOptions(context),
            _searchPluginOption(context),
            _zoomButtonsPluginOption(),
          ],
          children: [
            TaavTileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const [
                'a',
                'b',
                'c',
              ],
            ),
          ],
        ),
      );

  Widget _genderRadio() => TaavRadioGroup(
        items: const {
          true: 'Man',
          false: 'Woman',
        },
        fillParent: true,
        groupValue: controller.genderValue.value,
        onChanged: (final value) => controller.onGenderChanged(isMale: value),
        itemPadding: EdgeInsets.zero,
        axisDirection: Axis.vertical,
      );

  Widget _stateDropDown() => TaavDropdown<StateViewModel>(
        label: 'Select your state',
        isFilterOnline: true,
        hasPagination: true,
        onlineDataProvider: controller.getCountries,
        mode: Mode.DIALOG,
        showSearchBox: true,
        multiSelect: false,
        compareFunction: (final a, final b) => a.id == b.id,
        showClearButton: true,
        isRequired: true,
        requiredErrorMessage: 'this is required',
        clearIcon: Icons.delete,
        popupMaxHeight: 300,
        itemAsString: (final item) => item.name,
        dropdownButtonWidget: const Icon(
          Icons.arrow_drop_down_circle_sharp,
        ),
        errorBuilder: (final text, final error) => TaavText.body1(
          'خطا : $error',
          textAlign: TextAlign.center,
          status: TaavWidgetStatus.danger,
        ),
        emptyBuilder: _emptyBuilder,
        showSelectionDoneWidget: false,
        selectedItems: [controller.state],
        onItemsSelected: (value) => controller.onCountrySelected(value),
        showDivider: true,
        dividerBuilder: () => const TaavDivider(
          dashType: TaavDividerDashType.dashed,
          padding: 0,
        ),
      );

  Widget _emptyBuilder(String? text) {
    final String message =
        text!.isEmpty ? 'داده ای یافت نشد' : 'داده ای با عنوان $text یافت نشد';

    return Center(
      child: TaavText.body1(
        message,
        status: TaavWidgetStatus.info,
      ),
    );
  }

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
        onDateTimeSelected: _onDateTimeSelected,
        calendarMode: TaavCalendarMode.jalali,
      );

  void _onDateTimeSelected(GregorianDate? date) {
    controller.birthday = date!;
  }

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

  Widget _avatar(BuildContext context) => TaavAvatarPicker.image(
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
      );

  Widget _markerLayerOptions(final BuildContext context) {
    if (controller.selectedPoint.value == null) {
      return const MarkerLayer(markers: []);
    }

    return MarkerLayer(
      markers: [
        Marker(
          width: 40,
          height: 40,
          point: controller.selectedPoint.value!,
          builder: (final ctx) => _locationIcon(context),
          anchorPos: AnchorPos.exactly(Anchor(20, 5)),
        ),
      ],
    );
  }

  Widget _locationIcon(final BuildContext context) => Icon(
        FontAwesomeIcons.solidLocationDot,
        color: context.styleData.dangerColor,
        size: 40,
      );

  Widget _searchPluginOption(final BuildContext context) => SearchPlugin(
        shape: TaavWidgetShape.semiRound,
        alignment: Alignment.topCenter,
        hinText: 'Hint text',
        margin: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: Breakpoint.get<double>(
            context,
            16,
            smallTablet: 24,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        country: 'ir',
        language: 'en',
        queryPrefix: '',
        querySuffix: '',
      );

  Widget _zoomButtonsPluginOption() => const ZoomButtonsPlugin(
        minZoom: 4,
        maxZoom: 18,
        padding: 10,
        size: TaavWidgetSize.medium,
        alignment: Alignment.bottomRight,
      );
}
