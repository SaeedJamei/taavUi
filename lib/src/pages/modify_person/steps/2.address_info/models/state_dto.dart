class StateDto {
  StateDto({
    required this.id,
    required this.countryId,
    required this.name,
  });

  int id;
  int countryId;
  String name;

  Map<String, dynamic> toJson() => {
        'countryId': countryId,
        'id': id,
        'name': name,
      };
}
