import 'package:flutter/material.dart';

import '../../../models/serie.dart';
import '../../../services/user_dao/user_collections.dart';

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
                      onPressed: (){
                        if (_controller.text.isNotEmpty) {
                          Serie serie = Serie();
                          serie.id = serieId;
                          isDescription ?
                          serie.descricao = _controller.text :
                          serie.poster = _controller.text;
                          _collection.editSerie(serie);                         
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