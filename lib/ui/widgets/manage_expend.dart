import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon6/bloc/expand_bloc/expand_bloc.dart';
import 'package:imtihon6/bloc/expand_bloc/expand_event.dart';
import 'package:imtihon6/data/model/expand.dart';

class ManageExpend extends StatefulWidget {
  final Expand? expand;
  const ManageExpend({super.key, required this.expand});

  @override
  State<ManageExpend> createState() => _ManageExpendState();
}

class _ManageExpendState extends State<ManageExpend> {
  TextEditingController moneyEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  late String category;
  int dropdownValue = 0;
  List<String> categorys = ["food", 'transport', "home bealding", "other"];

  @override
  void initState() {
    super.initState();
    if (widget.expand != null) {
      category = widget.expand!.category;
      moneyEditingController.text = widget.expand!.money.toString();
      descriptionEditingController.text = widget.expand!.description;
      for (var i = 0; i < categorys.length; i++) {
        if (category[i] == widget.expand!.category) {
          dropdownValue = i;
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.expand != null ? "Edit Expand" : "Add Expand"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: moneyEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "money"),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionEditingController,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "description"),
          ),
          DropdownButton(
            value: dropdownValue,
            items: [
              DropdownMenuItem(value: 0, child: Text("food")),
              DropdownMenuItem(value: 1, child: Text("transport")),
              DropdownMenuItem(value: 2, child: Text("home bealding")),
              DropdownMenuItem(value: 3, child: Text("other")),
            ],
            onChanged: (value) {
              category = categorys[value!];
              dropdownValue = value;
              print(category);
              setState(() {});
              print(category);
            },
          )
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              context.read<ExpandBloc>().add(AddExpandEvent(
                  money: double.parse(moneyEditingController.text),
                  category: category,
                  date: DateTime.now(),
                  description: descriptionEditingController.text));
              Navigator.pop(context);
            },
            child: Text("Add")),
      ],
    );
  }
}
