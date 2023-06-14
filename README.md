# teleceriado

Aplicativo de gerenciamento de episódios de séries que permite adicionar descrições individuais para cada episódios e compartilhá-las com seus amigos.

## VERSÕES   
## Versão 0.0.1  
    - Criação do projeto e conexão com a API Episodate;  
    - Criação da tela inicial;  
    - Criação da tela de detalhes do episódio;  
    
## Versão 0.0.2
    - Adição do gradiente atrás do nome da Série na tela de Detalhes da Série
    - Reestruturação da Tela de Detalhes do Episódio;
    - Alteração do método de apresentação das imagens dos episódios;
    - Criação do Dialog de opções na Tela de Detalhes da Série;
    - Refatoração da tela de Detalhes da Série;
    
## Versão 1.0.0  
    - Troda de API utilizada pra o serviço da TMDB;
    - Reestruturação do API_Service para comportar o modelo de request da API;

## Versão 1.0.1  
    - Correção do código devido a atualização do Flutter;
    - Implementação do método de busca por séries;

## Versão 2.0.0-Dev  
    - Integração do Firebase ao Aplicativo;
    - Implementação do Login anônimo;
    - Criação das telas de login e Cadastro;
    - Criação widget de Loading com package SpinKit;
    - Criação dos métodos de conexão com o Firebase;
    - Implementação dos botões de salvar e favoritar Séries;
    - Apresentação das coleções do usuário na UserScreen;

## Versão 2.0.1  
    - Implementação do SnackBarGlobal;
    - Implementação da criação de Coleções;
    - Criação da tela de detalhes de Coleções;
    - Redesign dos Widgets de Loading com adição de frases engraçadas;
    - Adição da mensagem de séries não encontradas na tela de Coleções;
    - Criação do arquivo theme;
    - Resize Automático da descrição das coleções;
    - Uso de imagens aleatórias para coleções que são criadas sem link para Imagem;
    - Criação do Drawer;

## Versão 2.0.2  
    - Lista de coleções agora são salvas como array no banco de dados;
    - Implementado a edição de Username;
    - Redesign da lista de coleções ao salvar série;
    - Implementação da edição de Detalhes da Série;
    - Tela de Detalhes da Série apresenta as modificações do usuário;
    - Implementação da edição de Detalhes do Episódio;
    - Detalhes dos Episódios apresentam as alterações realizadas pelo usuário;

## Versão 2.0.3  
    - Implementação da edição de nome e imagem de usuário;



## Ideias Futuras  
    - Reduzir o tempo de demora para se carregar as imagens com o network;
    - Botao favoritar precisa ser responsivo e mostrar "Favorito" quando a série estiver na lista de favoritos;
    - Os itens de coleções ao salvar uma série podem exibir a imagem da coleção no fundo de seus cards com opacidade da esquerda para direita
    - Existe uma opção de display name no usuário do firebase, entáo nao precisamos salvar nos docs, só precisamos aprender como altera-la
    
