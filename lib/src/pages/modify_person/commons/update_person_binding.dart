import 'package:get/get.dart';

import '../controllers/update_person_controller.dart';

class UpdatePersonBinding extends Bindings{
  @override
  void dependencies() {

    final String id = Get.parameters['id']!;
    Get.lazyPut(() => UpdatePersonController(personId: id));
  }

}