import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/send.dart';
import 'pages/description.dart';
import 'pages/login.dart';
import 'models/send.dart';

void main() {
  final deviceSendManager = DeviceSendManager.fromCurrentUrl();

  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return deviceSendManager;
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enkra Send',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Enkra Send'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 1080,
          height: 720,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: buildLeftWidget(),
              ),
              const Expanded(
                child: Center(
                  child: Description(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildLeftWidget() {
    return Consumer<DeviceSendManager>(
        builder: (context, deviceSendManager, child) {
      final state = deviceSendManager.currentState();

      if (state is PairedState) {
        return SendDialog(
          pairedState: state,
        );
      } else {
        return WaitToPair(
          waitToPairState: state as WaitToPairState,
        );
      }
    });
  }
}
