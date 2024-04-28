import 'package:either_dart/either.dart';
import 'package:taav_map/taav_map_api.dart';

import '../../1.basic_info/repositories/basic_info_update_repository.dart';
import 'address_info_base_controller.dart';

class AddressInfoUpdateController extends AddressInfoBaseController {
  AddressInfoUpdateController({required this.id});

  final String id;

  final _repository = BasicInfoUpdateRepository();

  @override
  void onInit() {
    super.onInit();
    getPerson(id);
  }

  Future<void> getPerson(String id) async {
    final result = await _repository.getPerson(id: id);
    result.fold(
      Left.new,
      (r) {
        if (r.state != null) {
          state.value = r.state!;
        }

        if (r.lat != null && r.long != null) {
          selectedPoint.value = LatLng(
            double.parse(r.lat!),
            double.parse(r.long!),
          );
        }
      },
    );
  }
}
