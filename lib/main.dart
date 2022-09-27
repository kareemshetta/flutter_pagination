import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/observer_cubit.dart';

import './cubits/posts_cubit/post_cubit.dart';
import './network/dio_helper/dio_helper.dart';
import './screens/posts_screen.dart';

void main() {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const PostsApp());
}

class PostsApp extends StatelessWidget {
  const PostsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit()..getPosts(),
      child: MaterialApp(
        title: 'Flutter Pagination',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: PostsScreen(),
      ),
    );
  }
}
