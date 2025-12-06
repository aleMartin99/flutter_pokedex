import 'package:equatable/equatable.dart';
import 'package:flutter_pokedex/data/models/remote_models/evolution_chain_model/evolution_detail.dart';

/// Chain Link Model
class ChainLink extends Equatable {
  ///
  const ChainLink({
    this.speciesName,
    this.speciesUrl,
    this.evolutionDetails,
    this.evolvesTo,
  });

  /// ChainLink's fromMap method.
  factory ChainLink.fromMap(Map<String, dynamic> data) {
    final species = data['species'] as Map<String, dynamic>?;
    final evolutionDetails = data['evolution_details'] as List<dynamic>?;
    final evolvesTo = data['evolves_to'] as List<dynamic>?;

    return ChainLink(
      speciesName: species?['name'] as String?,
      speciesUrl: species?['url'] as String?,
      evolutionDetails: evolutionDetails
          ?.map((e) => EvolutionDetail.fromMap(e as Map<String, dynamic>))
          .toList(),
      evolvesTo: evolvesTo
          ?.map((e) => ChainLink.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// The species name
  final String? speciesName;

  /// The species URL
  final String? speciesUrl;

  /// Evolution details for this link
  final List<EvolutionDetail>? evolutionDetails;

  /// Pokemon that evolve from this species
  final List<ChainLink>? evolvesTo;

  @override
  List<Object?> get props => [
        speciesName,
        speciesUrl,
        evolutionDetails,
        evolvesTo,
      ];
}

