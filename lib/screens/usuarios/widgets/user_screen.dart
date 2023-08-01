import 'package:flutter/material.dart';
import 'package:teleceriado/screens/usuarios/widgets/user_header.dart';
import '../../../models/badge.dart';
import '../../../models/usuario.dart';

class UserScreen extends StatelessWidget {
  final Usuario usuario;
  const UserScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserHeader(usuario: usuario),
          Padding(
            padding: EdgeInsets.only(top: height*0.01),
            child: SizedBox(
              width: width * 0.95,
              height: height * 0.15,
              child: Center(
                child: Text(
                  usuario.bio ??
                      "Este usuário não tem nada a falar sobre si mesmo.",
                  // "Lorem ipsum sit dolo amec viat seccum sacharum omnis spiritus immundus apendus eccio fira lat etum lattes ergo visavi et corbumculum espera ati fio lat enum argo mit sit mihi lux non deraco sit mihi lux va de retro",
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 6,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height*0.06,
            width: width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: usuario.badges?.length ?? 0,
              itemBuilder: (context, index) {
                if(usuario.badges==null) return null;
                UserBadge badge = usuario.badges![index];
                return _BadgeItem(badge: badge);

              }, 
              ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.02, right: width * 0.05),
            child: Text(
              "Comentários: ${usuario.editados??0}",
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final UserBadge badge;
  const _BadgeItem({required this.badge});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height; 
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        height: height*0.06,
        width: height*0.06,
        child: Image.network(
          badge.link!,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) => const Text("Erro"),
        ),
      ),
    );
  }
}
