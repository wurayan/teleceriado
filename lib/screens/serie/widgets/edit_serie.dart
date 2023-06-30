import 'package:flutter/material.dart';
import 'package:teleceriado/models/snackbar.dart';
import 'package:teleceriado/utils/utils.dart';

import '../../../models/serie.dart';
import '../../../services/user_dao/firebase_collections.dart';

class EditSerie extends StatelessWidget {
  final bool isDescription;
  final int serieId;
  EditSerie({super.key, required this.isDescription, required this.serieId});

  final FirebaseCollections _collection = FirebaseCollections();

  final TextEditingController _controller = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      child: SizedBox(
        width: width*0.8,
        height: isDescription  
        ? height*0.4
        : height*0.25,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height*0.03, bottom: height*0.02),
              child: Text(
                isDescription ? "Adicione sua descrição" : "Link da Imagem"
              ),
            ),
            isDescription ?
            SizedBox(
              width: width*0.7,
              height: height*0.2,
              child: TextFormField(
                controller: _controller,
                onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
                expands: true,
                minLines: null,
                maxLines: null,
                maxLength: 255,
              ),
            ) : 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.05),
              child: TextFormField(
                controller: _controller,
                onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
                keyboardType: TextInputType.url,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height*0.02, right: width*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: const Text("Cancelar")),
                    TextButton(
                      onPressed: () async {
                        if (_controller.text.isNotEmpty) {
                          bool isValid;
                          Serie serie = Serie();
                          if (isDescription) {
                            serie.descricao = _controller.text;
                            _collection.editSerie(serie); 
                          }
                          else if (!isDescription) {
                            isValid = await validateImage(_controller.text);
                            if (isValid) {
                              serie.backdrop = _controller.text;
                              _collection.editSerie(serie); 
                            } else {
                              SnackbarGlobal.show("Link inválido!");
                            } 
                          }                      
                        }
                        Navigator.pop(context);
                      },
                      child: const Text("Salvar"),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}