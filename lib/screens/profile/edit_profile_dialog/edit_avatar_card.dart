import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/update_seguindo.dart';
import 'package:teleceriado/services/user_dao/firebase_archives.dart';

import '../../../models/usuario.dart';

class EditAvatarCard extends StatefulWidget {
  const EditAvatarCard({super.key});

  @override
  State<EditAvatarCard> createState() => _EditAvatarCardState();
}

class _EditAvatarCardState extends State<EditAvatarCard> {
  final FirebaseArchives _storage = FirebaseArchives();
  File? _avatar;
  final ImagePicker _picker = ImagePicker();


  //TODO ARRUMAR AQUI COMO ATUALIZAR A PAGINA PQ NAO PODEMOS USAR O CONTEXT, JÁ QUE ELE PEGA O CONTEXTO DO BOTTOM MODAL SHEET QUE É DESCARTADO ANTES DE BUSCARMOS A IMAGEM;
  imagemFromGaleria() async {
    final avatar = await _picker.pickImage(source: ImageSource.gallery);
    if (avatar == null) return;
    _avatar = File(avatar.path);
    String url = await _storage.uploadFile(_avatar!);
    if (mounted) setState(() {});
  }

  imagemFromCamera(oldContext) async {
    final avatar = await _picker.pickImage(source: ImageSource.camera);
    if (avatar == null) return;
    _avatar = File(avatar.path);
    String url = await _storage.uploadFile(_avatar!);
    // Provider.of<Usuario>(oldContext, listen: false).avatar = url;
    Provider.of<UpdateSeguindo>(oldContext, listen: false).headerChanged = true;
    // UpdateSeguindo provider = Provider.of<UpdateSeguindo>(oldContext);
    // if(provider.headerChanged==true){
    //   Provider.of<UpdateSeguindo>(oldContext).headerChanged=false;
    // }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: Padding(
        padding:  const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            image: _avatar != null
                ? DecorationImage(
                    image: Image.file(
                      _avatar!,
                      width: double.infinity,
                      height: double.infinity,
                    ).image,
                    fit: BoxFit.cover)
                : null,
            color: Colors.white30,
            borderRadius: BorderRadius.circular(25),
          ),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: const Center(
              child: Text(
                "Trocar de Avatar",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showPicker(oldContext) {
    showModalBottomSheet(
      context: oldContext,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Galeria"),
                onTap: () {
                  imagemFromGaleria();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Câmera"),
                onTap: () {
                  imagemFromCamera(oldContext);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
