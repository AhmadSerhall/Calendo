import 'package:admin/app/data.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

// Import splash screen
import 'package:admin/features/auth/presentation/pages/splash_screen.dart'; // Adjust if needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AppRunner()));
}

class AppRunner extends ConsumerStatefulWidget {
  const AppRunner({super.key});

  @override
  ConsumerState<AppRunner> createState() => _AppRunnerState();
}

class _AppRunnerState extends ConsumerState<AppRunner> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalRef = ref;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Flexify(
        designWidth: 100.w,
        designHeight: 100.h,
        app: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Calendar App',
          themeMode: ThemeMode.system,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0XFFF4F4F4),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0XFFF4F4F4)),
            textTheme: ThemeData.light().textTheme.apply(
                  bodyColor: const Color(0xFF2A2D3E),
                ),
            canvasColor: Colors.white,
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2697FF),
              secondary: Colors.white,
              surface: Color(0XFFF4F4F4),
              inversePrimary: Color(0xFF2A2D3E),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF212332),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF212332)),
            textTheme:
                ThemeData.dark().textTheme.apply(bodyColor: Colors.white),
            canvasColor: const Color(0xFF2A2D3E),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF2697FF),
              secondary: Color(0xFF2A2D3E),
              surface: Color(0xFF212332),
              inversePrimary: Colors.white,
            ),
          ),
          home: const SplashScreen(),
        ),
      );
    });
  }
}
