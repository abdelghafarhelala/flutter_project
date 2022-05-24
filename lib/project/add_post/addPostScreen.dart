import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_second/layout/todo_app/cubit/cubit.dart';
import 'package:flutter_second/layout/todo_app/cubit/states.dart';
import 'package:flutter_second/shared/components/components.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var titleControler = TextEditingController();
    var contentControler = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var screenKey = GlobalKey();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertDatabaseState) {
          showToast(
              text: 'Data inserted successfully', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: screenKey,
          appBar: AppBar(
            title: const Text('Add New Post '),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultFormField(
                      controller: titleControler,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Title Can not be empty';
                        }
                      },
                      label: 'Title of post',
                      prefix: Icons.title_outlined),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: contentControler,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Content Can not be empty';
                        }
                      },
                      label: 'Content of post',
                      prefix: Icons.content_copy),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButtom(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).insertToDatabase(
                              title: titleControler.text,
                              content: contentControler.text);
                        }
                      },
                      text: 'save')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
