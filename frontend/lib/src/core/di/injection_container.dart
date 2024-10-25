import 'package:cinequest/src/common/common_dependency.dart';
import 'package:cinequest/src/data/data_dependency.dart';
import 'package:cinequest/src/domain/domain_dependency.dart';
import 'package:cinequest/src/external/external_dependency.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  ExternalDependency.init();
  DataDependency.init();
  CommonDependency.init();
  DomainDependency.init();
}
