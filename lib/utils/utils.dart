import 'dart:math';

List<String> loadingFrases = [
  "Entrevistando os atores",
  "Reclamando do Oscar",
  "Preparando sangue falso",
  "Viajando o multiverso",
  "Toretto pilotando o Optimus Prime",
  "Já assistiu Boku no Pico?",
  "Entra no robô Shinji",
  "Série do Super Man do mal",
  "Qual a velocidade de uma andorinha em voo?",
  "Voltando no tempo",
];

String getLoadingFrase(){
  int index = Random().nextInt(loadingFrases.length);
  return loadingFrases[index];
}

String loremPicsum = "https://picsum.photos/300/200";