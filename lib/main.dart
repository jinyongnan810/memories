import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memories/firebase_options.dart';
import 'package:memories/pages/add_memory_page.dart';
import 'package:memories/pages/edit_memory_page.dart';
import 'package:memories/pages/friends_page.dart';
import 'package:memories/pages/home.dart';
import 'package:memories/pages/memory_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: 'env');
  GoogleFonts.config.allowRuntimeFetching = false;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '思い出の星空',
      theme: _buildTheme(Brightness.dark),
      routerConfig: _router,
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.reggaeOneTextTheme(baseTheme.textTheme),
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Home(),
        routes: [
          GoRoute(
            path: 'friends',
            builder: (context, state) => const FriendsPage(),
          ),
          GoRoute(
            path: 'add',
            builder: (context, state) => const AddMemoryPage(),
          ),
          GoRoute(
            path: 'memories/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return MemoryPage(id: id);
            },
          ),
          GoRoute(
            path: 'memories/:id/edit',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return EditMemoryPage(id: id);
            },
          ),
        ],
      ),
    ],
  );
}
