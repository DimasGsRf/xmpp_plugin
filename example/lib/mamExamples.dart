import 'package:flutter/material.dart';
import 'package:xmpp_plugin/xmpp_plugin.dart';

import 'main.dart';

class MamExamples extends StatefulWidget {
  final XmppConnection flutterXmpp;

  MamExamples(this.flutterXmpp);

  @override
  _MamExamplesState createState() => _MamExamplesState();
}

class _MamExamplesState extends State<MamExamples> {
  TextEditingController _userJidController = TextEditingController();
  TextEditingController _requestSinceController = TextEditingController();
  TextEditingController _requestBeforeController = TextEditingController();
  TextEditingController _requestLimitController = TextEditingController();
  TextEditingController _chatStateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XMPP Plugin'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              customTextField(
                hintText: 'Enter Jid',
                textEditController: _userJidController,
              ),
              SizedBox(
                height: 10,
              ),
              customTextField(
                hintText: 'Timestamp Since',
                textEditController: _requestSinceController,
              ),
              SizedBox(
                height: 10,
              ),
              customTextField(
                hintText: 'Timestamp Before',
                textEditController: _requestBeforeController,
              ),
              SizedBox(
                height: 10,
              ),
              customTextField(
                hintText: 'Limit',
                textEditController: _requestLimitController,
              ),
              ElevatedButton(
                onPressed: () {
                  _requestMamMessages(
                    _userJidController.text,
                    _requestSinceController.text,
                    _requestBeforeController.text,
                    _requestLimitController.text,
                  );
                },
                child: Text("MAM Modules"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              customTextField(
                hintText: 'Chat state',
                textEditController: _chatStateController,
              ),
              ElevatedButton(
                onPressed: () {
                  // _changeTypingStatus(
                  //   _userJidController.text,
                  //   _chatStateController.text,
                  // );
                  _getMessages();
                },
                child: Text("Update Typing Status"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // [<field var="FORM_TYPE" type="hidden"><value>urn:xmpp:mam:2</value></field>, <field var="start"><value>2023-01-20T00:00:00Z</value></field>]
  void _requestMamMessages(userJid, requestSince, requestBefore, limit) {
    widget.flutterXmpp
        .requestMamMessages("1642464000000", "100")
        .then((value) => print("value : $value"));
  }

  void _changeTypingStatus(userJid, typingStatus) {
    widget.flutterXmpp.changeTypingStatus("dimasgs@sev-2.com", "TYPING");
  }

  void _getMessages() {
    widget.flutterXmpp.getMessage();
  }
}
