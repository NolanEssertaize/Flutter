import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'models/pokemon.dart';
import 'widgets/pokemon_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PokOpen',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokOpen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PokedexPage()),
                );
              },
              child: const Text('Pokedex'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BoosterOpeningPage()),
                );
              },
              child: const Text('Booster Opening'),
            ),
          ],
        ),
      ),
    );
  }
}

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  _PokedexPageState createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  List<dynamic> pokemons = [];

  @override
  void initState() {
    super.initState();
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1025'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        pokemons = data['results'];
      });
    } else {
      throw Exception('Failed to fetch pokemons');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
        ),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = pokemons[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokemonDetailsPage(pokemon: pokemon)),
              );
            },
            child: Card(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image.network(
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Text(
                      pokemon['name'],
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PokemonDetailsPage extends StatefulWidget {
  final dynamic pokemon;

  const PokemonDetailsPage({super.key, required this.pokemon});

  @override
  _PokemonDetailsPageState createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  late dynamic pokemonData;

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  Future<void> fetchPokemonData() async {
    final response = await http.get(Uri.parse(widget.pokemon['url']));
    if (response.statusCode == 200) {
      setState(() {
        pokemonData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to fetch pokemon data');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pokemonData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon Details'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonData['name']),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.3,
            child: Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemonData['id']}.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${pokemonData['name']}',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'ID: ${pokemonData['id']}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Types: ${pokemonData['types'].map((type) => type['type']['name']).join(', ')}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Height: ${pokemonData['height']} m',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Weight: ${pokemonData['weight']} kg',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BoosterOpeningPage extends StatefulWidget {
  const BoosterOpeningPage({super.key});
  
  @override
  State<BoosterOpeningPage> createState() => _BoosterOpeningPageState();

  
}

class _BoosterOpeningPageState extends State<BoosterOpeningPage> with SingleTickerProviderStateMixin {
  List<Pokemon> boosterPack = [];
  bool isLoading = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> openBoosterPack() async {
    setState(() {
      isLoading = true;
      boosterPack = [];
    });

    try {
      final List<Pokemon> newPack = [];
      final random = Random();
      
      for (int i = 0; i < 5; i++) {
        final id = random.nextInt(1024) + 1;
        final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
        
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          newPack.add(Pokemon(
            id: data['id'],
            name: data['name'],
            types: List<String>.from(data['types'].map((type) => type['type']['name'])),
            imageUrl: data['sprites']['front_default'],
          ));
        }
      }

      setState(() {
        boosterPack = newPack;
        isLoading = false;
      });
      _controller.forward();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to open booster pack')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booster Opening')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: isLoading || boosterPack.isNotEmpty ? null : openBoosterPack,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : boosterPack.isEmpty
                        ? Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'images/booster_pack.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : SwipeableCards(
                            cards: boosterPack,
                            cardAnimationController: _controller,
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwipeableCards extends StatefulWidget {
  final List<Pokemon> cards;
  final AnimationController cardAnimationController;

  const SwipeableCards({
    Key? key, 
    required this.cards,
    required this.cardAnimationController,
  }) : super(key: key);

  @override
  State<SwipeableCards> createState() => _SwipeableCardsState();
}

class _SwipeableCardsState extends State<SwipeableCards> {
  int currentIndex = 0;
  Offset dragPosition = Offset.zero;
  bool isDragging = false;

  void _onDragUpdate(DragUpdateDetails details) {
    if (currentIndex >= widget.cards.length) return;
    setState(() {
      dragPosition += details.delta;
      isDragging = true;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (currentIndex >= widget.cards.length) return;
    
    final threshold = 100.0;
    if (dragPosition.dx.abs() > threshold) {
      setState(() {
        currentIndex++;
        if (currentIndex < widget.cards.length) {
          widget.cardAnimationController.reset();
          widget.cardAnimationController.forward();
        }
      });
    }
    setState(() {
      dragPosition = Offset.zero;
      isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= widget.cards.length) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BoosterOpeningPage()),
            );
          },
          child: const Text('Open New Pack'),
        ),
      );
    }

    return GestureDetector(
      onPanUpdate: _onDragUpdate,
      onPanEnd: _onDragEnd,
      child: Center(
        child: Transform.translate(
          offset: dragPosition,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Card(
              elevation: 8,
              child: PokemonCard(pokemon: widget.cards[currentIndex]),
            ),
          ),
        ),
      ),
    );
  }
}