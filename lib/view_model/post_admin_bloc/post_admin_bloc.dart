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
      try {
        if (!state.hasReachedMax) {
          emit(
            state.copyWith(
              productStatus: PostAdminStatus.loading,
              errorMessage: null,
            ),
          );
          List<PostAdminModel>? result = await productService.getAllPostAdmin(
            page: state.currentPage,
          );
          if (result != null) {
            emit(
              state.copyWith(
                products: [...state.postsAdmin, ...result],
                productStatus: PostAdminStatus.success,
                hasReachedMax: result.length < PostService.lastPageAdmin,
                errorMessage: null,
              ),
            );
          } else {
            emit(
              state.copyWith(
                productStatus: PostAdminStatus.failure,
                errorMessage: "failed to load data",
              ),
            );
          }
        }
      } on Failure catch (e) {
        emit(
          state.copyWith(
            productStatus: PostAdminStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            productStatus: PostAdminStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
