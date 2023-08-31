import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';

import '../../../models/usuario.dart';

class EditUsernameDialog extends StatelessWidget {
  EditUsernameDialog({super.key});
  final TextEditingController _controller = TextEditingController();
  final OutlineInputBorder outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  );
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: height * 0.23,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.02, horizontal: width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Digite seu novo nome:"),
              Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: TextFormField(
                  key: _key,
                  controller: _controller,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus!.unfocus(),
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    enabledBorder: outlineBorder,
                    focusedBorder: outlineBorder,
                    errorBorder: outlineBorder,
                    focusedErrorBorder: outlineBorder,
                    isDense: true,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Infelizmente você não pode ser uma pessoa sem nome aqui."
                      : null,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                    top: height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _salvar(context);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Salvar"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _salvar(context) async {
    final FirebaseUsers users = FirebaseUsers();
    await users.updateUsername(_controller.text);
    Provider.of<Usuario>(context, listen: false).username = _controller.text;
    // Provider.of<UpdateSeguindo>(context, listen: false).headerChanged = true;
  }
}
