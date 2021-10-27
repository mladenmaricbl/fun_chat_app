import 'package:flutter/material.dart';
import 'package:fun_chat_app/widgets/pickers/user_image_picker_widget.dart';

class AuthFormWidget extends StatefulWidget {
  final void Function(String email, String password, String username, bool isLogin, BuildContext ctx) authFunction;
  final bool isLoading;

  AuthFormWidget(this.authFunction, this.isLoading);
  @override
  _AuthFormWidgetState createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';

  void _submitForm(){
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); // Ovo se brine da se tastatura zatvori nakon klika na submit!

    if(isValid){
      _formKey.currentState!.save();

      widget.authFunction(_userEmail.trim(), _userPassword.trim(), _userName.trim(), _isLogin, context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin)
                  UserImagePickerWidget(),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value){
                      if(value!.isEmpty || !value.contains('@'))
                        return 'Please enter a valid e-mail!';

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'E-mail'),
                    onSaved: (value){
                      _userEmail = value!;
                    },
                  ),
                  if(!_isLogin)
                   TextFormField(
                    key: ValueKey('username'),
                    validator: (value){
                      if(value!.isEmpty || value.length < 3)
                        return 'Please enter username that is greater than 3 characters!';

                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                    onSaved: (value){
                      _userName = value!;
                    }
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value){
                      if(value!.isEmpty || value.length < 7)
                        return 'Password must contain more than 6 characters!';

                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value){
                      _userPassword = value!;
                    }
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if(widget.isLoading)
                  CircularProgressIndicator(),
                  if(!widget.isLoading)
                  RaisedButton(
                    onPressed: _submitForm,
                    child: Text(_isLogin? 'Login' : 'Signup'),
                  ),
                  if(!widget.isLoading)
                  FlatButton(
                      onPressed: (){
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin? 'Create new account' : 'Already have an account')
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
