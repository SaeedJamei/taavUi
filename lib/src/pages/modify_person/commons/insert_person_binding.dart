import 'package:get/get.dart';

import '../controllers/insert_person_controller.dart';

class InsertPersonBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(InsertPersonController.new);
  }

}