// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fb_core/src/data/repositories/app_details_repository.dart'
    as _i3;
import 'package:fb_core/src/data/repositories/widget_details_repository.dart'
    as _i5;
import 'package:fb_core/src/data/repositories/widget_ui_repository.dart' as _i6;
import 'package:fb_core/src/services/datastore.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AppDetailsRepository>(() => _i3.AppDetailsRepository());
    gh.factory<_i4.Datastore>(() => _i4.Datastore());
    gh.factory<_i5.WidgetDetailsRepository>(
        () => _i5.WidgetDetailsRepository());
    gh.factory<_i6.WidgetUIRepository>(() => _i6.WidgetUIRepository());
    return this;
  }
}
