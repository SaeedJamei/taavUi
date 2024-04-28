enum ModifyPersonStep {
  basicInfo,
  addressInfo;

  factory ModifyPersonStep.fromIndex(final int? index) {
    for (final item in ModifyPersonStep.values) {
      if (item.index == index) {
        return item;
      }
    }

    return ModifyPersonStep.basicInfo;
  }
}
