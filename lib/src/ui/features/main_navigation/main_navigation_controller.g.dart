// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_navigation_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainNavigationController on MainNavigationControllerBase, Store {
  Computed<List<Widget>>? _$screensOptionsComputed;

  @override
  List<Widget> get screensOptions =>
      (_$screensOptionsComputed ??= Computed<List<Widget>>(
        () => super.screensOptions,
        name: 'MainNavigationControllerBase.screensOptions',
      )).value;

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

  late final _$screenSelectAsyncAction = AsyncAction(
    'MainNavigationControllerBase.screenSelect',
    context: context,
  );

  @override
  Future<void> screenSelect(int newSelectedIndex) {
    return _$screenSelectAsyncAction.run(
      () => super.screenSelect(newSelectedIndex),
    );
  }

  late final _$clearAuthAsyncAction = AsyncAction(
    'MainNavigationControllerBase.clearAuth',
    context: context,
  );

  @override
  Future<void> clearAuth() {
    return _$clearAuthAsyncAction.run(() => super.clearAuth());
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex},
screensOptions: ${screensOptions}
    ''';
  }
}
