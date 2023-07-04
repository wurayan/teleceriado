import 'package:flutter/material.dart';

import '../../../components/emoji_generator.dart';
import '../../../models/usuario.dart';
import '../../../services/api_service.dart';

class UserHeader extends StatefulWidget {
  final Usuario usuario;
  const UserHeader({super.key, required this.usuario});

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> with AutomaticKeepAliveClientMixin{
  final ApiService _api = ApiService();
  String? backdrop;

  getBackdrop() async {
    if (widget.usuario.avatar == null) {
      backdrop = await _api.getRandomBackdrop();
      setState(() {});
    }
  }

  @override
  void initState() {
    getBackdrop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height * 0.2,
          child: widget.usuario.avatar == null && backdrop == null
              ? Padding(
                  padding: EdgeInsets.only(top: height * 0.075),
                  child: EmojiGenerator(
                    generate: backdrop == null,
                    style: const TextStyle(fontSize: 30),
                  ),
                )
              : Image.network(
                  widget.usuario.avatar ?? backdrop!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text("Erro ao obter imagem!");
                  },
                ),
        ),
        Container(
          width: width,
          height: height * 0.21,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.blueGrey[900]!],
            ),
          ),
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: height*0.015,
              left: width*0.02
            ),
            child: Text(
              widget.usuario.username ?? widget.usuario.uid ?? "Erro",
              style: const TextStyle(fontSize: 24),
            ),
          ),
        )
      ],
    );
  }
  
  @override
  
  bool get wantKeepAlive => true;
}
