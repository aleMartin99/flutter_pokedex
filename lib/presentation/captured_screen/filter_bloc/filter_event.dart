// ignore_for_file: public_member_api_docs

part of 'filter_bloc.dart';

sealed class FilterEvent extends Equatable {}

class OnToggleAlphabeticallyFilterEvent extends FilterEvent {
  OnToggleAlphabeticallyFilterEvent({
    required this.isFilteringByAlphabetically,
  });

  /// Alphabetically filter status
  final bool isFilteringByAlphabetically;

  @override
  List<Object> get props => [isFilteringByAlphabetically];
}

class OnToggleByTypeFilterEvent extends FilterEvent {
  OnToggleByTypeFilterEvent({
    required this.isFilteringByType,
  });

  /// By type filter status
  final bool isFilteringByType;

  @override
  List<Object> get props => [isFilteringByType];
}

class OnResetFiltersEvent extends FilterEvent {
  @override
  List<Object> get props => [];
}
