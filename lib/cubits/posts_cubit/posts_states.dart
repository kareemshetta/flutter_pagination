import '../../models/post.dart';

abstract class PostStates {}

class InitialPostsState extends PostStates {}

class GetAllPostsSuccessState extends PostStates {
  final List<Post> posts;
  GetAllPostsSuccessState(this.posts);
}

class LoadingPostsState extends PostStates {
  bool isFirstLoad;
  List<Post> posts;
  LoadingPostsState(this.posts, {this.isFirstLoad = false});
}

class GetAllPostsErrorState extends PostStates {}

class GetNoMorePostState extends PostStates {}
