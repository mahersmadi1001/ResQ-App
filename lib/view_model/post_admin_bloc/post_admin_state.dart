// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_admin_bloc.dart';

enum PostAdminStatus { initial, success, failure, loading }

class PostAdminState extends Equatable {
  List<PostAdminModel> postsAdmin;
  PostAdminStatus postAdminStatus;
  String? errorMessage;
  bool hasReachedMax;
  int currentPage;

  PostAdminState({
    this.currentPage = 1,
    this.postsAdmin = const [],
    this.postAdminStatus = PostAdminStatus.initial,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  PostAdminState copyWith({
    int? currentPage,
    List<PostAdminModel>? products,
    PostAdminStatus? productStatus,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return PostAdminState(
      currentPage: currentPage ?? this.currentPage,
      postsAdmin: products ?? this.postsAdmin,
      postAdminStatus: productStatus ?? this.postAdminStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    postsAdmin,
    postAdminStatus,
    errorMessage,
    hasReachedMax,
  ];
}
