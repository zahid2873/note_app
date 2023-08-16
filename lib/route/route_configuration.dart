import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/ui/edit/edit_page.dart';
import 'package:note_app/ui/home/home_page.dart';
import 'package:note_app/ui/profile/profile_page.dart';
import 'package:note_app/ui/signin/login_page.dart';

final GlobalKey<NavigatorState> key =
    GlobalKey<NavigatorState>(debugLabel: "routeNavigator");
GoRouter router = GoRouter(navigatorKey: key, routes: [
  GoRoute(
      name: 'login',
      path: '/',
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginPage());
      }),
  GoRoute(
      name: 'home',
      path: '/home',
      pageBuilder: (context, state) {
        return const MaterialPage(child: HomePage());
      }),
  GoRoute(
      name: 'edit_page',
      path: '/edit_page/:documentId',
      builder: (context, state) {
        return EditPage(
          documentId: state.pathParameters['documentId']!,
        );
      }),
  GoRoute(
      name: 'profile_page',
      path: '/profile_page',
      pageBuilder: (context, state) {
        return MaterialPage(child: ProfilePage());
      }),
]);
