import 'package:equatable/equatable.dart';

class Type extends Equatable {
  const Type({this.type});
  factory Type.fromMap(Map<String, dynamic> data) => Type(
        type:
            ((data['type'] as Map<String, dynamic>)['name'] as String?) == null
                ? ''
                : ((data['type'] as Map<String, dynamic>)['name'] as String?),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Type].
  factory Type.fromJson(Map<String, dynamic> data) {
    return Type.fromMap(data);
  }
  final String? type;

  @override
  List<Object?> get props => [type];
}
