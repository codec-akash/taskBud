import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:TaskApp/providers/auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  var _isLogin = true;
  String _userEmail = "";
  String _userPassword = "";
  String _userName = "";
  String _userPhone = "";

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      try {
        if (_isLogin) {
          await Provider.of<Auth>(context, listen: false)
              .login(_userEmail, _userPassword);
        } else {
          await Provider.of<Auth>(context, listen: false).signup(
            email: _userEmail,
            password: _userPassword,
            name: _userName,
            phone: _userPhone,
          );
        }
        _isLoading = false;
      } catch (error) {
        // var errorMessage = 'Authentication Failed';
        setState(() {
          _isLoading = false;
        });
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please Enter a valid Email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length <= 7) {
                          return 'Enter Password greater then 7 letters';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Password'),
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('Name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter a name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: 'Name'),
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('phoneNumber'),
                        validator: (value) {
                          if (value.isEmpty || value.length != 10) {
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        onSaved: (value) {
                          _userPhone = value;
                        },
                      ),
                    SizedBox(
                      height: 15.0,
                    ),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      RaisedButton(
                        textColor: Colors.white,
                        color: Theme.of(context).accentColor,
                        child: Text(
                          _isLogin ? 'Login' : 'SignUp',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: _trySubmit,
                      ),
                    if (!_isLoading)
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          _isLogin
                              ? 'Create New Account'
                              : 'Alread have an Account',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
