class BasicInfoUpdateDto {
  const BasicInfoUpdateDto({
    required this.id,
    required this.name,
    required this.gender,
    required this.image,
    required this.mobile,
    required this.nationalId,
    required this.birthday,
  });

  final String name;
  final String id;
  final String nationalId;
  final bool gender;
  final String image;
  final String mobile;
  final String birthday;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nationalId': nationalId,
        'gender': gender,
        'image': image,
        'mobile': mobile,
        'birthday': birthday,
      };
}
