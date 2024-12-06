import 'dart:math';

import 'package:flutter/material.dart';
import 'widgets/pokemon_card.dart';
import 'services/pokemon_service.dart';
import 'models/pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Pokemon> futurePokemon;
  var pokeId = 25;
  @override
  void initState() {
    super.initState();
    futurePokemon = PokemonService.fetchPokemon(pokeId);
  }

  void regenerate_pokemon() {
  setState(() {
    pokeId = Random().nextInt(1025);
    futurePokemon = PokemonService.fetchPokemon(pokeId);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Card'),
      ),
      body: Center(
        child: FutureBuilder<Pokemon>(
          future: futurePokemon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GestureDetector(
                onDoubleTap: () {
                  regenerate_pokemon();
                },
                child: PokemonCard(pokemon: snapshot.data!),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}