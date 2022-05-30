import 'package:flutter/material.dart';
import 'package:flutter_rest_api_3_provider/Provider/taskProvider/delete_task_provider.dart';
import 'package:flutter_rest_api_3_provider/styles/colors.dart';
import 'package:flutter_rest_api_3_provider/utility/snack_message.dart';
import 'package:flutter_rest_api_3_provider/widgets/text_field.dart';
import 'package:provider/provider.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({Key? key, this.title, this.taskId}) : super(key: key);

  final String? title;
  final String? taskId;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final TextEditingController _title = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _title.text = widget.title!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Details',
        ),
        actions: [
          Consumer<DeleteTaskProvider>(builder: (context, deleteTask, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (deleteTask.getResponse != '') {
                showMessage(message: deleteTask.getResponse, context: context);

                ///Clear the response message to avoid duplicate
                deleteTask.clear();
              }
            });
            return IconButton(
              onPressed: deleteTask.getStatus == true
                  ? null
                  : () {
                      deleteTask.deleteTask(
                          taskId: widget.taskId, ctx: context);
                    },
              icon: Icon(Icons.delete,
                  color: deleteTask.getStatus == true ? grey : white),
            );
          })
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  customTextField(
                    title: 'Title',
                    controller: _title,
                    hint: 'What do you want to do?',
                  ),
                  // customButton(
                  //   status: false,
                  //   text: 'Update',
                  //   tap: () {},
                  //   context: context,
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
