import 'package:taav_http_client_oauth/taav_http_client_oauth.dart';

import '../../../../../infrastructiors/utils/http_client_utils.dart';
import '../../../../shared/models/person_view_model.dart';
import '../models/address_info_update_dto.dart';

class AddressInfoInsertRepository {
  final _httpClientJson =
      HttpClientUtils.httpClient(baseUrl: 'http://127.0.0.1:3000');

  Future<Either<String, PersonViewModel>> patchPerson({
    required AddressInfoUpdateDto dto,
  }) async {
    final response = await _httpClientJson.patch<Map<String, dynamic>>(
      '/person/${dto.id}',
      data: dto.toJson(),
    );

    return response.fold(
      Left.new,
      (r) => Right(PersonViewModel.fromJson(r.data)),
    );
  }
}
