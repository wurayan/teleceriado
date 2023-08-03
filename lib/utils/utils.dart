import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teleceriado/services/api_service.dart';

import '../models/episodio.dart';
import 'color_checker.dart';

List<String> loadingFrases = [
  "Entrevistando os atores",
  "Reclamando do Oscar",
  "Preparando sangue falso",
  "Viajando o multiverso",
  "Toretto pilotando o Optimus Prime",
  "Já assistiu Boku no Pico?",
  "Entra no robô Shinji",
  "Qual a velocidade de uma andorinha em voo?",
  "Voltando no tempo",
  "Ned Stark morre",
  "Homofobia nos olhos",
  "Você não é 'literalmente ele'",
  "Não consigo ler nada.",
  "L morre",
  "Kuririn ressuscita",
  "Eu sei o que voce assistiu ontem",
  "Tem que boicotar a Netflix",

];

List<String> avatarPlaceholder = [
  "(◉‿◉)",
  "(ㆆ _ ㆆ)",
  "☜(⌒▽⌒)",
  "•`_´•",
  "( •͡˘ _•͡˘)",
  "(͡ ° ͜ʖ ͡ °)",
  "( ✜︵✜ )",
  "(╥﹏╥)",
  "(｡◕‿‿◕｡)",
  "(⩾﹏⩽)",
  "(⌐⊙_⊙)",
];

String getAvatarPlaceholder(){
  int index = Random().nextInt(avatarPlaceholder.length);
  return avatarPlaceholder[index];
}

String getLoadingFrase() {
  int index = Random().nextInt(loadingFrases.length);
  return loadingFrases[index];
}

String loremPicsum = "https://picsum.photos/300/200";

Future<bool> validateImage(String url) async {
  http.Response res;
  try {
    res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      return false;
    } else {
      Map headers = res.headers;
      String type = headers["content-type"];
      print(type);
      print(res.body);
      if (type == 'image/jpeg' || type == 'image/png' || type == 'image/gif') {
        return true;
      } else {
        return false;
      }
    }
  } catch (e) {
    return false;
  }
}

  ColorFilter? colorFilter(int lightness) {
    if (lightness <= 50) {
      return const ColorFilter.mode(Colors.black26, BlendMode.darken);
    }
    if (lightness > 50 && lightness <= 80) {
      return const ColorFilter.mode(Colors.black38, BlendMode.darken);
    }
    if (lightness > 80 && lightness <= 100) {
      return const ColorFilter.mode(Colors.black45, BlendMode.darken);
    }
    if (lightness > 100) {
      return const ColorFilter.mode(Colors.black54, BlendMode.darken);
    }
    return null;
  }

Future<int?> lightnessCheck(Episodio episodio) async {
    ApiService api = ApiService();
    if(episodio.imagem==null) return null;
      int lightness = await isDark(
        episodio.wasEdited == true
            ? episodio.imagem!
            : api.getSeriePoster(episodio.imagem!),
      );
      return lightness;
  }