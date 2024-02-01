import 'package:go_router/go_router.dart';
import 'package:pandas/pages/home.dart';
import 'package:pandas/pages/login.dart';

class AppRouter {
  GoRouter appRouter = GoRouter(routes: [
    GoRoute(
        path: "/login",
        name: "login",
        builder: (ctx, state) {
          return const Login();
        }),
    GoRoute(
        path: "/",
        name: "home",
        builder: (ctx, state) {
          return const Home();
        })
  ]);
}
