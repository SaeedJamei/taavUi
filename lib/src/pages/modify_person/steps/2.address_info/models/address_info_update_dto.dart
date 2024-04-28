import 'state_dto.dart';

class AddressInfoUpdateDto {
  const AddressInfoUpdateDto({
    required this.id,
    required this.state,
    required this.lat,
    required this.long,
  });

  final String id;
  final StateDto state;
  final String lat;
  final String long;

  Map<String, dynamic> toJson() => {
        'id': id,
        'state': state.toJson(),
        'lat': lat,
        'long': long,
      };
}
