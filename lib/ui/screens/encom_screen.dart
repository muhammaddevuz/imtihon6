import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon6/bloc/encom_bloc/encom_bloc.dart';
import 'package:imtihon6/bloc/encom_bloc/encom_event.dart';
import 'package:imtihon6/bloc/encom_bloc/encom_state.dart';
import 'package:imtihon6/ui/screens/expand_screen.dart';
import 'package:imtihon6/ui/widgets/manage_encom.dart';

class EncomScreen extends StatefulWidget {
  const EncomScreen({super.key});

  @override
  State<EncomScreen> createState() => _EncomScreenState();
}

class _EncomScreenState extends State<EncomScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EncomBloc>().add(GetEncomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Encom Screen"),
        centerTitle: true,
      ),
      body: BlocBuilder<EncomBloc, EncomState>(
        builder: (context, state) {
          if (state is EncomLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EncomErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is EncomLoadedState) {
            return ListView.builder(
              itemCount: state.encoms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.encoms[index].description),
                  subtitle: Text(state.encoms[index].money.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return ManageEncom(
                                  encom: state.encoms[index],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {
                            context.read<EncomBloc>().add(
                                DeleteEncomEvent(id: state.encoms[index].id));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Not Encom"),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExpandScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.upload,
                  size: 40,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.download,
                  size: 40,
                  color: Colors.blue,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return ManageEncom(
                encom: null,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
