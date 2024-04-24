import 'state_view_model.dart';

class StateListViewModel {
  StateListViewModel({
    required this.elements,
    required this.totalElements,
  });

  factory StateListViewModel.fromJson(
    final Map<String, dynamic> json,
  ) {
    final List<StateViewModel> elements = [];
    final int totalElements = json['totalElements'];
    if (totalElements > 0) {
      for (final element in json['elements']) {
        elements.add(StateViewModel.fromJson(element));
      }
    }

    return StateListViewModel(
      totalElements: totalElements,
      elements: elements,
    );
  }

  final List<StateViewModel> elements;
  final int totalElements;
}
