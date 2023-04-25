import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../global/helpers/uiHelper.dart';
import '../../global/providers/auth.dart';
import '../../global/widgets/custom_input_decoration.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/sign-up-screen';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? name, email;
  late bool _rememberMeVal, _isPasswordVisible, _isConfirmPasswordVisible;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late List<FocusNode> _focusNodes;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.focused,
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return const Color.fromARGB(255, 244, 52, 55);
    }
    return Colors.white;
  }

  @override
  void initState() {
    _focusNodes = List.generate(4, (index) => FocusNode());
    _rememberMeVal = false;
    _isPasswordVisible = false;
    _isConfirmPasswordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> userSignUp(BuildContext context, var navigator) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UiHelper.showSpinnerDialog(context);
        await Provider.of<Auth>(context, listen: false).signUp(
            name: name!,
            email: email!,
            password: passwordController.text,
            context: context);
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SignUp',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Form(
          key: _formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Create an Account  ',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Icon(
                                FontAwesomeIcons.lock,
                                size: 25,
                                color: Colors.yellow[700],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            'Username',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            focusNode: _focusNodes[0],
                            style: Theme.of(context).textTheme.labelSmall,
                            keyboardType: TextInputType.name,
                            decoration: customInputDecoration(
                                context, 'Fun Display Name'),
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Name';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              name = value;
                            },
                            onFieldSubmitted: (value) {
                              _focusNodes[1].requestFocus();
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Email',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            focusNode: _focusNodes[1],
                            style: Theme.of(context).textTheme.labelSmall,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                customInputDecoration(context, 'abc@email.com'),
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return 'Please enter a valid Email';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              email = value;
                            },
                            onFieldSubmitted: (value) =>
                                _focusNodes[2].requestFocus(),
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
                            focusNode: _focusNodes[2],
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
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Password';
                              } else if (value.length < 8) {
                                return 'Password size is weak';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) =>
                                _focusNodes[3].requestFocus(),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Confirm Password',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                              focusNode: _focusNodes[3],
                              style: Theme.of(context).textTheme.labelSmall,
                              controller: confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              obscuringCharacter: '*',
                              keyboardType: TextInputType.name,
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
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please re-enter password';
                                }
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  return "Password does not match";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                userSignUp(context, navigator);
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Transform.scale(
                                  scale: 1.08,
                                  child: Checkbox(
                                    splashRadius: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    activeColor: Theme.of(context).primaryColor,
                                    value: _rememberMeVal,
                                    onChanged: (val) {
                                      setState(() {
                                        _rememberMeVal = val!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Remember me',
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isKeyboardVisible)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    color: Colors.grey[800],
                    child: GestureDetector(
                      onTap: () {
                        userSignUp(context, navigator);
                      },
                      child: Container(
                        width: width * 0.6,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        );
      }),
    );
  }
}
