import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

class SetupDI {
  const SetupDI();

  Future<void> setupDI(Flavor flavor) async {
    AppDI.initDependencies(appLocator, flavor);
    await DataDI.initDependencies(appLocator);
    DomainDI.initDependencies(appLocator);
    NavigationDI.initDependencies(appLocator);
  }
}
