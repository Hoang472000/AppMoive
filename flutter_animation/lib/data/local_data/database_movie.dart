
import 'dart:io';
import 'package:flutter_animation/data/entity/movie_entity.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_animation/data/local_data/table/movie_table.dart';
import 'package:path_provider/path_provider.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'database_movie.g.dart';
@DriftDatabase(tables: [MovieTable])
class DatabaseMovie extends _$DatabaseMovie{
  DatabaseMovie() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;
  
  Future<List<Movie>> get listMovieDB => select(movieTable).get();

  ///Thêm user vào DB, nếu đã có trong DB thì update
  void insertMovie(List<Movie> values) {
    batch((batch) {
      batch.insertAllOnConflictUpdate(movieTable, values);
    });
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db_movie.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}