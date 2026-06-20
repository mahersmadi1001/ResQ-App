part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

final class GetAllPost extends PostEvent {
  final List<String>? filterParamtr;
  final bool isRefresh;

  @override
  List<Object?> get props => [filterParamtr, isRefresh];

  GetAllPost({this.filterParamtr, this.isRefresh = false});
}
