import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/dio_helper/dio_helper.dart';
import '../../cubits/posts_cubit/posts_states.dart';
import '../../models/post.dart';

class PostsCubit extends Cubit<PostStates> {
  PostsCubit() : super(InitialPostsState());

  static PostsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int pageIndex = 1;
  final List<Post> _posts = [];

  List<Post> get posts {
    return [..._posts];
  }

  Future<void> getPosts() async {
    int oldPostsLength = _posts.length;
    List<Post> newPosts = [];
    emit(
      LoadingPostsState(posts, isFirstLoad: pageIndex == 1),
    );
    try {
      final response =
          await DioHelper.getData({'_page': pageIndex, '_limit': 15});
      final responseData = (response.data as List);
      // print(response.data);
      newPosts = responseData.map((element) => Post.fromJson(element)).toList();
      for (var element in responseData) {
        final post = Post.fromJson(element);
        print('post id :${post.id}');
        _posts.add(post);
      }
      if (_posts.length == oldPostsLength) {
        emit(GetNoMorePostState());
      } else {
        emit(GetAllPostsSuccessState(newPosts));
        pageIndex++;
        print('pageIndex:$pageIndex');
      }
    } catch (err) {
      print(err);
      emit(GetAllPostsErrorState());
    }
  }
}
