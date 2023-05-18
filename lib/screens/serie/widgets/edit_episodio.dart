import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:teleceriado/models/episodio.dart';
import 'package:teleceriado/services/api_service.dart';

class EditEpisodio extends StatefulWidget {
  final Episodio episodio;
  const EditEpisodio(
      {super.key, required this.episodio});

  @override
  State<EditEpisodio> createState() => _EditEpisodioState();
}

class _EditEpisodioState extends State<EditEpisodio> {
  final ApiService _api = ApiService();
  late Episodio episodio;
  bool isEditing = false;
  final TextEditingController _descricaoController = TextEditingController();

  final InputDecoration _descricaoDecoration = const InputDecoration(
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0)));

  @override
  void initState() {
    episodio = widget.episodio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      clipBehavior: Clip.hardEdge,
      child: Container(
        color: Colors.blueGrey[900],
        width: width * 0.9,
        height: height * 0.6,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: width * 0.9,
                  height: height * 0.2,
                  child: Image.network(
                    _api.getSeriePoster(episodio.imagem!),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.03),
                  child: InkWell(
                    onTap: () => setState(() {
                      isEditing = !isEditing;
                    }),
                    child: SizedBox(
                      width: width * 0.8,
                      height: height * 0.15,
                      child: isEditing
                          ? TextFormField(
                              controller: _descricaoController,
                              keyboardType: TextInputType.text,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                              onFieldSubmitted: (value) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                              maxLength: 144,
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              decoration: _descricaoDecoration)
                          : Text(
                              episodio.descricao == null ||
                                      episodio.descricao!.isEmpty
                                  ? 'Adicionar Descrição...'
                                  : episodio.descricao!,
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.fade,),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                isEditing ?
                Padding(
                  padding: EdgeInsets.only(bottom: height*0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: width*0.3,
                        height: height*0.05,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditing=!isEditing;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            )
                          ),
                          child: const Text('Cancelar', style: TextStyle(fontSize: 16),),
                        ),
                      ),
                      SizedBox(
                        width: width*0.3,
                        height: height*0.05,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            )
                          ),
                          child: const Text('Salvar', style: TextStyle(fontSize: 16)),
                        ),
                      )
                    ],
                  ),
                ):const SizedBox(width: null,height:null),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.04),
                  child: Container(
                    width: width,
                    height: height * 0.1,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.transparent,
                          Colors.blueGrey.shade900
                        ])),
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.02),
                      child: Text(
                        '${episodio.numero}. ${episodio.nome}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
