import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taav_bootstrap/taav_bootstrap.dart';
import 'package:taav_map/taav_map_api.dart';
import 'package:taav_ui/taav_ui.dart';

import '../../../../shared/models/state_view_model.dart';
import '../controllers/address_info_base_controller.dart';

class AddressInfoStep extends GetView<AddressInfoBaseController> {
  const AddressInfoStep(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: controller.formKey,
              child: _stateDropDown(),
            ),
            _vSpacer(),
            _map(context),
            _vSpacer(),
            TaavButton.filled(
              label: 'register',
              onTap: () => controller.onRegisterPressed(id),
            ),
          ],
        ),
      );

  Widget _map(BuildContext context) => Obx(
        () => SizedBox(
          height: 300,
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
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const [
                  'a',
                  'b',
                  'c',
                ],
              ),
            ],
          ),
        ),
      );

  Widget _stateDropDown() => Obx(
        () => TaavDropdown<StateViewModel>(
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
          selectedItems: [controller.state.value],
          onItemsSelected: (value) => controller.onCountrySelected(value),
          showDivider: true,
          dividerBuilder: () => const TaavDivider(
            dashType: TaavDividerDashType.dashed,
            padding: 0,
          ),
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

  Widget _vSpacer() => const SizedBox(
        height: 20,
      );
}
