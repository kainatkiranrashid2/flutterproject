import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semesterproject/blocs/cart/cart_bloc.dart';
import 'package:semesterproject/blocs/category/category_bloc.dart';
import 'package:semesterproject/blocs/wishlist/wishlist_bloc.dart';
import 'package:semesterproject/repositories/product/product_repository.dart';
import 'package:semesterproject/repositories/category/category_repository.dart';
import 'package:semesterproject/screens/config/app_router.dart';
import 'package:semesterproject/screens/config/theme.dart';
import 'package:semesterproject/simple_bloc_observer.dart';
import 'blocs/product/product_bloc.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WishlistBloc()..add(LoadWishList())),
        BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(
              LoadCategories(),
            ),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen()),
    );
  }
}
