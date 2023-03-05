import 'package:drift/drift.dart';
import 'package:flutter_animation/data/entity/movie_entity.dart';

@UseRowClass(Movie)
class MovieTable extends Table {
  @override
  String get tableName => 'movie';

  BoolColumn get adult => boolean().nullable()();

  TextColumn get backdropPath => text().nullable()();

  TextColumn get genreIds => text().nullable()();

  IntColumn get id => integer().nullable()();

  TextColumn get originalLanguage => text().nullable()();

  TextColumn get originalTitle => text().nullable()();

  TextColumn get overview => text().nullable()();

  RealColumn get popularity => real().nullable()();

  TextColumn get posterPath => text().nullable()();

  TextColumn get releaseDate => text().nullable()();

  TextColumn get title => text().nullable()();

  BoolColumn get video => boolean().nullable()();

  RealColumn get voteAverage => real().nullable()();

  IntColumn get voteCount => integer().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}
