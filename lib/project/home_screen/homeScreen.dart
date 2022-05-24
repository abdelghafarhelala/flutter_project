import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_second/layout/todo_app/cubit/cubit.dart';
import 'package:flutter_second/layout/todo_app/cubit/states.dart';
import 'package:flutter_second/project/add_post/addPostScreen.dart';
import 'package:flutter_second/project/setting_app/setting.dart';
import 'package:flutter_second/project/show_post_screen/show_post.dart';
import 'package:flutter_second/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: [
                // ignore: prefer_const_constructors
                Image(
                  image: AssetImage(
                    'assets/images/home.jpeg',
                  ),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      defaultButtom(
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddScreen(),
                                ));
                          },
                          text: 'Add Post'),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButtom(
                          function: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ShowPostScreen();
                              },
                            ));
                          },
                          text: 'Show Posts'),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButtom(
                          function: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SettingScreen();
                              },
                            ));
                          },
                          text: 'Setting'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
