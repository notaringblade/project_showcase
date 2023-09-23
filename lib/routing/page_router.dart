import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:project_showcase/auth/auth_state.dart';
import 'package:project_showcase/models/post_model.dart';
import 'package:project_showcase/models/user_model.dart';
import 'package:project_showcase/routing/route_constants.dart';
import 'package:project_showcase/screens/create_post.dart';
import 'package:project_showcase/screens/post_screen.dart';

final GoRouter appRouter = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthState();
      },
      routes: <GoRoute>[
        GoRoute(
          path: 'createPost',
          name: RouteConstants.createPost,
          pageBuilder: (BuildContext context, GoRouterState state) {
            UserModel user = state.extra as UserModel;
            return CupertinoPage(child: CreatePost(user: user));
          },
        ),
        GoRoute(
          path: 'postScreen/:id/:uid',
          name: RouteConstants.postScreen,
          pageBuilder: (BuildContext context, GoRouterState state) {
            PostModel post = state.extra as PostModel;
            final postId = state.pathParameters['id'];
            final uid = state.pathParameters['uid'];
            return CupertinoPage(
                child: PostScreen(
              uid: uid!,
              postId: postId!,
              post: post,
            ));
          },
        ),
      ])
]);
