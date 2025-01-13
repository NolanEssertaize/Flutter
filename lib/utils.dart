import 'dart:ui';

List<int> pokemonLegendaires = [
  // Gen 1
  144, // Artikodin
  145, // Électhor
  146, // Sulfura
  150, // Mewtwo
  151, // Mew

  // Gen 2
  243, // Raikou
  244, // Entei
  245, // Suicune
  249, // Lugia
  250, // Ho-Oh
  251, // Celebi

  // Gen 3
  377, // Regirock
  378, // Regice
  379, // Registeel
  380, // Latias
  381, // Latios
  382, // Kyogre
  383, // Groudon
  384, // Rayquaza
  385, // Jirachi
  386, // Deoxys

  // Gen 4
  480, // Créhelf
  481, // Créfollet
  482, // Créfadet
  483, // Dialga
  484, // Palkia
  485, // Heatran
  486, // Regigigas
  487, // Giratina
  488, // Cresselia
  489, // Phione
  490, // Manaphy
  491, // Darkrai
  492, // Shaymin
  493, // Arceus

  // Gen 5
  494, // Victini
  638, // Cobaltium
  639, // Terrakium
  640, // Viridium
  641, // Boréas
  642, // Fulguris
  643, // Reshiram
  644, // Zekrom
  645, // Démétéros
  646, // Kyurem
  647, // Keldeo
  648, // Meloetta
  649, // Genesect

  // Gen 6
  716, // Xerneas
  717, // Yveltal
  718, // Zygarde
  719, // Diancie
  720, // Hoopa
  721, // Volcanion

  // Gen 7
  772, // Silvallié
  773, // Type:0
  785, // Tokorico
  786, // Tokopiyon
  787, // Tokotoro
  788, // Tokogéro
  789, // Cosmog
  790, // Cosmovum
  791, // Solgaleo
  792, // Lunala
  793, // Zéroïd
  794, // Engloutyran
  795, // Necrozma
  796, // Magearna
  797, // Marshadow
  798, // Vémini
  799, // Zeraora
  800, // Meltan
  801, // Melmetal

  // Gen 8
  888, // Zacian
  889, // Zamazenta
  890, // Éternatos
  891, // Regieleki
  892, // Regidrago
  893, // Blizzeval
  894, // Spectreval
  895, // Calyrex
  896, // Zarude
  897, // Wushours
  898  // Urshifu
];

final Map<String, Color> typeColors = {
      'normal': const Color(0xFFA8A878),
      'fire': const Color(0xFFF08030),
      'water': const Color(0xFF6890F0),
      'electric': const Color(0xFFF8D030),
      'grass': const Color(0xFF78C850),
      'ice': const Color(0xFF98D8D8),
      'fighting': const Color(0xFFC03028),
      'poison': const Color(0xFFA040A0),
      'ground': const Color(0xFFE0C068),
      'flying': const Color(0xFFA890F0),
      'psychic': const Color(0xFFF85888),
      'bug': const Color(0xFFA8B820),
      'rock': const Color(0xFFB8A038),
      'ghost': const Color(0xFF705898),
      'dragon': const Color(0xFF7038F8),
      'dark': const Color(0xFF705848),
      'steel': const Color(0xFFB8B8D0),
      'fairy': const Color(0xFFEE99AC),
    };