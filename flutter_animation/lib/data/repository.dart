import 'dart:async';

import 'entity/movie_entity.dart';

abstract class Repository {
  Future<List<Movie>> getListMovie(int page);
}
