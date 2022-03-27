import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LanguageModel extends Model {
  String language = 'English';

  List<String> typeObject = ['user', 'entity', 'season', 'episode', 'group'];

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
      'all',
      'watched',
      'watching',
      'want to watch',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //filme
    [
      'all',
      'watched',
      'watching',
      'want to watch',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //serie
    [
      'all',
      'watched',
      'watching',
      'want to watch',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //anime
    [
      'all',
      'watched',
      'watching',
      'want to watch',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //novela
    [
      'all',
      'watched',
      'watching',
      'want to watch',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //programa de tv
    [
      'all',
      'read',
      'reading',
      'want to read',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'lidos por ano',
    ], //livro
    [
      'all',
      'played',
      'playing',
      'want to play',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'jogados por ano',
    ], //jogo
    [
      'all',
      'watched',
      'watching',
      'want to watch',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //programa da internet
    [
      'all',
      'heard',
      'listening',
      'want to hear',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'ouvidos por ano',
    ], //musica
    [
      'all',
      'heard',
      'listening',
      'want to hear',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'ouvidos por ano',
    ], //album de musica
    [
      'all',
      'went',
      'going',
      'wants to go',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'idos por ano',
    ], //local
    [
      'all',
      'made',
      'making',
      'wants to make',
      'abandoned',
      'goal',
      'evaluated',
      'reviewed',
      //'feitas por ano',
    ], //receita
  ];

  List<List<String>> entitiesCategoriesPost = [
    [
      'all',
      'watched',
      'is watching',
      'wants to watch',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //filme
    [
      'all',
      'watched',
      'is watching',
      'wants to watch',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //serie
    [
      'all',
      'watched',
      'is watching',
      'wants to watch',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //anime
    [
      'all',
      'watched',
      'is watching',
      'wants to watch',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //novela
    [
      'all',
      'watched',
      'is watching',
      'wants to watch',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //programa de tv
    [
      'all',
      'read',
      'is reading',
      'wants to read',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'lidos por ano',
    ], //livro
    [
      'all',
      'played',
      'is playing',
      'wants to play',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'jogados por ano',
    ], //jogo
    [
      'all',
      'watched',
      'is watching',
      'wants to watch',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'vistos por ano',
    ], //programa da internet
    [
      'all',
      'heard',
      'is listening',
      'wants to listen',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'ouvidos por ano',
    ], //musica
    [
      'all',
      'heard',
      'is listening',
      'wants to listen',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'ouvidos por ano',
    ], //album de musica
    [
      'all',
      'went',
      'is going',
      'wants to go to',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'idos por ano',
    ], //local
    [
      'all',
      'made',
      'is making',
      'wants to make',
      'abandoned',
      'put it in the goals',
      'evaluated',
      'reviewed',
      //'feitas por ano',
    ], //receita
  ];

  List<String> typeReport = [
    'Sexual content',
    'Violent or repulsive content',
    'Hateful or abusive content',
    'Harmful or dangerous acts',
    'Spam or misleading',
  ];
}
