import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frame_app_flutter/app/ui/authentication/authentication_cubit.dart';
import 'package:frame_app_flutter/app/ui/home/home_page.dart';
import 'package:frame_app_flutter/app/ui/login/login_page.dart';
import 'package:frame_app_flutter/app/ui/splash/splash_page.dart';
import 'package:frame_app_flutter/config/service_locator.dart';
import 'package:frame_app_flutter/l10n/l10n.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _key = GlobalKey<NavigatorState>();
  NavigatorState get navigator => _key.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthenticationCubit>(),
      child: MaterialApp(
        navigatorKey: _key,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.black,
          ),
          appBarTheme: const AppBarTheme(color: Colors.black),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode) {
              return supportedLocale;
            }
          }
          return const Locale('es');
        },
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationUnauthenticated) {
                navigator.pushAndRemoveUntil(
                  LoginPage.route(),
                  (route) => false,
                );
              }

              if (state is AuthenticationAuthenticated) {
                navigator.pushAndRemoveUntil(
                  HomePage.route(),
                  (route) => false,
                );
              }
            },
            child: child,
          );
        },
        onGenerateRoute: (_) => SplashPage.route(),
      ),
    );
  }
}
