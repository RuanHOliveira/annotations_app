import 'package:annotations_app/src/config/providers/controllers_providers.dart';
import 'package:annotations_app/src/config/providers/repositories_providers.dart';
import 'package:annotations_app/src/config/providers/services_providers.dart';
import 'package:annotations_app/src/ui/core/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// Todos os providers centralizados
List<SingleChildWidget> buildAppProviders() => [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ...buildServicesProviders(),
  ...buildRepositoriesProviders(),
  ...buildControllersProviders(),
];
