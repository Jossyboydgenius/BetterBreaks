import 'package:get_it/get_it.dart';
import 'package:better_breaks/app/flavor_config.dart';

final GetIt locator = GetIt.instance;

Future<void> setUpLocator(AppFlavorConfig config) async {
  // Initialize flavor config
  AppFlavorConfig.initialize(config);
  
  // Register the AppFlavorConfig instance
  locator.registerSingleton<AppFlavorConfig>(config);
  
  // Register services
  // Example:
  // locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  
  // Register repositories
  // Example:
  // locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(locator()));
  
  // Register blocs
  // Example:
  // locator.registerFactory<AuthBloc>(() => AuthBloc(locator()));
} 