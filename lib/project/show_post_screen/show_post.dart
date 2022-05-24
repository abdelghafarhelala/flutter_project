import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_second/layout/todo_app/cubit/cubit.dart';
import 'package:flutter_second/layout/todo_app/cubit/states.dart';
import 'package:flutter_second/project/update_post/update.dart';
import 'package:flutter_second/shared/colors.dart';
import 'package:flutter_second/shared/components/components.dart';

class ShowPostScreen extends StatelessWidget {
  const ShowPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppDeleteDatabaseState) {
          showToast(
              text: 'Data deleted successfully', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Show Posts'),
          ),
          body: ListView.separated(
              itemBuilder: (context, index) => Dismissible(
                    key: Key(
                        AppCubit.get(context).newPosts[index]['id'].toString()),
                    onDismissed: (direction) {
                      AppCubit.get(context).deleteData(
                          id: AppCubit.get(context).newPosts[index]['id']);
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return UpdateScreen(
                              index: index,
                            );
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('title : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppCubit.get(context).newPosts[index]
                                          ['title'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text('Content : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppCubit.get(context).newPosts[index]
                                          ['content'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: AppCubit.get(context).newPosts.length),
        );
      },
    );
  }
}
