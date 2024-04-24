import 'state_dto.dart';

class PersonDto {
  const PersonDto({
    required this.name,
    required this.gender,
    required this.image,
    required this.mobile,
    required this.state,
    required this.nationalId,
    required this.birthday,
    required this.lat,
    required this.long,
    this.id,
  });

  final String name;
  final String? id;
  final String nationalId;
  final bool gender;
  final String image;
  final String mobile;
  final StateDto state;
  final String birthday;
  final String lat;
  final String long;

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'name': name,
        'nationalId': nationalId,
        'gender': gender,
        'image': image,
        'mobile': mobile,
        'state': state.toJson(),
        'birthday': birthday,
        'lat': lat,
        'long': long,
      };
}
