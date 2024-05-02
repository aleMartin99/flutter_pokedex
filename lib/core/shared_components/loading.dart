import 'package:flutter/material.dart';

class PokeBallLoadingIndicator extends StatelessWidget {
  const PokeBallLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
        // image: GifConstants.pokeball_loader,
        image: NetworkImage(
            'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNXI0djBqOTNqMTNoZzhyOGtyMG9teHY5cDNhZjl6ZjIxd3dudGtqaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/XGbRD1gREhvBysGial/giphy.gif'),
        fit: BoxFit.contain,
      ),
    );
  }
}
