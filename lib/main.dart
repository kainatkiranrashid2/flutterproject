import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:semesterproject/blocs/auth/auth_bloc.dart';
import 'package:semesterproject/blocs/checkout/checkout_bloc.dart';
import 'package:semesterproject/blocs/cart/cart_bloc.dart';
import 'package:semesterproject/blocs/category/category_bloc.dart';
import 'package:semesterproject/blocs/payment/payment_bloc.dart';
import 'package:semesterproject/blocs/search/search_bloc.dart';
import 'package:semesterproject/blocs/wishlist/wishlist_bloc.dart';
import 'package:semesterproject/cubits/login/login_cubit.dart';
import 'package:semesterproject/cubits/signup/signup_cubit.dart';
import 'package:semesterproject/models/models.dart';
import 'package:semesterproject/repositories/auth/auth_repository.dart';
import 'package:semesterproject/repositories/checkout/checkout_repository.dart';
import 'package:semesterproject/repositories/local_storage/local_storage_repository.dart';
import 'package:semesterproject/repositories/product/product_repository.dart';
import 'package:semesterproject/repositories/category/category_repository.dart';
import 'package:semesterproject/repositories/user/user_base_repository.dart';
import 'package:semesterproject/screens/config/app_router.dart';
import 'package:semesterproject/screens/config/theme.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// import 'package:semesterproject/screens/order_confirmation/order_confirmation_screen.dart';
// import 'package:semesterproject/screens/payment_selection/payment_selection.dart';
import 'package:semesterproject/simple_bloc_observer.dart';
import 'blocs/product/product_bloc.dart';
import 'screens/screens.dart';
import '.env';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = stripePublishableKey;

  await Stripe.instance.applySettings();

  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
              create: (_) => WishlistBloc(
                    localStorageRepository: LocalStorageRepository(),
                  )..add(LoadWishList())),
          BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
          BlocProvider(create: (_) => PaymentBloc()..add(LoadPaymentMethod())),
          BlocProvider(
            create: (context) => CheckoutBloc(
              authBloc: context.read<AuthBloc>(),
              cartBloc: context.read<CartBloc>(),
              paymentBloc: context.read<PaymentBloc>(),
              checkoutRepository: CheckoutRepository(),
            ),
          ),
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
          BlocProvider(
            create: (context) => SearchBloc(
              productBloc: context.read<ProductBloc>(),
            )..add(LoadSearch()),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          )
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: theme(),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: SplashScreen.routeName,
            debugShowCheckedModeBanner: false,
            home: const HomeScreen()),
      ),
    );
  }
}
