import 'package:admin/app/data.dart';
import 'package:admin/app/responsive.dart';
import 'package:admin/core/constants/constraints.dart';
import 'package:admin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:admin/features/auth/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    return Sizer(
      builder: (context, orientation, deviceType) {
        if (!isConstraintsInitialized) {
          bottomSafeArea = MediaQuery.of(context).padding.bottom;
          topSafeArea = MediaQuery.of(context).padding.top;
          isTablet = Responsive.isTablet(context);
          isConstraintsInitialized = true;
        }
        return Flexify(
          designWidth: 100.w,
          designHeight: 100.h,
          app: const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Calendar App',
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
