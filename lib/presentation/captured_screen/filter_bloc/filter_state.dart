// ignore_for_file: public_member_api_docs

part of 'filter_bloc.dart';

class FilterState {
  FilterState({this.isFilteringByAlphabetically = false});
  final bool isFilteringByAlphabetically;

  FilterState copyWith({bool? isFilteringByAlphabetically}) {
    return FilterState(
      isFilteringByAlphabetically:
          isFilteringByAlphabetically ?? this.isFilteringByAlphabetically,
    );
  }
}


// class FilterState extends Equatable {
//   const FilterState({
//     this.isFilteringByAlphabetically = false,
//     this.status = FilterStatus.initial,
//   });
//   final bool isFilteringByAlphabetically;

//   final FilterStatus status;

//   FilterState copyWith({
//     bool? isFilteringByAlphabetically,
//     FilterStatus? status,
//   }) {
//     return FilterState(
//       status: status ?? this.status,
//       isFilteringByAlphabetically:
//           isFilteringByAlphabetically ?? this.isFilteringByAlphabetically,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         status,
//         isFilteringByAlphabetically,
//       ];
// }
