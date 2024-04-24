import '../../modify_person/models/state_view_model.dart';

class PersonViewModel {
  const PersonViewModel({
    required this.name,
    required this.id,
    required this.nationalId,
    required this.gender,
    required this.image,
    required this.mobile,
    required this.state,
    required this.birthday,
    required this.lat,
    required this.long,
  });

  factory PersonViewModel.fromJson(Map<String, dynamic> json) =>
      PersonViewModel(
        name: json['name'],
        id: json['id'],
        nationalId: json['nationalId'],
        gender: json['gender'],
        image: json['image'],
        mobile: json['mobile'],
        state: StateViewModel.fromJson(json['state']),
        birthday: json['birthday'],
        lat: json['lat'],
        long: json['long'],
      );

  final String id;
  final String name;
  final String nationalId;
  final bool gender;
  final String image;
  final String mobile;
  final StateViewModel state;
  final String birthday;
  final String lat;
  final String long;
}
