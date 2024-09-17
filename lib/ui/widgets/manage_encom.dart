import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon6/bloc/encom_bloc/encom_bloc.dart';
import 'package:imtihon6/bloc/encom_bloc/encom_event.dart';
import 'package:imtihon6/data/model/encom.dart';

class ManageEncom extends StatefulWidget {
  final Encom? encom;
  const ManageEncom({super.key, required this.encom});

  @override
  State<ManageEncom> createState() => _ManageEncomState();
}

class _ManageEncomState extends State<ManageEncom> {
  TextEditingController moneyEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  late String category;
  int dropdownValue = 0;
  List<String> categorys = ["salary", 'projects', "rent", "other"];

  @override
  void initState() {
    super.initState();
    if (widget.encom != null) {
      category = widget.encom!.category;
      moneyEditingController.text = widget.encom!.money.toString();
      descriptionEditingController.text = widget.encom!.description;
      for (var i = 0; i < categorys.length; i++) {
        if (category[i] == widget.encom!.category) {
          dropdownValue = i;
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.encom != null ? "Edit Encom" : "Add Encom"),
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
          const SizedBox(height: 20),
          TextField(
            controller: descriptionEditingController,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "description"),
          ),
          DropdownButton(
            value: dropdownValue,
            items: const [
              DropdownMenuItem(value: 0, child: Text("salary")),
              DropdownMenuItem(value: 1, child: Text("projects")),
              DropdownMenuItem(value: 2, child: Text("rent")),
              DropdownMenuItem(value: 3, child: Text("other")),
            ],
            onChanged: (value) {
              category = categorys[value!];
              dropdownValue = value;
              setState(() {});
            },
          )
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              context.read<EncomBloc>().add(AddEncomEvent(
                  money: double.parse(moneyEditingController.text),
                  category: category,
                  date: DateTime.now(),
                  description: descriptionEditingController.text));
              Navigator.pop(context);
            },
            child: const Text("Add")),
      ],
    );
  }
}
