import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/shared_components/shared_components_exports.dart';

///
class HeaderSection extends StatelessWidget implements PreferredSizeWidget {
  ///
  const HeaderSection({
    required this.height,
    super.key,
  });

  ///
  final double height;

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
