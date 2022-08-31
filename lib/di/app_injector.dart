// ignore: depend_on_referenced_packages
import 'package:domain/di/domain_injector.dart';
import 'package:presentation/di/presentation_injector.dart';

void initAppInjector()  {
  initDomainInjector();
  initPresentationInjector();
}
