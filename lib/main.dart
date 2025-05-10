
import 'package:bookhub_prjct/providers/theme_provider.dart';
import 'package:bookhub_prjct/routing/router.dart';
import 'package:bookhub_prjct/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TokenAdapter());
  await Hive.openBox<Token>('authBox');
  runApp(ProviderScope(child: BookHubApp()));
}

class BookHubApp extends ConsumerWidget {
  
  const BookHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'BookHUB',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeMode,
    );
  }
}