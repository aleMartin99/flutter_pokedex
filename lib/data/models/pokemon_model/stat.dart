import 'dart:convert';

import 'package:equatable/equatable.dart';

class Stat extends Equatable {
  const Stat({this.baseStat, this.stat});

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Stat].
  factory Stat.fromJson(Map<String, dynamic> data) {
    return Stat.fromMap(data);
  }

  factory Stat.fromMap(Map<String, dynamic> data) => Stat(
        baseStat: data['base_stat'] as int?,
        stat:
            ((data['stat'] as Map<String, dynamic>)['name'] as String?) == null
                ? ''
                : ((data['stat'] as Map<String, dynamic>)['name'] as String?),
      );
  final int? baseStat;
  final String? stat;

  Map<String, dynamic> toMap() => {
        'base_stat': baseStat,
        'stat': stat,
      };

  /// `dart:convert`
  ///
  /// Converts [Stat] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [baseStat, stat];
}
