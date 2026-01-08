// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterController on RegisterControllerBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'RegisterControllerBase.isLoading',
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
    name: 'RegisterControllerBase.errorMessage',
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

  late final _$registerAsyncAction = AsyncAction(
    'RegisterControllerBase.register',
    context: context,
  );

  @override
  Future<User?> register({
    required String email,
    required String password,
    required String name,
  }) {
    return _$registerAsyncAction.run(
      () => super.register(email: email, password: password, name: name),
    );
  }

  late final _$RegisterControllerBaseActionController = ActionController(
    name: 'RegisterControllerBase',
    context: context,
  );

  @override
  void clearError() {
    final _$actionInfo = _$RegisterControllerBaseActionController.startAction(
      name: 'RegisterControllerBase.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$RegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
