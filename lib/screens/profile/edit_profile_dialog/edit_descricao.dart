import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';

import '../../../models/usuario.dart';

class EditDescricaoDialog extends StatelessWidget {
  EditDescricaoDialog({super.key});
  final FirebaseUsers _users = FirebaseUsers();
  final TextEditingController _controller = TextEditingController();

  final OutlineInputBorder border =
      OutlineInputBorder(borderRadius: BorderRadius.circular(25));

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: height * 0.4,
        width: width * 0.9,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Digite uma Bio:"),
              Padding(
                padding: EdgeInsets.only(top: height * 0.02, bottom: height*0.02),
                child: TextFormField(
                  controller: _controller,
                  maxLines: 6,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus!.unfocus(),
                  decoration: InputDecoration(
                      enabledBorder: border,
                      focusedBorder: border,
                      filled: true,
                      fillColor: Colors.grey[400]),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  const Expanded(child: SizedBox()),
                  TextButton(
                      onPressed: () {
                        _users.updateDescricao(_controller.text);
                        Provider.of<Usuario>(context, listen: false).bio = _controller.text;
                        Navigator.pop(context);
                      },
                      child: const Text("Salvar"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
