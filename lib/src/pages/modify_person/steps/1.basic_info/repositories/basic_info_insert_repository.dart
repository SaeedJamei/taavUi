import 'package:taav_http_client_oauth/taav_http_client_oauth.dart';

import '../../../../../infrastructiors/utils/http_client_utils.dart';
import '../models/basic_info_insert_dto.dart';

class BasicInfoInsertRepository {
  final _httpClient =
      HttpClientUtils.httpClient(baseUrl: 'http://127.0.0.1:3000');

  Future<Either<String, Map<String, dynamic>>> postPerson({
    required BasicInfoInsertDto dto,
  }) async {
    final response = await _httpClient.post<Map<String, dynamic>>(
      '/person',
      data: dto.toJson(),
    );

    return response.fold(
      Left.new,
      (r) => Right(r.data),
    );
  }
}
