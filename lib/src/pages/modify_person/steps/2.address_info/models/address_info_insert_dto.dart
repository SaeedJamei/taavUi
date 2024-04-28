import 'state_dto.dart';

class AddressInfoInsertDto {
  const AddressInfoInsertDto({
    required this.state,
    required this.lat,
    required this.long,
  });

  final StateDto state;
  final String lat;
  final String long;

  Map<String, dynamic> toJson() => {
        'state': state.toJson(),
        'lat': lat,
        'long': long,
      };
}
