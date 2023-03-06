import 'package:flutter_animation/data/entity/movie_entity.dart';
import 'package:flutter_animation/data/repository.dart';

class FakeDataSource extends Repository {
  static bool get isFake => false;

  @override
  Future<List<Movie>> getListMovie(int page) {
    // TODO: implement getListMove
    throw UnimplementedError();
  }
}
