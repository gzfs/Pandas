import 'package:go_router/go_router.dart';
import 'package:pandas/pages/discover.dart';
import 'package:pandas/pages/home.dart';
import 'package:pandas/pages/login.dart';
import 'package:pandas/pages/signup.dart';

class AppRouter {
  GoRouter appRouter = GoRouter(routes: [
    GoRoute(
        path: "/login",
        name: "login",
        builder: (ctx, state) {
          return const Login();
        }),
    GoRoute(
        path: "/discover",
        name: "discover",
        builder: (ctx, state) {
          return const Discover();
        }),
    GoRoute(
        path: "/signup",
        name: "signup",
        builder: (ctx, state) {
          return const Register();
        }),
    GoRoute(
        path: "/",
        name: "home",
        builder: (ctx, state) {
          return const Discover();
        })
  ]);
}
