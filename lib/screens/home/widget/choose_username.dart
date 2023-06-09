import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/services/user_dao/user_collections.dart';
import 'package:teleceriado/utils/decoration.dart';

import '../../../models/usuario.dart';

class ChooseUsername extends StatelessWidget {

  ChooseUsername({super.key});
  final FirebaseCollections _collections = FirebaseCollections();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    Provider.of<Usuario>(context,listen: false).firstTime = false;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      child: SizedBox(
        width: width*0.85,
        height: height*0.3,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.04),
            child: Column(
              children: [
                const Text("Escolha um nome de usuário:"),
                Padding(
                  padding: EdgeInsets.only(top: height*0.02, bottom: height*0.03),
                  child: TextFormField(
                    controller: _usernameController,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
                    keyboardType: TextInputType.text,
                    validator: (value) => value==null||value.isEmpty ? "Insira um nome de Usuário!" : null,
                    decoration: chooseUsername
                  ),
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width*0.3,
                      height: height*0.05,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: const Text("Cancelar"),),
                    ),
                    SizedBox(
                      width: width *0.3,
                      height: height * 0.05,
                      child: ElevatedButton(
                        onPressed: (){
                          Provider.of<Usuario>(context, listen: false).username = _usernameController.text;
                          _collections.updateUsername(_usernameController.text);
                          Navigator.pop(context);
                        }, 
                        child: const Text("Salvar")),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}