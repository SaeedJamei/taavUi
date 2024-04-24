import 'package:get/get.dart';

import '../controllers/person_list_controller.dart';

class PersonListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PersonListController.new);
  }
}
