import 'package:either_dart/either.dart';

import '../../../infrastructiors/utils/http_client_utils.dart';
import '../../shared/models/person_view_model.dart';

class PersonListRepository {
  final _httpClient =
      HttpClientUtils.httpClient(baseUrl: 'http://127.0.0.1:3000');

  Future<Either<String, List<PersonViewModel>>> getPersons() async {
    final response = await _httpClient.get<List<dynamic>>('/person');

    return response.fold(
      Left.new,
      (data) => Right(
        data.data
            .map((e) => PersonViewModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
  }
}

class BaseUrls {
  static const String jsonServer = '';
}
