import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/movie_entity.dart';
import '../../data/repository.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  Repository repository;

  MovieBloc({required this.repository}) : super(MovieState(listMove: [])) {
    on<GetListMovie>(_getListMovie);
    add(GetListMovie());
  }

  FutureOr<void> _getListMovie(
      GetListMovie event, Emitter<MovieState> emit) async {
    emit(state.copyWith(isShowProgress: true));
    List<Movie> listMove = await repository.getListMovie();

    emit(state.copyWith(listMove: listMove, isShowProgress: false));
  }
}

class MovieEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListMovie extends MovieEvent {
  @override
  List<Object?> get props => [];
}

class MovieState extends BlocState {
  final List<Movie> listMove;
  final bool isShowProgress;

  MovieState({this.listMove = const [], this.isShowProgress = true});

  MovieState copyWith({List<Movie>? listMove, bool? isShowProgress}) {
    return MovieState(
        listMove: listMove ?? this.listMove,
        isShowProgress: isShowProgress ?? this.isShowProgress);
  }

  @override
  List<Object?> get props => [listMove, isShowProgress];
}
