import 'package:fb_core/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final gi = GetIt.instance;

@InjectableInit()
void configureDependencies() => gi.init();
