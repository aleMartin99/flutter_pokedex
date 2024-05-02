import 'dart:convert';

import 'package:equatable/equatable.dart';

class Sprites extends Equatable {
  const Sprites({this.image, this.livePreview});

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Sprites].
  factory Sprites.fromJson(String data) {
    return Sprites.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory Sprites.fromMap(Map<String, dynamic> data) => Sprites(
        image: ((['other'] as Map<String, dynamic>)['official-artwork']
                    as Map<String, dynamic>)['front_default'] ==
                null
            ? ''
            : (['official-artwork'] as Map<String, dynamic>)['front_default']
                as String?,
        livePreview:
            (data['other']['showdown']['front_default'] as String?) == null
                ? ''
                : (['showdown'] as Map<String, dynamic>)['front_default']
                    as String?,
      );

  final String? image;
  final String? livePreview;

  @override
  List<Object?> get props => [image, livePreview];
}
