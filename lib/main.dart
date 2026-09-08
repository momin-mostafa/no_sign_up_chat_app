import 'package:addiits_technology_practical_test/features/chat_room/chat_provider.dart';
import 'package:addiits_technology_practical_test/features/chat_room/data/chat_repository.dart';
import 'package:addiits_technology_practical_test/features/join/join.view.dart';
import 'package:addiits_technology_practical_test/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:addiits_technology_practical_test/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ChatRepository>(
          create: (_) => FirestoreChatRepository(),
        ),
        ChangeNotifierProxyProvider<ChatRepository, ChatProvider>(
          create: (context) =>
              ChatProvider(repository: context.read<ChatRepository>()),
          update: (context, repository, chatProvider) =>
              chatProvider ?? ChatProvider(repository: repository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarThemeData(backgroundColor: ChatAppColors.white),
          colorScheme: .fromSeed(seedColor: ChatAppColors.indigo),
          scaffoldBackgroundColor: ChatAppColors.white,
          // useMaterial3: true,
          inputDecorationTheme: InputDecorationThemeData(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).dividerColor.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).dividerColor.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: ChatAppColors.indigo),
            ),
            filled: true,
            fillColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            isDense: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ChatAppColors.indigo,
              foregroundColor: ChatAppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: ChatAppColors.deepGrey),
          ),
        ),
        home: const JoinView(),
      ),
    );
  }
}