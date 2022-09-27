import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/posts_cubit/post_cubit.dart';
import '../cubits/posts_cubit/posts_states.dart';
import '../widgets/post_item.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key? key}) : super(key: key);
  final listController = ScrollController();
  void repeat(BuildContext context) async {
    listController.addListener(() {
      // this listController.position.atEdge will be true if listview is at bottom  or top
      if (listController.position.atEdge) {
        if (listController.position.pixels != 0) {
          PostsCubit.get(context).getPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    repeat(context);
    return BlocConsumer<PostsCubit, PostStates>(listener: (context, state) {
      if (state is GetNoMorePostState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('opps!.. there is no more posts'),
          ),
        );
      }
    }, builder: (context, state) {
      final posts = PostsCubit.get(context).posts;
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'posts',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ConditionalBuilder(
          condition: (state is LoadingPostsState && state.isFirstLoad),
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          fallback: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      controller: listController,
                      itemBuilder: (context, index) {
                        return PostItem(
                            postId: posts[index].id,
                            postBody: posts[index].body,
                            postTitle: posts[index].body);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 3,
                          color: Colors.white,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        );
                      },
                      itemCount: posts.length),
                ),
                if (state is LoadingPostsState && !state.isFirstLoad)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      );
    });
  }
}
