import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon6/bloc/expand_bloc/expand_bloc.dart';
import 'package:imtihon6/bloc/expand_bloc/expand_event.dart';
import 'package:imtihon6/bloc/expand_bloc/expand_state.dart';
import 'package:imtihon6/ui/screens/encom_screen.dart';
import 'package:imtihon6/ui/widgets/manage_expend.dart';

class ExpandScreen extends StatefulWidget {
  const ExpandScreen({super.key});

  @override
  State<ExpandScreen> createState() => _ExpandScreenState();
}

class _ExpandScreenState extends State<ExpandScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExpandBloc>().add(GetExpandsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expand Screen"),
        centerTitle: true,
      ),
      body: BlocBuilder<ExpandBloc, ExpandState>(
        builder: (context, state) {
          if (state is ExpandLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExpandErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is ExpandLoadedState) {
            List<String> categorys = [
              "food",
              'transport',
              "home bealding",
              "other"
            ];
            Map chartItem = {};
            double totalExpands = 0;
            for (var element in state.expands) {
              print(element.category);
              totalExpands += element.money;
            }
            for (var element in categorys) {
              double moneyBox = 0;
              for (var element1 in state.expands) {
                if (element1.category == element) {
                  moneyBox += element1.money;
                }
              }
              chartItem.addAll({element: moneyBox});
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var i = 0; i < categorys.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.blue,
                            width: 50,
                            height: 100,
                            child: Center(
                              child: Text(
                                "${chartItem[categorys[i]] * 100 ~/ totalExpands}%",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Text(categorys[i])
                        ],
                      )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.expands.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.expands[index].description),
                        subtitle: Text(state.expands[index].money.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ManageExpend(
                                        expand: state.expands[index],
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
                                  context.read<ExpandBloc>().add(
                                      DeleteExpandEvent(
                                          id: state.expands[index].id));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Not Expand"),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.upload,
                  size: 40,
                  color: Colors.blue,
                )),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EncomScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.download,
                  size: 40,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return ManageExpend(
                expand: null,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
