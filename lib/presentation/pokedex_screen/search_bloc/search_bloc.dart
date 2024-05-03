import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/utils/base_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

/// SearchBloc class
class SearchBloc extends Bloc<SearchEvent, SearchState> with BaseBloc {
  ///
  SearchBloc() : super(SearchState()) {
    on<SearchActivatedEvent>((event, emit) {
      if (!isClosed) {
        secureEmit(
          SearchState(isSearching: true, searchWord: event.searchWord),
        );
      }
    });

    on<SearchDeactivatedEvent>((event, emit) {
      if (!isClosed) {
        secureEmit(
          SearchState(isSearching: false, searchWord: ''),
        );
      }
    });
  }
}
