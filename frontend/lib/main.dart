import 'package:cinequest/cinequest_movie.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const CineQuestMovie());
}
