import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_second/layout/todo_app/cubit/cubit.dart';
import 'package:flutter_second/layout/todo_app/cubit/states.dart';
import 'package:flutter_second/shared/colors.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        bool mode = false;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Setting'),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  width: 10,
                ),
                FlutterSwitch(
                  inactiveColor: Colors.white,
                  inactiveToggleColor: Colors.grey,
                  activeColor: primaryColor,
                  activeText: 'Dark',
                  height: 30,
                  width: 70,
                  inactiveSwitchBorder: Border.all(color: Colors.black),
                  activeTextColor: Colors.white,
                  value: AppCubit.get(context).isDark,
                  onToggle: (value) {
                    print(value);
                    AppCubit.get(context).changeAppTheme();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
