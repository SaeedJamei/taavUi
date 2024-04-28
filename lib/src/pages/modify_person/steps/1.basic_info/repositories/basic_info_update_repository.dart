import 'package:taav_http_client_oauth/taav_http_client_oauth.dart';

import '../../../../../infrastructiors/utils/http_client_utils.dart';
import '../../../../shared/models/person_view_model.dart';
import '../models/basic_info_update_dto.dart';

class BasicInfoUpdateRepository {
  final _httpClient =
      HttpClientUtils.httpClient(baseUrl: 'http://127.0.0.1:3000');

  Future<Either<String, PersonViewModel>> getPerson({
    required String id,
  }) async {
    final response = await _httpClient.get<List<dynamic>>('/person?id=$id');

    return response.fold(
      Left.new,
      (data) => Right(PersonViewModel.fromJson(data.data.first)),
    );
  }

  Future<Either<String, PersonViewModel>> patchPerson({
    required BasicInfoUpdateDto dto,
  }) async {
    final response = await _httpClient.patch<Map<String, dynamic>>(
      '/person/${dto.id}',
      data: dto.toJson(),
    );

    return response.fold(
      Left.new,
      (r) => Right(PersonViewModel.fromJson(r.data)),
    );
  }
}
