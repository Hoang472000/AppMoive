import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/resource/color.dart';
import 'package:flutter_animation/utils/widgets/card_movie.dart';
import 'package:flutter_animation/utils/widgets/circle_text_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/entity/movie_entity.dart';
import '../data/repository.dart';
import '../generated/l10n.dart';
import '../resource/style.dart';
import '../utils/utils.dart';
import '../utils/widgets/bkav_app_bar.dart';
import '../view_model/movie/movie_bloc.dart';

class MovePage extends StatefulWidget {
  const MovePage({Key? key}) : super(key: key);

  static Route route() {
    return Utils.pageRouteBuilder(const MovePage(), true);
  }

  @override
  State<MovePage> createState() => _MovePageState();
}

class _MovePageState extends State<MovePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieBloc(repository: context.read<Repository>(), currentPage: 1),
      child: Scaffold(
          backgroundColor: AppColor.background,
          appBar: CustomAppBar(
            context,
            showDefaultBackButton: true,
            title:
                Text("back", style: StyleBkav.textStyleFW500(Colors.black, 18)),
          ),
          body: BlocConsumer<MovieBloc, MovieState>(
              listener: (context, state) {},
              builder: (context, state) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (notification.metrics.atEdge) {
                      if (notification.metrics.pixels == 0) {
                      } else {
                        if (!state.isHasUpdateList) {
                          context.read<MovieBloc>().add(GetListMovie(false));
                        }
                      }
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<MovieBloc>().add(GetListMovie(true));
                      },
                      child: state.isShowProgress
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : state.listMove.isEmpty
                              ? Container(
                                  child: Center(
                                    child: Text(
                                      "Vui lòng kiểm tra lại kết nối internet của bạn !",
                                      style: StyleBkav.textStyleFW400(
                                          AppColor.text, 18),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 7),
                                        child: Text(
                                          "Popular list",
                                          style: StyleBkav.textStyleFW600(
                                              Colors.black54, 16),
                                        ),
                                        color: Color(0xfff5f5f5),
                                      ),
                                      Expanded(
                                        child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 2 / 3),
                                            itemCount:
                                                state.listMove.length + 1,
                                            itemBuilder: (context, index) {
                                              return index ==
                                                      state.listMove.length
                                                  ? Visibility(
                                                      visible:
                                                          state.isHasUpdateList,
                                                      child: Center(
                                                        child:
                                                            RefreshProgressIndicator(),
                                                      ))
                                                  : CardMovie.cardMovie(
                                                      state.listMove[index],
                                                      context);
                                            }),
                                      )
                                    ])),
                );
              })),
    );
  }
}
