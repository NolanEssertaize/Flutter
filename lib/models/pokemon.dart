class Pokemon {
  final String name;
  final String imageUrl;
  final List<String> types;
  final int id;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.id,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      id: json['id'],
    );
  }
}