import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_animation/data/entity/movie_entity.dart';
import 'package:flutter_animation/data/local_data/database_movie.dart';

import 'package:flutter_animation/data/repository.dart';
import 'package:flutter_animation/utils/constans/api_const.dart';
import 'package:flutter_animation/utils/constans/api_parameter_const.dart';
import 'package:http/http.dart';
import 'fake_repository_impl.dart';

class RepositoryImpl with Repository {
  final FakeDataSource _fakeData = FakeDataSource();
  final bool isFakeData = FakeDataSource.isFake;

  BuildContext context;

  RepositoryImpl({required this.context});

  @override
  Future<List<Movie>> getListMovie() async {
    List<Movie> lisBill = [];
    try {
      Response res = await get(Uri.parse(ApiConst.domainApi));
      String data = jsonEncode(jsonDecode(res.body)[ApiParameterConst.results]);
      lisBill = parseListMove(data);
      DatabaseMovie().insertMovie(lisBill);
    } catch (e) {
      lisBill = await DatabaseMovie().listMovieDB;
    }
    return lisBill;
  }

  List<Movie> parseListMove(String data) {
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
    return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
  }
}
