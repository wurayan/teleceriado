import 'package:pixel_snap/material.dart';
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

  getBackdrop() async {
    if (widget.usuario.avatar == null) {
      backdrop = await _api.getRandomBackdrop();
      print(backdrop);
      setState(() {});
    }
  }

  @override
  void initState() {
    usuario = widget.usuario;
    getBackdrop();
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
        image: usuario.avatar != null || backdrop != null
            ? DecorationImage(
                image: Image.network(
                  usuario.avatar ?? backdrop!,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: EmojiGenerator(
                        generate: usuario.avatar != null ||
                            backdrop != null),
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
            colors: [Colors.transparent, Colors.blueGrey[900]!],
          ),
        ),
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.02),
          child: Text(
            usuario.username ?? usuario.uid ?? "Erro",
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
