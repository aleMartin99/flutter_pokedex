// ignore_for_file: public_member_api_docs

part of 'filter_bloc.dart';

class FilterState {
  FilterState({
    this.isFilteringByAlphabetically = false,
    this.isFilteringByType = false,
  });
  final bool isFilteringByAlphabetically;
  final bool isFilteringByType;

  FilterState copyWith({
    bool? isFilteringByType,
    bool? isFilteringByAlphabetically,
  }) {
    return FilterState(
      isFilteringByType: isFilteringByType ?? this.isFilteringByType,
      isFilteringByAlphabetically:
          isFilteringByAlphabetically ?? this.isFilteringByAlphabetically,
    );
  }
}
