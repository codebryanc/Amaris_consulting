import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:amaris_consulting/features/welcome/bloc/welcome_bloc.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();

    context.read<WelcomeBloc>().add(DoGetWallet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
        Expanded(child: 
          Row(
            children: [
              // Image
              Image.asset(
                'lib/core/assets/logo.png',
                height: 45,
              ),

              // Your current wallet
              const Spacer(),
              Text(" \$ 300", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
            ]
          )
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Bienvenido", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      )
    );
  }
}