import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation/view/movie.dart';
import 'package:flutter_animation/view_model/movie/movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository.dart';
import 'data/repository_impl.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Repository repository;

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    repository = RepositoryImpl(context: context);
    // Tạm thời tắt chế độ xoay ngang màn hình
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => MovieBloc(repository: repository, currentPage: 1),
        child: MaterialApp(
            theme: ThemeData(
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black),
                    color: Color(0xfff5f5f5))),
            home: MovePage()),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
