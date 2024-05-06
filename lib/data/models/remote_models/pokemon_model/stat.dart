import 'package:equatable/equatable.dart';

///
class Stat extends Equatable {
  ///
  const Stat({this.baseStat, this.statName});

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Stat].
  factory Stat.fromJson(Map<String, dynamic> data) {
    return Stat.fromMap(data);
  }

  ///
  factory Stat.fromMap(Map<String, dynamic> data) => Stat(
        baseStat: data['base_stat'] as int?,
        statName:
            ((data['stat'] as Map<String, dynamic>)['name'] as String?) ?? '',
      );

  ///
  final int? baseStat;

  ///
  final String? statName;

  @override
  List<Object?> get props => [baseStat, statName];
}
