// ignore_for_file: avoid_redundant_argument_values, public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> with BaseBloc {
  FilterBloc() : super(FilterState()) {
    on<OnToggleAlphabeticallyFilterEvent>((event, emit) {
      secureEmit(
        FilterState(
          isFilteringByAlphabetically: event.isFilteringByAlphabetically,
          isFilteringByType: false,
        ),
      );
    });

    on<OnToggleByTypeFilterEvent>((event, emit) {
      secureEmit(
        FilterState(
          isFilteringByType: event.isFilteringByType,
          isFilteringByAlphabetically: false,
        ),
      );
    });
    on<OnResetFiltersEvent>((event, emit) {
      secureEmit(
        FilterState(
          isFilteringByType: false,
          isFilteringByAlphabetically: false,
        ),
      );
    });
  }
}
