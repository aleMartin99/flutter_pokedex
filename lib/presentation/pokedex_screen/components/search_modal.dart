import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/shared_components/modal.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/components/input.dart';

class SearchBottomModal extends StatelessWidget {
  const SearchBottomModal({super.key});

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context).bottom;
    final safeAreaBottom = MediaQuery.paddingOf(context).bottom;

    return Modal(
      child: Flexible(
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(26, 14, 26, 14 + viewInsets + safeAreaBottom),
          child: AppSearchBar(
            hintText: 'Search for a Pokemon',
          ),
        ),
      ),
    );
  }
}
