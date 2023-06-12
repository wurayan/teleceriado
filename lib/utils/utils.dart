import 'dart:math';
import 'package:http/http.dart' as http;

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
  "Você não é 'literalmente ele'"
];

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
