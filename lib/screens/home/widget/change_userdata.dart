import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/utils/utils.dart';
import '../../../models/usuario.dart';
import '../../../services/user_dao/firebase_export.dart';
import 'link_invalido.dart';

class ChangeUserdata extends StatefulWidget {
  const ChangeUserdata({super.key});

  @override
  State<ChangeUserdata> createState() => _ChangeUserdataState();
}

class _ChangeUserdataState extends State<ChangeUserdata> {
  final FirebaseUsers _users = FirebaseUsers(); 

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _avatarController = TextEditingController();

  String? imagem;

  @override
  Widget build(BuildContext context) {
    Usuario provider = Provider.of<Usuario>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: SizedBox(
        width: width * 0.9,
        height: height * 0.45,
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: height * 0.2,
                child: Visibility(
                  visible: provider.avatar != null,
                  child: Image.network(provider.avatar??"", fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.02, horizontal: width * 0.05),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.1),
                      child: const Text("Link da Imagem:",
                      ),
                    ),
                    TextFormField(
                      controller: _avatarController,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus!.unfocus(),
                      keyboardType: TextInputType.url,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.02),
                      child: const Text("Nome de Usuário:"),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus!.unfocus(),
                      keyboardType: TextInputType.text,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            height: height * 0.05,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancelar",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.3,
                            height: height * 0.05,
                            child: OutlinedButton(
                              onPressed: () {
                                String? username =
                                    _usernameController.text.isNotEmpty
                                        ? _usernameController.text
                                        : null;
                                String? avatar =
                                    _avatarController.text.isNotEmpty
                                        ? _avatarController.text
                                        : null;
                                if (username != null || avatar != null) {
                                  _salvar(username, avatar).then((value) {
                                    if (value) {
                                      Usuario provider = Provider.of<Usuario>(
                                          context,
                                          listen: false);
                                      _usernameController.text.isNotEmpty
                                          ? provider.username =
                                              _usernameController.text
                                          : null;
                                      _avatarController.text.isNotEmpty
                                          ? provider.avatar =
                                              _avatarController.text
                                          : null;
                                      Navigator.pop(context, true);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const LinkInvalido());
                                    }
                                  });
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                "Salvar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _salvar(String? username, String? avatar) async {
    bool avatarValid = avatar != null ? await validateImage(avatar) : false;
    bool usernameValid = username != null;
    if (avatarValid || usernameValid) {
      _users.updateUserdata(
          username: usernameValid ? _usernameController.text : null,
          avatar: avatarValid ? _avatarController.text : null);
    }
    if (avatar != null && !avatarValid) {
      return false;
    } else {
      return true;
    }
  }
}
