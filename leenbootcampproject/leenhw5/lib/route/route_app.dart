import 'package:leenhw5/screens/user_profile_activity.dart';
import 'package:leenhw5/screens/users_list_screen.dart';
import 'package:leenhw5/route/route_key.dart';
import 'package:go_router/go_router.dart';

class RouteApp {
  RouteApp._();

  static final routes = GoRouter(
    initialLocation: RoutesKey.usersList,
    routes: [
      GoRoute(
        path: RoutesKey.usersList,
        builder: (context, state) => const UserListScreen(),
      ),
      
      GoRoute(
        path: RoutesKey.userProfile,
        builder: (context, state) {
          final idString = state.pathParameters['userId']!;
          final userId = int.parse(idString);
          return UserProfileActivityScreen(userId: userId);
        },
      ),
    ],
  );
}
