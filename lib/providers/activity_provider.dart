import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiap_hackathon/model/activity_chart_model.dart';
import 'package:fiap_hackathon/model/activity_model.dart';
import 'package:fiap_hackathon/services/activity_service.dart';
import 'package:flutter/material.dart';

class ActivityProvider extends ChangeNotifier {
  final ActivityService _activityService = ActivityService();

  final List<ActivityModel> _activitiesList = [];
  List<ActivityModel> get activitiesList => _activitiesList;

  final List<ActivityChartModel> _activitiesProfessorList = [];
  List<ActivityChartModel> get activitiesProfessorList => _activitiesProfessorList;

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

  Future getActivities([String professorReference = '']) async {
    try {
      hasError = false;
      _activitiesList.clear();

      final responseDocs =
          await _activityService.getActivities(professorReference);

      for (var element in responseDocs) {
        _activitiesList.add(ActivityModel.fromDocumentSnapshot(element));
      }
    } catch (e) {
      debugPrint('getActivities ERROR ==> $e');
      hasError = true;
      errorMessage = 'Ocorreu um erro inesperado. Tente novamente!';
    }
  }

  Future getActivitiesAsProfessor(DocumentReference professorReference) async {
    try {
      hasError = false;
      _activitiesProfessorList.clear();

      final responseDocs =
          await _activityService.getActivitiesAsProfessor(professorReference);

      for (var element in responseDocs) {
        _activitiesProfessorList.add(ActivityChartModel.fromDocumentSnapshot(element));
      }
    } catch (e) {
      debugPrint('getActivitiesAsProfessor ERROR ==> $e');
      hasError = true;
      errorMessage = 'Ocorreu um erro inesperado. Tente novamente!';
    }
  }

  Future confirmSelection(ActivityModel activity) async {
    try {
      hasError = false;

      await _activityService
          .confirmSelection(activity.toConfirmSelectionJson());

      _activitiesList
          .firstWhere((i) => i.documentReference == activity.documentReference)
          .alternativaSelecionada = activity.alternativaSelecionada;
    } catch (e) {
      debugPrint('confirmSelection ERROR ==> $e');
      hasError = true;
      errorMessage = 'Ocorreu um erro inesperado. Tente novamente!';
    }

    notifyListeners();
  }
}
