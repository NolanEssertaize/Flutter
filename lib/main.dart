import 'dart:math';

import 'package:flutter/material.dart';
import 'widgets/pokemon_card.dart';
import 'services/pokemon_service.dart';
import 'models/pokemon.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


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
  // ignore: library_private_types_in_public_api
  _PokemonDetailsPageState createState() => _PokemonDetailsPageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Pokemon> futurePokemon;
  var pokeId = 25;
  @override
  void initState() {
    super.initState();
    futurePokemon = PokemonService.fetchPokemon(pokeId);
  }