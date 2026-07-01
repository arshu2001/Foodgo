import 'package:go_router/go_router.dart';
import '../../presentation/splash/splash_view.dart';
import '../../presentation/login/login_view.dart';
import '../../presentation/register/register_view.dart';
import '../../presentation/main/main_view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
  ],
);
