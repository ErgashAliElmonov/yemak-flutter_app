import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/auth_store.dart';
import 'package:yemak_app/store/category_store.dart';
import 'package:yemak_app/store/layout_change_tap.dart';
import 'package:yemak_app/store/product_store.dart';
import 'package:yemak_app/store/restaurants_store.dart';
import 'package:yemak_app/store/search_store.dart';
import 'package:yemak_app/ui/pages/login/login.dart';
import 'package:yemak_app/ui/pages/restaurant/restaurant.dart';
import 'package:yemak_app/ui/widgets/layout.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LayoutChangeTap()),
        ChangeNotifierProvider(create: (_) => CategoryStore()),
        ChangeNotifierProvider(create: (_) => RestaurantsStore()),
        ChangeNotifierProvider(create: (_) => ProductStore()),
        ChangeNotifierProvider(create: (_) => SearchStore()),
        ChangeNotifierProvider(create: (_) => AuthStore()),
      ],
      child: const MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => Layout()),
    GoRoute(path: '/login', builder: (context, state) => Login()),
       GoRoute(
      path: '/restaurant/:id',
      builder:
          (context, state) =>
              Restaurant(id: state.pathParameters["id"].toString()),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,

      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
