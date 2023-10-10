// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_exapmle/models/user.dart';
import 'package:form_exapmle/pages/user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePassword = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _aboutYouController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final List<String> _countries = ['Belarus', 'Ukraine', 'Germany', 'France'];
  String? _selectedContry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _aboutYouController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: 'What do people call you?',
                prefixIcon: const Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () => _nameController.clear(),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red[400],
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
              ),
              validator: _validateName,
              onSaved: (value) => newUser.name = value!,
            ),
            const SizedBox(height: 10),
            TextFormField(
                focusNode: _phoneFocus,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _phoneFocus, _passwordFocus);
                },
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Where can we reach you?',
                  helperText: 'Phone format: (###)###-####',
                  prefixIcon: const Icon(Icons.call),
                  suffixIcon: GestureDetector(
                    onTap: () => _phoneController.clear(),
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red[400],
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  // FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                      allow: true),
                ],
                validator: (value) => _validatePhoneNumber(value)
                    ? null
                    : 'Phone nuber must be entered as (###)###-####',
                onSaved: (value) => newUser.phone = value!),
            const SizedBox(height: 10),
            TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                  prefixIcon: Icon(Icons.mail),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                onSaved: (value) => newUser.email = value!),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.map),
                  border: OutlineInputBorder(),
                  labelText: 'Country'),
              items: _countries.map((String country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (country) {
                print(country);
                setState(() {
                  _selectedContry = country!;
                  newUser.country = country;
                });
              },
              value: _selectedContry,
              validator: (val) {
                return val == null ? 'Please select a country' : null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
                controller: _aboutYouController,
                decoration: const InputDecoration(
                  labelText: 'About You',
                  hintText: 'Tell us about yourself',
                  helperText: 'Keep it short, this is just a demo',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                ),
                maxLines: 3,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                ],
                onSaved: (value) => newUser.about = value!),
            const SizedBox(height: 10),
            TextFormField(
              focusNode: _passwordFocus,
              controller: _passwordController,
              obscureText: _hidePassword,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter the password',
                prefixIcon: const Icon(Icons.security),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  icon: Icon(
                      _hidePassword ? Icons.visibility : Icons.visibility_off),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
              ),
              validator: _validatePassword,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _hidePassword,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm the password',
                prefixIcon: const Icon(Icons.security),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  icon: Icon(
                      _hidePassword ? Icons.visibility : Icons.visibility_off),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
              ),
              validator: _validatePassword,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit Form'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      _showDialog(name: _nameController.text);
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Country: $_selectedContry');
      print('About You: ${_aboutYouController.text}');
      print('Password: ${_passwordController.text}');
      print('Confirmed Password: ${_confirmPasswordController.text}');
    } else {
      _showMessage(message: 'Form is not valid! Please review and correct');
    }
  }

  String? _validateName(String? value) {
    final nameExp = RegExp(r'^[A-Za-z]+$');
    if (value!.isEmpty) {
      return 'Name is required';
    } else if (!nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters';
    } else {
      return null;
    }
  }

  bool _validatePhoneNumber(String? input) {
    final phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');

    return phoneExp.hasMatch(input!);
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? pass) {
    if (_passwordController.text.length != 8) {
      return 'Password must be 8 characters long';
    } else if (_confirmPasswordController.text != _passwordController.text) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red[400],
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void _showDialog({String? name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Registration Successful'),
            content: Row(
              children: [
                Text(
                  '$name ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const Text('is now a verified register form')
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInfoPage(
                        userInfo: newUser,
                      ),
                    ),
                  );
                },
                child: const Text('Verified'),
              ),
            ],
          );
        });
  }
}
