import 'package:TaskApp/global.dart';
import 'package:TaskApp/providers/task.dart';
import 'package:TaskApp/providers/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  final BuildContext modalContext;
  AddTask(this.modalContext);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _descriptionFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String _taskName;
  String _taskDescription;
  String _startTime;
  String _endTime;
  DateTime _startDateTime, _endDateTime;

  var _editedTask = Task(
    title: '',
    description: '',
    date: '',
    duration: '',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    status: false,
  );

  bool _validTime() {
    print(_startDateTime);
    print(_endDateTime);
    if (_startDateTime == null || _endDateTime == null) {
      print("1");
      return false;
    }
    if (_startDateTime.hour > _endDateTime.hour) {
      print("2");
      return false;
    }
    if (_startDateTime.hour == _endDateTime.hour) {
      if (_startDateTime.minute > _endDateTime.minute) {
        print("3");
        return false;
      } else if (_startDateTime.minute == _endDateTime.minute) {
        if (_startDateTime.second >= _endDateTime.second) {
          print("4");
          return false;
        } else {
          print("5");
          return true;
        }
      }
    }
    return true;
  }

  Future<void> _trySubmit() async {
    FocusScope.of(context).unfocus();
    final _isValid = _formKey.currentState.validate();
    print(_validTime());
    if (_validTime()) {
      if (_isValid) {
        _formKey.currentState.save();
        _editedTask = new Task(
          title: _taskName,
          duration: _taskDescription,
          startTime: _startDateTime,
          endTime: _endDateTime,
          date: _startTime,
          status: false,
        );
        await Provider.of<Tasks>(context, listen: false).addTask(_editedTask);
        Navigator.of(widget.modalContext)
            .pop(); //To be done when task is added.
      } else {
        Scaffold.of(widget.modalContext).showSnackBar(
          SnackBar(
            content: Text('End time should be greater then start time'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Text(
                'Add Task',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value.length <= 2) {
                    return "Please Enter a valid task";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Task Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (value) {
                  _taskName = value;
                },
              ),
              TextFormField(
                focusNode: _descriptionFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    _taskDescription = "No description";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Task Description'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _taskDescription = value;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Select Time :',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50.0,

                    //Start Button

                    child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: _startTime != null
                            ? Text(
                                _startTime,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              )
                            : Text(
                                'Start Time',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                      ),
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      onPressed: () {
                        DatePicker.showTimePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (time) {
                            print(time);
                          },
                          onConfirm: (confirmTime) {
                            setState(() {
                              _startTime = (confirmTime.hour).toString() +
                                  ':' +
                                  confirmTime.minute.toString() +
                                  ':' +
                                  confirmTime.second.toString();
                            });
                            _startDateTime = confirmTime;
                            print(confirmTime.hour);
                          },
                        );
                      },
                    ),
                  ),

                  //End Time

                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50.0,
                    child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: _endTime != null
                            ? Text(
                                _endTime,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              )
                            : Text(
                                'End Time',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                      ),
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      onPressed: () {
                        DatePicker.showTimePicker(
                          context,
                          showTitleActions: true,
                          currentTime: _startDateTime,
                          onChanged: (time) => print(time),
                          onConfirm: (confirmTime) {
                            setState(() {
                              _endTime = (confirmTime.hour).toString() +
                                  ':' +
                                  confirmTime.minute.toString() +
                                  ':' +
                                  confirmTime.second.toString();
                            });
                            _endDateTime = confirmTime;
                            print(confirmTime.hour);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: EdgeInsets.all(
                      12.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          'Add Task',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: _trySubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
