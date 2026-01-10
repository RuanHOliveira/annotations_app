import 'package:annotations_app/src/data/services/session_service.dart';
import 'package:annotations_app/src/ui/features/annotations/annotations_controller.dart';
import 'package:annotations_app/src/ui/features/annotations/annotations_screen.dart';
import 'package:annotations_app/src/ui/features/details/details_controller.dart';
import 'package:annotations_app/src/ui/features/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'main_navigation_controller.g.dart';

class MainNavigationController = MainNavigationControllerBase
    with _$MainNavigationController;

abstract class MainNavigationControllerBase with Store {
  final AnnotationsController _annotationsController;
  final DetailsController _detailsController;
  final SessionService _sessionService;

  @observable
  int selectedIndex = 0;

  MainNavigationControllerBase({
    required AnnotationsController annotationsController,
    required DetailsController detailsController,
    required SessionService sessionService,
  }) : _annotationsController = annotationsController,
       _detailsController = detailsController,
       _sessionService = sessionService;

  @computed
  List<Widget> get screensOptions => [
    AnnotationsScreen(annotationsController: _annotationsController),
    DetailsScreen(detailsController: _detailsController),
  ];

  @action
  Future<void> screenSelect(int newSelectedIndex) async {
    selectedIndex = newSelectedIndex;

    if (newSelectedIndex == 0) {
      await _annotationsController.load();
    } else if (newSelectedIndex == 1) {
      await _detailsController.load();
    }
  }

  @action
  Future<void> clearAuth() async {
    await _sessionService.clear();
  }
}
