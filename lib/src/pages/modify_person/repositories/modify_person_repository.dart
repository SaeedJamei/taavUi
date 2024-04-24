import 'package:taav_http_client_oauth/taav_http_client_oauth.dart';

import '../../../infrastructiors/utils/http_client_utils.dart';
import '../../shared/models/person_view_model.dart';
import '../models/person_dto.dart';
import '../models/state_list_view_model.dart';
import '../models/state_view_model.dart';

class ModifyPersonRepository {
  final _httpClient = HttpClientUtils.httpClient();
  final _httpClientJson =
      HttpClientUtils.httpClient(baseUrl: 'http://127.0.0.1:3000');

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

  Future<Either<String, PersonViewModel>> postPerson({
    required PersonDto dto,
  }) async {
    final response = await _httpClientJson.post<Map<String, dynamic>>(
      '/person',
      data: dto.toJson(),
    );

    return response.fold(
      Left.new,
      (r) => Right(PersonViewModel.fromJson(r.data)),
    );
  }

  Future<Either<String, PersonViewModel>> patchPerson({
    required PersonDto dto,
  }) async {
    final response = await _httpClientJson.put<Map<String, dynamic>>(
      '/person/${dto.id}',
      data: dto.toJson(),
    );

    return response.fold(
      Left.new,
      (r) => Right(PersonViewModel.fromJson(r.data)),
    );
  }

  Future<Either<String, PersonViewModel>> getPerson({
    required String id,
  }) async {
    final response = await _httpClientJson.get<List<dynamic>>('/person?id=$id');

    return response.fold(
      Left.new,
      (data) => Right(PersonViewModel.fromJson(data.data.first)),
    );
  }
}
