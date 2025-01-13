import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../utils.dart' as utils;

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final bool isRevealed;
  final VoidCallback? onLegendaryRevealed; 
  static List<int> rarityId = utils.pokemonLegendaires;

  const PokemonCard({
    super.key, 
    required this.pokemon,
    this.isRevealed = true,
    this.onLegendaryRevealed,
  });

  bool get isRare => rarityId.contains(pokemon.id);

  Color getTypeColor(String type) {
    final Map<String, Color> typeColors = utils.typeColors;
    return typeColors[type.toLowerCase()] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isRevealed ? 1.0 : 0.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              getTypeColor(pokemon.types.first).withOpacity(0.7),
              getTypeColor(pokemon.types.first).withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: isRare 
                ? Colors.amber.withOpacity(0.5)
                : Colors.black.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
          border: isRare
            ? Border.all(color: Colors.amber, width: 2)
            : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Image.network(
                pokemon.imageUrl,
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              pokemon.name.toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isRare ? Colors.amber[700] : Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pokemon.types.join(' / '),
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
                fontStyle: FontStyle.italic,
                shadows: [
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}