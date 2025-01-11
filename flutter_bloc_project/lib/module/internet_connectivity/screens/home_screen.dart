import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/module/internet_connectivity/internet_bloc/internet_bloc.dart';
import 'package:flutter_bloc_project/module/internet_connectivity/internet_bloc/internet_state.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetBloc, InternetState>(
              builder: (context, state) {
                if (state is InternetConnectedState) {
                  return const Text('Internet Connected');
                } else if (state is InternetLostState) {
                  return const Text('Internet Lost');
                } else {
                  return const Text('Loading');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
