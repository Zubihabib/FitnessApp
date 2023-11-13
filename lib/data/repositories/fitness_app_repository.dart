import 'dart:async';

import '../api_providers/fitness_app_api_provider.dart';

class FitnessAppRepository {
  final fitnessAppApiProvider = FitnessAppApiProvider();
  static final _fitnessAppRepository = FitnessAppRepository._();
  dynamic data;

  factory FitnessAppRepository() {
    return _fitnessAppRepository;
  }

  FitnessAppRepository._();

  // Gets data from API and stores it in the data variable
  Future<void> getData() async {
    var fetchedData = await fitnessAppApiProvider.getData();
    data = fetchedData;
  }

  get allData {
    return data;
  }
}
