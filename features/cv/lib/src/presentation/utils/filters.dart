enum FilterType {
  experience,
  domains,
}

class Filters {
  double? experienceInYears;
  List<String>? domains;

  Filters({
    this.experienceInYears,
    this.domains,
  });

  bool isAnyFilterActive() {
    return (experienceInYears != null && experienceInYears! > 0) ||
        (domains != null && domains!.isNotEmpty);
  }

  void clearFilters() {
    experienceInYears = null;
    domains = null;
  }
}
