import 'state_view_model.dart';

class PersonViewModel {
  const PersonViewModel({
    required this.name,
    required this.id,
    required this.nationalId,
    required this.gender,
    required this.image,
    required this.mobile,
    required this.birthday,
    this.state,
    this.lat,
    this.long,
  });

  factory PersonViewModel.fromJson(Map<String, dynamic> json) =>
      PersonViewModel(
        name: json['name'],
        id: json['id'],
        nationalId: json['nationalId'],
        gender: json['gender'],
        image: json['image'],
        mobile: json['mobile'],
        birthday: json['birthday'],
        state: json['state'] == null
            ? null
            : StateViewModel.fromJson(json['state']),
        lat: json['lat'],
        long: json['long'],
      );

  final String id;
  final String name;
  final String nationalId;
  final bool gender;
  final String image;
  final String mobile;
  final StateViewModel? state;
  final String birthday;
  final String? lat;
  final String? long;
}
