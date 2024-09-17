import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon6/bloc/encom_bloc/encom_bloc.dart';
import 'package:imtihon6/bloc/expand_bloc/expand_bloc.dart';
import 'package:imtihon6/data/service/encom_service.dart';
import 'package:imtihon6/data/service/expand_service.dart';
import 'package:imtihon6/ui/screens/expand_screen.dart';

void main() async{
  WidgetsFlutterBinding();
  EncomService encomService = EncomService();
    ExpandService expandService = ExpandService();
    await expandService.init();
    await encomService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EncomBloc(),
          ),
          BlocProvider(
            create: (context) => ExpandBloc(),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ExpandScreen(),
        ));
  }
}
