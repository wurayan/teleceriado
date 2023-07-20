import 'package:pixel_snap/material.dart';
import 'package:teleceriado/screens/collections/widget/mini_seguir_usuario.dart';
import 'package:teleceriado/screens/collections/widget/seguidores_colecao.dart';
import 'package:teleceriado/screens/collections/widget/seguir_colecao.dart';
import 'package:teleceriado/screens/usuarios/user_page.dart';
import '../../../models/collection.dart';
import '../../../models/usuario.dart';

class Header extends StatelessWidget {
  final Collection collection;
  final Usuario? dono;
  const Header({super.key, required this.collection, this.dono});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: width,
              height: height * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(
                    collection.imagem!,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Text("Não foi possível carregar a imagem"),
                    ),
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                width: width,
                height: height * 0.205,
                decoration: BoxDecoration(
                  // color: Colors.transparent,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.blueGrey[900]!],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: height * 0.005, left: width * 0.05),
                    child: Text(
                      collection.nome!,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.02, right: width * 0.05, top: 2),
              child: Row(
                children: [
                  ...ownerData(dono, context),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // TextButton(
                  //   onPressed: () async {
                  //     FirebaseCollections col = FirebaseCollections();
                  //     Collection cole = await col.getCollectionInfo("aqui", userId: "rzWhYOggrbP0cczR6PTuYUJL4G12");
                  //     print(cole.seguidoresQtde);
                  //   },
                  //   child: Text("A")
                  // ),
                  ColecaoSeguidores(
                    colecao: collection,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.15,
              width: width,
              child: Center(
                child: Text(
                  collection.descricao == null || collection.descricao!.isEmpty
                      ? "Essa coleção não possui descrição.\n Então ela é um enigma, tente adivinhar o tema."
                      : collection.descricao!,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.02,
                  right: width * 0.05,
                  bottom: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${collection.series?.length ?? 0} Séries",
                      style: const TextStyle(fontWeight: FontWeight.w300)),
                  Visibility(
                    visible: dono != null,
                    child: SeguirColecao(colecao: collection),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 3,
              thickness: 1,
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: width * 0.02, right: width * 0.02, top: height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      child: Text("Nada Ainda"),
                    ),
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.edit_rounded),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

List<Widget> ownerData(Usuario? dono, context) {
  final double width = MediaQuery.of(context).size.width;
  List<Widget> data = [];
  if (dono == null) return data;
  data = [
    GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserPage(usuario: dono),
        ));
      },
      child: dono.avatar != null
          ? Container(
              width: width * 0.065,
              height: width * 0.065,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.white),
                image: DecorationImage(
                  image: Image.network(
                    dono.avatar!,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Text("Erro"),
                    ),
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Icon(
              Icons.account_circle_outlined,
              size: width * 0.065,
            ),
    ),
    GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserPage(usuario: dono),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          dono.username?.substring(0, 15) ?? dono.uid!.substring(0, 10),
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
    ),
    SizedBox(
      height: width * 0.065,
      child: Align(
        alignment: Alignment.topLeft,
        child: MiniSeguirUsuario(usuario: dono),
      ),
    )
  ];
  return data;
}
