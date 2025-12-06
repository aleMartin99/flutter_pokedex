import 'package:equatable/equatable.dart';

/// Evolution Detail Model
class EvolutionDetail extends Equatable {
  ///
  const EvolutionDetail({
    this.minLevel,
    this.trigger,
    this.item,
    this.heldItem,
    this.timeOfDay,
    this.gender,
    this.location,
    this.knownMoveType,
    this.minHappiness,
    this.minBeauty,
    this.minAffection,
    this.needsOverworldRain,
    this.partySpecies,
    this.partyType,
    this.relativePhysicalStats,
    this.tradeSpecies,
    this.turnUpsideDown,
  });

  /// EvolutionDetail's fromMap method.
  factory EvolutionDetail.fromMap(Map<String, dynamic> data) {
    final trigger = data['trigger'] as Map<String, dynamic>?;
    final item = data['item'] as Map<String, dynamic>?;
    final heldItem = data['held_item'] as Map<String, dynamic>?;
    final location = data['location'] as Map<String, dynamic>?;
    final knownMoveType = data['known_move_type'] as Map<String, dynamic>?;
    final partySpecies = data['party_species'] as Map<String, dynamic>?;
    final partyType = data['party_type'] as Map<String, dynamic>?;
    final tradeSpecies = data['trade_species'] as Map<String, dynamic>?;

    return EvolutionDetail(
      minLevel: data['min_level'] as int?,
      trigger: trigger?['name'] as String?,
      item: item?['name'] as String?,
      heldItem: heldItem?['name'] as String?,
      timeOfDay: data['time_of_day'] as String?,
      gender: data['gender'] as int?,
      location: location?['name'] as String?,
      knownMoveType: knownMoveType?['name'] as String?,
      minHappiness: data['min_happiness'] as int?,
      minBeauty: data['min_beauty'] as int?,
      minAffection: data['min_affection'] as int?,
      needsOverworldRain: data['needs_overworld_rain'] as bool?,
      partySpecies: partySpecies?['name'] as String?,
      partyType: partyType?['name'] as String?,
      relativePhysicalStats: data['relative_physical_stats'] as int?,
      tradeSpecies: tradeSpecies?['name'] as String?,
      turnUpsideDown: data['turn_upside_down'] as bool?,
    );
  }

  /// Minimum level required for evolution
  final int? minLevel;

  /// The trigger that causes this evolution
  final String? trigger;

  /// The item required to cause evolution
  final String? item;

  /// The held item required to cause evolution
  final String? heldItem;

  /// Time of day when evolution occurs
  final String? timeOfDay;

  /// Gender required for evolution
  final int? gender;

  /// Location required for evolution
  final String? location;

  /// Known move type required for evolution
  final String? knownMoveType;

  /// Minimum happiness required
  final int? minHappiness;

  /// Minimum beauty required
  final int? minBeauty;

  /// Minimum affection required
  final int? minAffection;

  /// Whether overworld rain is needed
  final bool? needsOverworldRain;

  /// Party species required
  final String? partySpecies;

  /// Party type required
  final String? partyType;

  /// Relative physical stats
  final int? relativePhysicalStats;

  /// Trade species required
  final String? tradeSpecies;

  /// Whether to turn upside down
  final bool? turnUpsideDown;

  @override
  List<Object?> get props => [
        minLevel,
        trigger,
        item,
        heldItem,
        timeOfDay,
        gender,
        location,
        knownMoveType,
        minHappiness,
        minBeauty,
        minAffection,
        needsOverworldRain,
        partySpecies,
        partyType,
        relativePhysicalStats,
        tradeSpecies,
        turnUpsideDown,
      ];
}

