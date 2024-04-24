import 'package:get/get.dart';

import '../../pages/modify_person/commons/insert_person_binding.dart';
import '../../pages/modify_person/commons/update_person_binding.dart';
import '../../pages/modify_person/controllers/insert_person_controller.dart';
import '../../pages/modify_person/controllers/update_person_controller.dart';
import '../../pages/modify_person/views/modify_person_page.dart';
import '../../pages/person_list/commons/person_list_binding.dart';
import '../../pages/person_list/views/person_list_page.dart';
import 'route_names.dart';

class RoutPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: RouteNames.viewPage,
      page: () => const PersonListPage(),
      binding: PersonListBinding(),
      children: [
        GetPage(
          name: RouteNames.insertPerson,
          page: () => const ModifyPersonPage<InsertPersonController>(),
          binding: InsertPersonBinding(),
        ),
        GetPage(
          name: RouteNames.updatePerson,
          page: () => const ModifyPersonPage<UpdatePersonController>(),
          binding: UpdatePersonBinding(),
        ),
      ],
    ),
  ];
}
