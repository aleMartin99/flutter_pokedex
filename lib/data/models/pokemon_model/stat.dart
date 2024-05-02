import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'stat.dart';

class Stat extends Equatable {
  final int? baseStat;
  final Stat? stat;

  const Stat({this.baseStat, this.stat});

  factory Stat.fromMap(Map<String, dynamic> data) => Stat(
        baseStat: data['base_stat'] as int?,
        stat: data['stat'] == null
            ? null
            : Stat.fromMap(data['stat'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'base_stat': baseStat,
        'stat': stat?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Stat].
  factory Stat.fromJson(String data) {
    return Stat.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Stat] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [baseStat, stat];
}
