import 'package:get_it/get_it.dart';
import 'package:rehab/core/di/configure_dependencies.config.dart';
import 'package:injectable/injectable.dart';
import 'package:rehab/features/home/di/home_di.dart';

@InjectableInit(
  initializerName: 'init', 
  preferRelativeImports: true,
  asExtension: true, 
  generateForDir: ['lib/core'],
)

Future<void> configureDependencies() async {
  final getIt = GetIt.instance;
  getIt.init();
    configureHome(getIt);
}
