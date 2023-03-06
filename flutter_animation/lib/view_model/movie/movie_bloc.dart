import 'dart:async';
import 'package:flutter_animation/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/movie_entity.dart';
import '../../data/repository.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  Repository repository;
  int currentPage;

  MovieBloc({required this.repository, required this.currentPage})
      : super(MovieState(listMove: [])) {
    on<GetListMovie>(_getListMovie);
    add(GetListMovie(true));
  }

  FutureOr<void> _getListMovie(
      GetListMovie event, Emitter<MovieState> emit) async {
    List<Movie> list = state.listMove;
    if (event.isRefreshList) {
      emit(state.copyWith(isShowProgress: true));
      currentPage = 1;
    } else {
      emit(state.copyWith(isHasUpdateList: true));
      currentPage = state.currentPage == 0 ? 1 : state.currentPage + 1;
    }
    List<Movie> listMove = await repository.getListMovie(currentPage);

    for (Movie movieNew in listMove) {
      bool isHaveOldList = false;
      for (int i = 0; i < list.length; i++) {
        if (list[i].id == movieNew.id) {
          list[i] = movieNew;
          isHaveOldList = true;
        }
      }
      if (!isHaveOldList) {
        list = List.from(list)..add(movieNew);
      }
    }
    if (event.isRefreshList) {
      emit(state.copyWith(listMove: list, isShowProgress: false));
    } else {
      emit(state.copyWith(
          listMove: list,
          isShowProgress: false,
          currentPage: currentPage,
          isHasUpdateList: false));
    }
  }
}

class MovieEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class GetListMovie extends MovieEvent {
  final bool isRefreshList;

  GetListMovie(this.isRefreshList);

  @override
  List<Object?> get props => [isRefreshList];
}

class MovieState extends BlocState {
  final List<Movie> listMove;
  final bool isShowProgress;
  final int currentPage;
  final bool isHasUpdateList;

  MovieState(
      {this.listMove = const [],
      this.isShowProgress = true,
      this.currentPage = 1,
      this.isHasUpdateList = false});

  MovieState copyWith(
      {List<Movie>? listMove,
      bool? isShowProgress,
      int? currentPage,
      bool? isHasUpdateList}) {
    return MovieState(
        listMove: listMove ?? this.listMove,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        currentPage: currentPage ?? this.currentPage,
        isHasUpdateList: isHasUpdateList ?? this.isHasUpdateList);
  }

  @override
  List<Object?> get props =>
      [listMove, isShowProgress, currentPage, isHasUpdateList];
}
