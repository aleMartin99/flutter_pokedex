import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/constants/constants_exports.dart';
import 'package:flutter_pokedex/core/services/services_exports.dart';
import 'package:flutter_pokedex/data/models/remote_models/remote_models_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/domain/usecases/get_evolution_chain/get_evolution_chain_usecase.dart';
import 'package:flutter_pokedex/main.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/evolution_chain_bloc/evolution_chain_bloc_exports.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/pokemon_details_screen_exports.dart';

/// PokemonEvolutionChain class
class PokemonEvolutionChain extends StatelessWidget {
  ///
  const PokemonEvolutionChain(this.pokemon, {super.key});

  ///
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EvolutionChainBloc(
        getEvolutionChainUsecase: sl<GetEvolutionChainUsecase>(),
      )..add(
          OnLoadEvolutionChainEvent(
            pokemonId: pokemon.id ?? 0,
          ),
        ),
      child: const _PokemonEvolutionChainView(),
    );
  }
}

class _PokemonEvolutionChainView extends StatefulWidget {
  ///
  const _PokemonEvolutionChainView();

  @override
  State<_PokemonEvolutionChainView> createState() =>
      _PokemonEvolutionChainViewState();
}

class _PokemonEvolutionChainViewState
    extends State<_PokemonEvolutionChainView> {
  final Map<String, String> _pokemonImages = {};
  bool _imagesLoaded = false;

  AnimationController get slideController =>
      PokemonInfoStateProvider.of(context).slideController;

  Future<void> _loadPokemonImages(ChainLink? chain) async {
    if (chain == null || _imagesLoaded) return;

    final images = await EvolutionChainImageService.loadPokemonImages(chain);
    if (mounted) {
      setState(() {
        _pokemonImages.addAll(images);
        _imagesLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: scrollable
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: BlocBuilder<EvolutionChainBloc, EvolutionChainState>(
        builder: (context, state) {
          // Load images when evolution chain is successfully loaded
          if (state.status == EvolutionChainStatus.success &&
              state.evolutionChain != null &&
              !_imagesLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _loadPokemonImages(state.evolutionChain!.chain);
            });
          }

          return _buildContent(state);
        },
      ),
    );
  }

  Widget _buildContent(EvolutionChainState state) {
    if (state.status == EvolutionChainStatus.loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.status == EvolutionChainStatus.failure) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            state.failure ?? 'Failed to load evolution chain',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      );
    }

    if (state.evolutionChain == null || state.evolutionChain!.chain == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('No evolution chain available'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Evolution Chain',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        _buildEvolutionChain(state.evolutionChain!.chain!),
      ],
    );
  }

  Widget _buildEvolutionChain(ChainLink chain) {
    return _buildEvolutionTree(chain);
  }

  Widget _buildEvolutionTree(ChainLink chain) {
    final List<Widget> evolutionStages = [];
    _buildEvolutionStages(chain, evolutionStages);

    return Column(
      children: evolutionStages,
    );
  }

  void _buildEvolutionStages(ChainLink chain, List<Widget> stages) {
    // Build current stage with its evolutions
    if (chain.evolvesTo != null && chain.evolvesTo!.isNotEmpty) {
      for (final evolution in chain.evolvesTo!) {
        final evolutionDetail = evolution.evolutionDetails?.isNotEmpty ?? false
            ? evolution.evolutionDetails!.first
            : null;

        // Build evolution requirement text
        String? requirementText;
        if (evolutionDetail?.minLevel != null) {
          requirementText = 'Lvl ${evolutionDetail!.minLevel}';
        } else if (evolutionDetail?.item != null) {
          requirementText = _formatItemName(evolutionDetail!.item!);
        } else if (evolutionDetail?.trigger != null) {
          requirementText = _formatTriggerName(evolutionDetail!.trigger!);
        }

        // Build horizontal row: Pokemon -> Arrow + Requirement -> Evolved Pokemon
        stages.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisSize: MainAxisSize.max,
              children: [
                _buildPokemonCard(chain),
                const SizedBox(width: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      size: 24,
                      color: Colors.grey,
                    ),
                    if (requirementText != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        requirementText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(width: 16),
                _buildPokemonCard(evolution),
              ],
            ),
          ),
        );

        // Recursively build next evolution stages
        if (evolution.evolvesTo != null && evolution.evolvesTo!.isNotEmpty) {
          _buildEvolutionStages(evolution, stages);
        }
      }
    } else {
      // No evolutions, just show the Pokemon
      stages.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: _buildPokemonCard(chain),
        ),
      );
    }
  }

  Widget _buildPokemonCard(ChainLink chain) {
    final pokemonName = chain.speciesName ?? 'Unknown';
    final imageUrl = _pokemonImages[pokemonName];
    final capitalizedName = pokemonName.isEmpty
        ? 'Unknown'
        : '${pokemonName[0].toUpperCase()}${pokemonName.substring(1)}';

    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Image(
                image: NetworkImage(ImageConstants.pokeballGif),
                fit: BoxFit.contain,
                // fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Image.asset(
                ImageConstants.pokeballDefault,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          capitalizedName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatItemName(String item) {
    return item
        .split('-')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  String _formatTriggerName(String trigger) {
    return trigger
        .split('-')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }
}
