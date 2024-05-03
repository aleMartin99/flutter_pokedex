part of 'search_bloc.dart';

///Serach base event
abstract class SearchEvent {}

///SearchActivatedEvent
class SearchActivatedEvent extends SearchEvent {
  ///
  SearchActivatedEvent({required this.searchWord});

  ///
  final String searchWord;
}

///SearchDeactivatedEvent
class SearchDeactivatedEvent extends SearchEvent {}
