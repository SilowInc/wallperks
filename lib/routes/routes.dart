import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallperks/view/BottomNavBar.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const BottomNavBar();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const BottomNavBar();
          },
        ),
      ],
    ),
  ],
);
