import 'package:amaris_consulting/features/welcome/bloc/welcome_bloc.dart';
import 'package:amaris_consulting/features/welcome/page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // Multi Bloc Provider
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<WelcomeBloc>(
        create: (BuildContext context) => WelcomeBloc()
      )
    ],
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallet FPV - FIC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: WelcomePage(),
    );
  }
}