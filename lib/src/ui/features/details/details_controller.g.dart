// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailsController on DetailsControllerBase, Store {
  late final _$annotationsDetailsAtom = Atom(
    name: 'DetailsControllerBase.annotationsDetails',
    context: context,
  );

  @override
  AnnotationsDetails get annotationsDetails {
    _$annotationsDetailsAtom.reportRead();
    return super.annotationsDetails;
  }

  @override
  set annotationsDetails(AnnotationsDetails value) {
    _$annotationsDetailsAtom.reportWrite(value, super.annotationsDetails, () {
      super.annotationsDetails = value;
    });
  }

  late final _$selectedFilterAtom = Atom(
    name: 'DetailsControllerBase.selectedFilter',
    context: context,
  );

  @override
  String get selectedFilter {
    _$selectedFilterAtom.reportRead();
    return super.selectedFilter;
  }

  @override
  set selectedFilter(String value) {
    _$selectedFilterAtom.reportWrite(value, super.selectedFilter, () {
      super.selectedFilter = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'DetailsControllerBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'DetailsControllerBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadAsyncAction = AsyncAction(
    'DetailsControllerBase.load',
    context: context,
  );

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$DetailsControllerBaseActionController = ActionController(
    name: 'DetailsControllerBase',
    context: context,
  );

  @override
  void changeFilter(String newFilter) {
    final _$actionInfo = _$DetailsControllerBaseActionController.startAction(
      name: 'DetailsControllerBase.changeFilter',
    );
    try {
      return super.changeFilter(newFilter);
    } finally {
      _$DetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
annotationsDetails: ${annotationsDetails},
selectedFilter: ${selectedFilter},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
