import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../global/helpers/uiHelper.dart';
import '../../global/providers/auth.dart';
import '../../global/widgets/custom_input_decoration.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const routeName = '/sign-in-screen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? email;
  late bool _isPasswordVisible;
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _focusNode1, _focusNode2;
  @override
  void initState() {
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _isPasswordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> userSignIn(BuildContext context, var navigator) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UiHelper.showSpinnerDialog(context);
        await Provider.of<Auth>(context, listen: false).signIn(
            email: email!, password: passwordController.text, context: context);
        navigator.pop();
      } on Exception catch (e) {
        print(e);
      } finally {
        UiHelper.removeSpinnerDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SignIn',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 240,
                    width: double.infinity,
                    child: Center(
                        child: Lottie.asset('assets/images/login.json'))),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 6,
                ),
                TextFormField(
                  focusNode: _focusNode1,
                  style: Theme.of(context).textTheme.labelSmall,
                  keyboardType: TextInputType.emailAddress,
                  decoration: customInputDecoration(context, 'abc@email.com'),
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please enter a valid Email';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    email = value;
                  },
                  onFieldSubmitted: (_) {
                    _focusNode2.requestFocus();
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 6,
                ),
                TextFormField(
                  focusNode: _focusNode2,
                  style: Theme.of(context).textTheme.labelSmall,
                  controller: passwordController,
                  obscureText: !_isPasswordVisible,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '*************',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        fontFamily: 'Nunito'),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  onFieldSubmitted: (_) {
                    userSignIn(context, navigator);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                      userSignIn(context, navigator);
                  },
                  child: Center(
                    child: Container(
                      width: width * 0.8,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          'Sign in with Email',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
