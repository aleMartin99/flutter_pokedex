import 'package:equatable/equatable.dart';
import 'package:flutter_pokedex/data/models/remote_models/evolution_chain_model/chain_link.dart';

/// Evolution Chain Model
class EvolutionChainModel extends Equatable {
  ///
  const EvolutionChainModel({
    this.id,
    this.chain,
  });

  /// EvolutionChainModel's fromMap method.
  factory EvolutionChainModel.fromMap(Map<String, dynamic> data) {
    final chain = data['chain'] as Map<String, dynamic>?;

    return EvolutionChainModel(
      id: data['id'] as int?,
      chain: chain != null ? ChainLink.fromMap(chain) : null,
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EvolutionChainModel].
  factory EvolutionChainModel.fromJson(Map<String, dynamic> data) {
    return EvolutionChainModel.fromMap(data);
  }

  /// The identifier for this evolution chain
  final int? id;

  /// The base chain link for this evolution chain
  final ChainLink? chain;

  @override
  List<Object?> get props => [id, chain];
}

