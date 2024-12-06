import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/pokemon_card.dart';
import '../services/pokemon_service.dart';
import '../models/pokemon.dart';

class BoosterOpeningPage extends StatefulWidget {
  const BoosterOpeningPage({super.key});

  @override
  State<BoosterOpeningPage> createState() => _BoosterOpeningPageState();
}

class _BoosterOpeningPageState extends State<BoosterOpeningPage> {
  late Future<Pokemon> futurePokemon;
  var pokeId = 25;

  @override
  void initState() {
    super.initState();
    futurePokemon = PokemonService.fetchPokemon(pokeId);
  }

  void regeneratePokemon() {
    setState(() {
      pokeId = Random().nextInt(1025) + 1;
      futurePokemon = PokemonService.fetchPokemon(pokeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booster Opening'),
      ),
      body: Center(
        child: FutureBuilder<Pokemon>(
          future: futurePokemon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GestureDetector(
                onDoubleTap: () {
                  regeneratePokemon();
                },
                child: PokemonCard(pokemon: snapshot.data!),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
