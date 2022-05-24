import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_second/layout/todo_app/cubit/cubit.dart';
import 'package:flutter_second/layout/todo_app/cubit/states.dart';
import 'package:flutter_second/project/home_screen/homeScreen.dart';
import 'package:flutter_second/shared/cache_Helper.dart';
import 'package:flutter_second/shared/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool isDark = true;
  if (CacheHelper.getData(key: 'isDark') != null) {
    isDark = CacheHelper.getData(key: 'isDark');
  } else {
    isDark = isDark;
  }
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.isDark}) : super(key: key);
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..createDatabase()
        ..changeAppTheme(fromCache: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
