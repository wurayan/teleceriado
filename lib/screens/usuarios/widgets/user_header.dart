import 'package:pixel_snap/material.dart';
import 'package:teleceriado/screens/usuarios/widgets/follow_button.dart';
import '../../../components/emoji_generator.dart';
import '../../../models/usuario.dart';
import '../../../services/api_service.dart';

class UserHeader extends StatefulWidget {
  final Usuario usuario;
  const UserHeader({super.key, required this.usuario});

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader>
    with AutomaticKeepAliveClientMixin {
  final ApiService _api = ApiService();
  String? backdrop;
  Usuario usuario = Usuario();

  getBackdrop(Usuario usuario) async {
    if (usuario.header == null) {
      backdrop = await _api.getRandomBackdrop();
      if (mounted) setState(() {});
    }
  }

  @override
  void initState() {
    usuario = widget.usuario;
    getBackdrop(usuario);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * 0.2,
      decoration: BoxDecoration(
        image: usuario.header != null || backdrop != null
            ? DecorationImage(
                image: Image.network(
                  usuario.header ?? backdrop!,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: EmojiGenerator(
                        generate: usuario.header != null || backdrop != null),
                  ),
                ).image,
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Container(
        width: width,
        height: height * 0.2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Theme.of(context).scaffoldBackgroundColor
            ],
          ),
        ),
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.02, top: height * 0.1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: width * 0.2,
                decoration: BoxDecoration(
                  image: usuario.avatar != null
                      ? DecorationImage(
                          image: Image.network(
                            usuario.avatar!,
                            errorBuilder: (context, error, stackTrace) =>
                                const Text("Imagem não encontrada ;-;"),
                          ).image,
                          fit: BoxFit.cover,
                        )
                      : null,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      usuario.username ?? usuario.uid ?? "Erro",
                      style: const TextStyle(fontSize: 24),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    Row(
                      children: [
                        Text(
                          "seguidores: ${usuario.seguidoresQtde ?? 0}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.5,
                              height: 0.8),
                        ),
                        Container(
                          color: Colors.teal,
                          width: width*0.3,
                        ),
                        BotaoSeguindo(usuario: usuario)
                        
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
