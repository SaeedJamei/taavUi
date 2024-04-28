import 'package:taav_http_client_oauth/taav_http_client_oauth.dart';

import '../../../../../infrastructiors/utils/http_client_utils.dart';
import '../../../../shared/models/state_view_model.dart';
import '../models/state_list_view_model.dart';

class AddressInfoBaseRepository {
  final _httpClient = HttpClientUtils.httpClient();

  Future<Either<String, List<StateViewModel>>> getCountry({
    required final String searchText,
    required final int page,
  }) async {
    final response = await _httpClient.get<Map<String, dynamic>>(
      '/api/states/103/all?limit=10&offset=$page&search=$searchText',
    );

    return response.fold(
      Left.new,
      (data) => Right(StateListViewModel.fromJson(data.data).elements),
    );
  }
}
