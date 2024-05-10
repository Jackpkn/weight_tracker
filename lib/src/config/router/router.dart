import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_exports.dart';
import '../../features/user/presentation/views/add_user.dart';
import '../../features/weight/presentation/widgets/weight_line_chart.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class Routers {
  GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: RouteName().addUser,
        builder: (context, state) => const AddUserScreen(),
      ),
      GoRoute(
        path: '${RouteName().weighListPage}/:username',
        pageBuilder: (context, state) {
          final username = state.pathParameters['username'] ?? '';
          return NoTransitionPage(
            child: WeightListPage(
              username: username,
            ),
          );
        },
      ),

      GoRoute(
        path: '/weight-chart',
        builder: (BuildContext context, GoRouterState state) {
          final extra = state.extra as Map<String, dynamic>;
          final weights = extra['weights'] as List<WeightModel?>;
          final numMonths = extra['numMonths'] as int;
          return WeightChart(
            weights: weights,
            numMonths: numMonths,
          );
        },
      )
    ],
  );
}
