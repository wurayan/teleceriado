import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import '../../services/auth.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({super.key, required this.toggleView});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return isLoading ? const Loading() : Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.05, horizontal: width * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('E-mail', style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _emailController,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus!.unfocus(),
                  keyboardType: TextInputType.emailAddress,
                  //TODO IMPLEMENTAR O VERIFICADOR DE EMAIL DO BRASILFIELD E FLUXVALIDATOR
                  validator: (value) => value == null || value.isEmpty
                      ? 'Favor Inserir um e-mail válido!'
                      : null,
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: const Text('Senha', style: TextStyle(fontSize: 16)),
                ),
                TextFormField(
                  controller: _senhaController,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus!.unfocus(),
                  obscureText: true,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Senha inválida!' : null,
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.4,
                        height: height * 0.055,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.toggleView();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Text(
                            'REGISTRAR',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.4,
                        height: height * 0.055,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await AuthService().signIn(
                                  _emailController.text, _senhaController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Text('ENTRAR',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: Center(
                    child: TextButton(
                      onPressed: () async {
                        await _authService.signInAnonymously();
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: 'Entrar como ',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: 'Convidado',
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            )
                          ],
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
