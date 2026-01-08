// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_navigation_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainNavigationController on MainNavigationControllerBase, Store {
  late final _$selectedIndexAtom = Atom(
    name: 'MainNavigationControllerBase.selectedIndex',
    context: context,
  );

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$screensOptionsAtom = Atom(
    name: 'MainNavigationControllerBase.screensOptions',
    context: context,
  );

  @override
  List<Widget> get screensOptions {
    _$screensOptionsAtom.reportRead();
    return super.screensOptions;
  }

  @override
  set screensOptions(List<Widget> value) {
    _$screensOptionsAtom.reportWrite(value, super.screensOptions, () {
      super.screensOptions = value;
    });
  }

  late final _$MainNavigationControllerBaseActionController = ActionController(
    name: 'MainNavigationControllerBase',
    context: context,
  );

  @override
  void screenSelect(int newSelectedIndex) {
    final _$actionInfo = _$MainNavigationControllerBaseActionController
        .startAction(name: 'MainNavigationControllerBase.screenSelect');
    try {
      return super.screenSelect(newSelectedIndex);
    } finally {
      _$MainNavigationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex},
screensOptions: ${screensOptions}
    ''';
  }
}
