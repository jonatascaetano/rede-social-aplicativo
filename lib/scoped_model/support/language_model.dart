import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LanguageModel extends Model {
  String language = 'English';

  List<String> typeObject = ['user', 'entity', 'season', 'episode'];

  List<String> typeEntities = [
    'Movie',
    'Series',
    'Anime',
    'novel',
    'TV show',
    'Book',
    'Game',
    'Web program',
    'Song',
    'Music Album',
    'Place',
    'Recipe',
  ];

  List<String> typeEntitiesMini = [
    'Movies',
    'Series',
    'Animes',
    'Novels',
    'TV Shows',
    'Books',
    'Games',
    'Web Programs',
    'Songs',
    'Music Albums',
    'Places',
    'Recipes',
  ];

  List<IconData> typeEntitiesIcon = [
    Icons.local_movies,
    Icons.movie,
    Icons.bubble_chart_rounded,
    Icons.living,
    Icons.live_tv,
    Icons.menu_book,
    Icons.videogame_asset,
    Icons.connected_tv,
    Icons.queue_music,
    Icons.album,
    Icons.pin_drop_rounded,
    Icons.kitchen,
  ];

  List<List<String>> entitiesCategories = [
    [
      'todos',
      'viu',
      'vendo',
      'quer ver',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'vistos por ano',
    ], //filme
    [
      'todos',
      'viu',
      'vendo',
      'quer ver',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'vistos por ano',
    ], //serie
    [
      'todos',
      'viu',
      'vendo',
      'quer ver',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'vistos por ano',
    ], //anime
    [
      'todos',
      'viu',
      'vendo',
      'quer ver',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'vistos por ano',
    ], //novela
    [
      'todos',
      'viu',
      'vendo',
      'quer ver',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'vistos por ano',
    ], //programa de tv
    [
      'todos',
      'leu',
      'lendo',
      'quer ler',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'lidos por ano',
    ], //livro
    [
      'todos',
      'jogou',
      'jogando',
      'quer jogar',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'jogados por ano',
    ], //jogo
    [
      'todos',
      'viu',
      'vendo',
      'quer ver',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'vistos por ano',
    ], //programa da internet
    [
      'todos',
      'ouviu',
      'ouvindo',
      'quer ouvir',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'ouvidos por ano',
    ], //musica
    [
      'todos',
      'ouviu',
      'ouvindo',
      'quer ouvir',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'ouvidos por ano',
    ], //album de musica
    [
      'todos',
      'foi',
      'indo',
      'quer ir',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'idos por ano',
    ], //local
    [
      'todos',
      'fez',
      'fazendo',
      'quer fazer',
      'abondonou',
      'meta',
      'avaliados',
      'resenhados',
      'feitas por ano',
    ], //receita
  ];
}
