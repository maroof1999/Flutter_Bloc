import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc_project/module/internet_connectivity/internet_bloc/internet_event.dart';
import 'package:flutter_bloc_project/module/internet_connectivity/internet_bloc/internet_state.dart';


class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>(
      (event, emit) {
        return emit(InternetLostState());
      },
    );
    on<InternetConnectedEvent>(
      (event, emit) {
        return emit(InternetConnectedState());
      },
    );
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetConnectedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
