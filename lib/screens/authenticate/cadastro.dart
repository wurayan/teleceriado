import 'package:flutter/material.dart';
import 'package:teleceriado/services/auth.dart';

class Cadastro extends StatefulWidget {
  final Function toggleView;
  const Cadastro({super.key, required this.toggleView});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
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
                  keyboardType: TextInputType.emailAddress,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus!.unfocus(),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Favor insira um E-mail válido!'
                      : null,
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: const Text('Senha', style: TextStyle(fontSize: 16)),
                ),
                TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus!.unfocus(),
                  validator: (value) => value == null || value.isEmpty
                      ? "Insira uma senha válida!"
                      : value.length < 6
                          ? "Senha deve ter no mínimo 6 caracteres"
                          : null,
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
                            child: const Text('VOLTAR',
                                style: TextStyle(fontSize: 16))),
                      ),
                      SizedBox(
                        width: width * 0.4,
                        height: height * 0.055,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                AuthService().cadastro(_emailController.text, _senhaController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: const Text('CADASTRAR',
                                style: TextStyle(fontSize: 16))),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
