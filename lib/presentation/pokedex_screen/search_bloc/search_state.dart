part of 'search_bloc.dart';

/// SearchState class
class SearchState {
  ///
  SearchState({this.isSearching = false, this.searchWord = ''});

  /// Word used to search
  final String searchWord;

  /// flag indicating if is searching
  final bool isSearching;

  ///
  SearchState copyWith({bool? isSearching, String? searchWord}) {
    return SearchState(
      isSearching: isSearching ?? this.isSearching,
      searchWord: searchWord ?? this.searchWord,
    );
  }
}
