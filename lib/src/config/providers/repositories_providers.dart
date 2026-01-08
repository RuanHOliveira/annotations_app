import 'package:annotations_app/src/data/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildRepositoriesProviders() => [
  Provider<UserRepository>(create: (context) => UserRepository()),
];
