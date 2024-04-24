class StateViewModel {
  StateViewModel({
    required this.id,
    required this.name,
    required this.countryId,
  });

  factory StateViewModel.fromJson(Map<String, dynamic> json) => StateViewModel(
        id: json['id'],
        name: json['name'],
        countryId: json['countryId'],
      );

  int id;
  String name;
  int countryId;
}
