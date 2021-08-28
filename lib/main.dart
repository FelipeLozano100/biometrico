import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalAuthentication auth = LocalAuthentication();
  @override
  Widget build(BuildContext context) {
    setState(() {
      _biometrico();
    });

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }

  Future<void> _biometrico() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    List<BiometricType> a = await auth.getAvailableBiometrics();


    print(a.toString());
    if (canCheckBiometrics) {
      bool flag = true;
      if (flag) {
        bool authenticated = false;

        const androidString = const AndroidAuthMessages(
            cancelButton: "Cancelar",
            goToSettingsButton: "Ajustes",
            signInTitle: "Autentiquese",
            biometricHint: "Toque el sensor",
            biometricNotRecognized: "Huella no reconocida",
            biometricSuccess: "Huella reconocida",
            goToSettingsDescription: "Por favor configure su huella");

        try {
          authenticated = await auth.authenticate(
              localizedReason: "Autentiquese para acceder",
              useErrorDialogs: true,
              stickyAuth: true,
              androidAuthStrings: androidString,
              biometricOnly: true);

          if (!authenticated) {
            exit(0);
          }
        } catch (e) {
          print(e);
        }

        if (!mounted) {
          return;
        }
      }
    }
  }
}
