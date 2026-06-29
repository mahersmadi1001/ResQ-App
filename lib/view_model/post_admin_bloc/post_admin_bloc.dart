import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/model/post_admin_model.dart';
import 'package:projct/service/post_service.dart';

part 'post_admin_event.dart';
part 'post_admin_state.dart';

class PostAdminBloc extends Bloc<ProductEvent, PostAdminState> {
  PostService productService;
  PostAdminBloc({required this.productService}) : super(PostAdminState()) {
    on<GetAllPostAdmin>((event, emit) async {
      // تجاهل الطلب إذا كان يتحمل بالفعل ولم يكن refresh
      if (state.postAdminStatus == PostAdminStatus.loading && !event.isRefresh) {
        return;
      }

      if (event.isRefresh) {
        // إعادة تعيين الحالة عند الـ refresh
        emit(PostAdminState(
          postsAdmin: const [],
          postAdminStatus: PostAdminStatus.loading,
          currentPage: 1,
          hasReachedMax: false,
          errorMessage: null,
        ));
      } else {
        if (state.hasReachedMax) return;
        emit(state.copyWith(
          postAdminStatus: PostAdminStatus.loading,
          errorMessage: null,
        ));
      }

      try {
        List<PostAdminModel>? result = await productService.getAllPostAdmin(
          page: state.currentPage,
        );
        if (result != null) {
          emit(
            state.copyWith(
              postsAdmin: [...state.postsAdmin, ...result],
              postAdminStatus: PostAdminStatus.success,
              hasReachedMax: state.currentPage >= PostService.lastPageAdmin,
              currentPage: state.currentPage + 1,
              errorMessage: null,
            ),
          );
        } else {
          emit(
            state.copyWith(
              postAdminStatus: PostAdminStatus.failure,
              errorMessage: "failed to load data",
            ),
          );
        }
      } on Failure catch (e) {
        emit(
          state.copyWith(
            postAdminStatus: PostAdminStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            postAdminStatus: PostAdminStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}

