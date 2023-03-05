import 'package:drift/drift.dart';
import 'package:flutter_animation/data/local_data/database_movie.dart';
import 'package:flutter_animation/utils/constans/api_parameter_const.dart';

/// class Movie
class Movie implements Insertable<Movie> {
  //"adult":false,
  final bool? adult;

  //"backdrop_path":"/b1Y8SUb12gPHCSSSNlbX4nB3IKy.jpg",
  final String? backdropPath;

  //"genre_ids":[16,12,35],
  final String? genreIds;

  //"id":315162,
  final int? id;

  //"original_language":"en",
  final String? originalLanguage;

  //"original_title":"Puss in Boots: The Last Wish",
  final String? originalTitle;

  //"overview":"Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.",
  final String? overview;

  //"popularity":2311.833,
  final double? popularity;

  //"poster_path":"/kuf6dutpsT0vSVehic3EZIqkOBt.jpg",
  final String? posterPath;

  //"release_date":"2022-12-07",
  final String? releaseDate;

  //"title":"Puss in Boots: The Last Wish",
  final String? title;

  //"video":false,
  final bool? video;

  //"vote_average":8.4,
  final double? voteAverage;

  //"vote_count":4159
  final int? voteCount;

  Movie({
    this.adult = false,
    this.backdropPath = '',
    this.genreIds = '[]',
    this.id = 0,
    this.originalLanguage = '',
    this.originalTitle = '',
    this.posterPath = '',
    this.popularity = 0,
    this.releaseDate = '',
    this.video = false,
    this.voteAverage = 0,
    this.voteCount = 0,
    this.overview = '',
    this.title = '',
  });

  Movie.copyWith(
    Movie move,
  )   : adult = move.adult,
        backdropPath = move.backdropPath,
        genreIds = move.genreIds,
        id = move.id,
        originalLanguage = move.originalLanguage,
        originalTitle = move.originalTitle,
        posterPath = move.posterPath,
        popularity = move.popularity,
        releaseDate = move.releaseDate,
        video = move.video,
        voteAverage = move.voteAverage,
        voteCount = move.voteCount,
        overview = move.overview,
        title = move.title;

  Movie.fromJson(
    Map<String, dynamic> json,
  )   : adult = json[ApiParameterConst.adult],
        backdropPath = json[ApiParameterConst.backdropPath],
        genreIds = "${json[ApiParameterConst.genreIds]}",
        id = json[ApiParameterConst.id],
        originalLanguage = json[ApiParameterConst.originalLanguage],
        originalTitle = json[ApiParameterConst.originalTitle],
        posterPath = json[ApiParameterConst.posterPath],
        popularity = json[ApiParameterConst.popularity],
        releaseDate = json[ApiParameterConst.releaseDate],
        video = json[ApiParameterConst.video],
        voteAverage = double.parse("${json[ApiParameterConst.voteAverage]}"),
        voteCount = json[ApiParameterConst.voteCount],
        overview = json[ApiParameterConst.overview],
        title = json[ApiParameterConst.title];

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return MovieTableCompanion(
            adult: Value(adult),
            backdropPath: Value(backdropPath),
            genreIds: Value(genreIds),
            id: Value(id),
            originalLanguage: Value(originalLanguage),
            originalTitle: Value(originalTitle),
            posterPath: Value(posterPath),
            popularity: Value(popularity),
            releaseDate: Value(releaseDate),
            video: Value(video),
            voteAverage: Value(voteAverage),
            voteCount: Value(voteCount),
            overview: Value(overview),
            title: Value(title))
        .toColumns(nullToAbsent);
  }
}
