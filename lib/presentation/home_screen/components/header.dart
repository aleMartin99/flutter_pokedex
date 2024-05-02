import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/shared_components/custom_scaffold.dart';
import 'package:flutter_pokedex/core/theme/colors.dart';
import 'package:flutter_pokedex/presentation/home_screen/components/category_card.dart';

class HeaderSection extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const HeaderSection({
    required this.height,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return PokeballScaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 36),
                child: Text(
                  'Welcome to the Pokedex!!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
