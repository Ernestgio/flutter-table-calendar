import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/event.dart';

class AddPage extends StatefulWidget {
  final addEvents;
  final selectedDay;

  AddPage({this.addEvents, this.selectedDay});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _controller = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Add Event name"),
                TextField(
                  controller: _controller,
                ),
                ElevatedButton(
                  onPressed: (){
                    if(!_controller.text.isEmpty){
                      widget.addEvents(widget.selectedDay,Event(title: _controller.text));
                    }
                    Navigator.pop(context);
                  },
                  child: Text("Add Event"),
                )
              ],
            )),
      ),
    );
  }
}
