import 'package:flutter/material.dart';
import 'package:openapi_api/openapi_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _realToken;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Container(
              child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: const Text(
                  "Hello",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
          Container(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
            child: Column(
              children: <Widget>[
                _buildEmailField(),
                const SizedBox(
                  height: 20,
                ),
                _buildPasswordField(),
                const SizedBox(
                  height: 5.0,
                ),
                _buildForgotPassword(),
                const SizedBox(
                  height: 40,
                ),
                _buildLoginButton(),
                const SizedBox(
                  height: 15,
                ),
                _buildRegisterButton(context)
              ],
            ),
          )
        ]));
  }

  Row _buildRegisterButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () async => _signUp(context),
          child: const Text(
            //'Register',
            'Show Users',
            style: TextStyle(
                color: Colors.blueGrey,
                fontFamily: 'Monserrat',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }

  Container _buildLoginButton() {
    return Container(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shadowColor: Colors.greenAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 7,
        ),
        onPressed: _login,
        child: const Text(
          'LOGIN',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat'),
        ),
      ),
    );
  }

  Container _buildForgotPassword() {
    return Container(
        alignment: const Alignment(1, 0),
        padding: const EdgeInsets.only(top: 15, left: 20),
        child: const InkWell(
          child: Text(
            'Forgot Password',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                decoration: TextDecoration.underline),
          ),
        ));
  }

  TextField _buildPasswordField() {
    return TextField(
      decoration: InputDecoration(
          labelText: 'PASSWORD',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          )),
      obscureText: true,
      controller: _passwordController,
    );
  }

  TextField _buildEmailField() {
    return TextField(
      decoration: const InputDecoration(
          labelText: 'EMAIL',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          )),
      controller: _emailController,
    );
  }

  Future<void> _signUp(BuildContext context) async {
    final api = _openapiApi().getUsersApi();

    try {
      final response = await api.apiUsersGet(headers: _authHeader);
      print(response);
    } catch (e) {
      print("Exception when calling UsersApi->apiUsersGet: $e\n");
    }
    //Navigator.of(context).pushNamed('/signup');
  }

  Map<String, dynamic> get _authHeader =>
      {'Cookie': '.AspNetCore.Identity.Application=$_token'};

  OpenapiApi _openapiApi() =>
      OpenapiApi(basePathOverride: 'https://localhost:5001');

  String get _token {
    return _realToken ?? '';
  }

  Future<void> _login() async {
    var openapiApi = _openapiApi();
    final api = openapiApi.getLoginApi();
    final String email = _emailController.text; // String |
    final String password = _passwordController.text; // String |

    try {
      final response = await api.apiLoginGet(email: email, password: password);

      _realToken = (response.headers.map['set-cookie'])
          .toString()
          .split('=')[1]
          .split(';')[0];

      print(_realToken);
    } catch (e) {
      print('Exception when calling LoginApi->apiLoginGet: $e\n');
    }
  }
}
