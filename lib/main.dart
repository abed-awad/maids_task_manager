import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/helpers/helper.dart';
import 'package:task_manager/db/local_storage.dart';
import 'package:task_manager/providers/auth.dart';
import 'package:task_manager/providers/home.dart';
import 'package:task_manager/providers/splash.dart';
import 'package:task_manager/providers/user_todo.dart';
import 'package:task_manager/screens/splash/splash.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/styles/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage().init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorsStyle.whiteColor,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Orientation.portrait == MediaQuery.of(context).orientation
          ? const Size(360, 690)
          : const Size(690, 360),
      builder: (_, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SplashController()),
          ChangeNotifierProvider(create: (_) => AuthController()),
          ChangeNotifierProvider(create: (_) => HomeController()),
          ChangeNotifierProvider(create: (_) => UserTodoController()),
        ],
        child: MaterialApp(
          title: 'Task Manager App',
          theme: ThemesStyle.theme,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          ),
          home: const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: SplashScreen(),
          ),
        ),
      ),
    );
  }
}
