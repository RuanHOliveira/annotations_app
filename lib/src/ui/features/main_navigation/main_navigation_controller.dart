import 'package:annotations_app/src/ui/features/annotations/annotations_screen.dart';
import 'package:annotations_app/src/ui/features/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'main_navigation_controller.g.dart';

class MainNavigationController = MainNavigationControllerBase
    with _$MainNavigationController;

abstract class MainNavigationControllerBase with Store {
  @observable
  int selectedIndex = 0;

  @observable
  List<Widget> screensOptions = [AnnotationsScreen(), DetailsScreen()];

  @action
  void screenSelect(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;
  }
}
