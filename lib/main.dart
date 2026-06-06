import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      appId: "YOUR_APP_ID",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      projectId: "YOUR_PROJECT_ID",
    ),
  );

  final directory = await getApplicationDocumentsDirectory();
  final file = File(join(directory.path, 'config.txt'));
  if (!await file.exists()) {
    await file.create();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  runApp(MyApp(
    auth: auth,
    firestore: firestore,
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const MyApp({
    Key? key,
    required this.auth,
    required this.firestore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comprehensive Knowledge Hub Platform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Comprehensive Knowledge Hub Platform'),
        ),
        body: const Center(
          child: Text('Welcome to the Comprehensive Knowledge Hub Platform'),
        ),
      ),
    );
  }
}

class FirebaseConfig {
  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;

  FirebaseConfig({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
  });

  factory FirebaseConfig.fromJson(Map<String, dynamic> json) {
    return FirebaseConfig(
      apiKey: json['apiKey'],
      appId: json['appId'],
      messagingSenderId: json['messagingSenderId'],
      projectId: json['projectId'],
    );
  }
}