import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  // getIt.registerSingleton<ApiService>(ApiService(Dio()));
  // getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiService>()));
  // getIt.registerSingleton<SearchRepoImpl>(
  //   SearchRepoImpl(getIt.get<ApiService>()),
  //);
}
