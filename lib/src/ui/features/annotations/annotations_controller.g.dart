// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotations_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnnotationsController on AnnotationsControllerBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'AnnotationsControllerBase.isLoading',
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
    name: 'AnnotationsControllerBase.errorMessage',
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

  late final _$annotationsAtom = Atom(
    name: 'AnnotationsControllerBase.annotations',
    context: context,
  );

  @override
  ObservableList<Annotation> get annotations {
    _$annotationsAtom.reportRead();
    return super.annotations;
  }

  @override
  set annotations(ObservableList<Annotation> value) {
    _$annotationsAtom.reportWrite(value, super.annotations, () {
      super.annotations = value;
    });
  }

  late final _$loadAsyncAction = AsyncAction(
    'AnnotationsControllerBase.load',
    context: context,
  );

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$createAsyncAction = AsyncAction(
    'AnnotationsControllerBase.create',
    context: context,
  );

  @override
  Future<void> create({required String title, required String content}) {
    return _$createAsyncAction.run(
      () => super.create(title: title, content: content),
    );
  }

  late final _$updateAsyncAction = AsyncAction(
    'AnnotationsControllerBase.update',
    context: context,
  );

  @override
  Future<void> update(Annotation updated) {
    return _$updateAsyncAction.run(() => super.update(updated));
  }

  late final _$deleteAsyncAction = AsyncAction(
    'AnnotationsControllerBase.delete',
    context: context,
  );

  @override
  Future<void> delete(int annotationId) {
    return _$deleteAsyncAction.run(() => super.delete(annotationId));
  }

  late final _$deleteAllAsyncAction = AsyncAction(
    'AnnotationsControllerBase.deleteAll',
    context: context,
  );

  @override
  Future<void> deleteAll() {
    return _$deleteAllAsyncAction.run(() => super.deleteAll());
  }

  late final _$resetAsyncAction = AsyncAction(
    'AnnotationsControllerBase.reset',
    context: context,
  );

  @override
  Future<void> reset() {
    return _$resetAsyncAction.run(() => super.reset());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
annotations: ${annotations}
    ''';
  }
}
