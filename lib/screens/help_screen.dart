import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpScreen extends StatefulWidget {
  static const String id = 'help_screen';
  //final String title;
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  void customLaunch(command) async {
    if (await canLaunchUrlString(command)) {
      await launchUrlString(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Help'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Need help or want to report a bug in IMED',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Contact us by clicking any one of the following buttons',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 80,
              ),
              MaterialButton(
                elevation: 10,
                minWidth: 100,
                color: Colors.purple,
                onPressed: () {
                  customLaunch(
                      'mailto:testapp.imed@gmail.com?subject=Help or Reporting bug in IMED application &body=');
                },
                child: Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                elevation: 10,
                minWidth: 100,
                color: Colors.red,
                onPressed: () {
                  customLaunch('tel:+91 1299923456');
                },
                child: Text(
                  'Phone',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                elevation: 10,
                minWidth: 100,
                color: Colors.green,
                onPressed: () {
                  customLaunch('sms:1299923456');
                },
                child: Text(
                  'SMS',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
