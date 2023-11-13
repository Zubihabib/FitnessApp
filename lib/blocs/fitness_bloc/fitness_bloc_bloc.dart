import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'fitness_bloc_event.dart';
part 'fitness_bloc_state.dart';

class FitnessBlocBloc extends Bloc<FitnessBlocEvent, FitnessBlocState> {
  FitnessBlocBloc() : super(FitnessBlocInitialState()) {
    on<FitnessBlocEvent>(_doSomething);
  }

  _doSomething(FitnessBlocEvent event, Emitter<FitnessBlocState> emit) {}
}
