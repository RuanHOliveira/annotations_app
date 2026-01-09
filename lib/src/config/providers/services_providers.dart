import 'package:annotations_app/src/data/services/session_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildServicesProviders() => [
  Provider<SessionService>(create: (context) => SessionService()),
];
