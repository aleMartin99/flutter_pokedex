import 'dart:convert';

import 'package:equatable/equatable.dart';

class Type extends Equatable {
  factory Type.fromMap(Map<String, dynamic> data) => Type(
        type: data['type'] == null
            ? null
            : Type.fromMap(data['type'] as Map<String, dynamic>),
      );

  const Type({this.type});

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Type].
  factory Type.fromJson(String data) {
    return Type.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final Type? type;

  Map<String, dynamic> toMap() => {
        'type': type?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Converts [Type] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [type];
}
