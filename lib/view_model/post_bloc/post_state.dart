// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

enum PostStatus { initial, success, failure, loading }

class PostState extends Equatable {
  List<PostModel> posts;
  PostStatus postStatus;
  String? errorMessage;
  bool hasReachedMax;
  int currentPage;

  PostState({
    this.posts = const [],
    this.postStatus = PostStatus.initial,
    this.hasReachedMax = false,
    this.errorMessage,
    this.currentPage = 1,
  });

  PostState copyWith({
    List<PostModel>? posts,
    PostStatus? postStatus,
    String? errorMessage,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      postStatus: postStatus ?? this.postStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props =>
      [posts, postStatus, errorMessage, hasReachedMax, currentPage];
}
