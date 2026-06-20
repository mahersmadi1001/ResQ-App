import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:projct/core/network/api_constants.dart';
import 'package:projct/model/post_model .dart';
import 'package:projct/service/post_service.dart';
import 'package:projct/core/erorr/erorr_handling.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostService postService;
  PostBloc({required this.postService}) : super(PostState()) {
    on<GetAllPost>((event, emit) async {
      if (!state.hasReachedMax) {
        emit(
          state.copyWith(postStatus: PostStatus.loading, errorMessage: null),
        );
        try {
          List<PostModel>? result = await postService.getAllPost(
            page: state.currentPage,
          );
          if (result != null) {
            emit(
              state.copyWith(
                posts: [...state.posts, ...result],
                postStatus: PostStatus.success,
                hasReachedMax: state.currentPage >= PostService.lastPage,
                errorMessage: null,
                currentPage: state.currentPage + 1,
              ),
            );
          } else {
            emit(
              state.copyWith(
                postStatus: PostStatus.failure,
                errorMessage: "failed to load data",
              ),
            );
          }
        } on Failure catch (e) {
          emit(
            state.copyWith(
              postStatus: PostStatus.failure,
              errorMessage: e.message,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              postStatus: PostStatus.failure,
              errorMessage: e.toString(),
            ),
          );
        }
      }
    });
  }
}
