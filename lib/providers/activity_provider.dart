import 'package:fiap_hackathon/services/activity_service.dart';
import 'package:flutter/material.dart';

class ActivityProvider extends ChangeNotifier {
  final ActivityService _activityService = ActivityService();

  bool hasError = false;
  String errorMessage = '';
  
  Future createActivity(Map<String, dynamic> json) async {
    try {
      hasError = false;
      await _activityService.createActivity(json);
    } catch (e) {
      debugPrint('createActivity ERROR ==> $e');
      hasError = true;
      errorMessage = 'Ocorreu um erro inesperado. Tente novamente!';
    }
  }
}