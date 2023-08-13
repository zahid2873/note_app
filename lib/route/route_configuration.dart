import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/ui/edit/edit_page.dart';
import 'package:note_app/ui/home/home_page.dart';

GoRouter router = GoRouter(routes: [
  GoRoute(
      name: 'home',
      path: '/',
      pageBuilder: (context, state) {
        return const MaterialPage(child: HomePage());
      }),
  GoRoute(
      name: 'edit_page',
      path: '/edit_page/:index',
      builder: (context, state) {
        return EditPage(
          index: int.parse(state.pathParameters['index']!),
        );
      }),
      
]);
