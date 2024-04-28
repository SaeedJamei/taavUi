import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:taav_ui/taav_ui.dart';

import '../../steps/1.basic_info/views/basic_info_step.dart';
import '../../steps/2.address_info/views/address_info_step.dart';
import '../controllers/modify_person_base_controller.dart';
import '../models/enums/modify_person_step.dart';

class ModifyPersonPage<T extends ModifyPersonBaseController>
    extends GetView<T> {
  const ModifyPersonPage({super.key});

  @override
  Widget build(BuildContext context) => TaavScaffold(
        appBar: AppBar(
          title: const TaavText.heading5('Modify'),
        ),
        body: _body(),
      );

  Widget _body() => Center(
        child: SizedBox(
          height: double.infinity,
          child: Obx(
            () => TaavStepper(
              currentStep: controller.currentStep.value.index,
              onStepTapped: controller.onStepTap,
              steps: _steps(),
            ),
          ),
        ),
      );

  List<TaavStep> _steps() => [
        _basicInfoStep(),
        _addressInfo(),
      ];

  TaavStep _basicInfoStep() => TaavStep(
        icon: Icons.looks_one,
        content: () => BasicInfoStep(callBackId: controller.callBakId),
        state: _basicInfoStepState(),
      );

  TaavStepState _basicInfoStepState() {
    if (controller.currentStep.value == ModifyPersonStep.basicInfo) {
      return TaavStepState.indexed;
    }

    return TaavStepState.inComplete;
  }

  TaavStep _addressInfo() => TaavStep(
        icon: Icons.looks_two,
        content: () => AddressInfoStep(controller.personId.value!),
        state: _addressInfoStepState(),
      );

  TaavStepState _addressInfoStepState() {
    if (controller.personId.value == null) {
      return TaavStepState.disabled;
    }

    if (controller.currentStep.value == ModifyPersonStep.addressInfo) {
      return TaavStepState.indexed;
    }

    return TaavStepState.inComplete;
  }
}
