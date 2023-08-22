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
    - Implementação do gerador de frases e gerador de emojis;
    - Criação da tela de Comunidade;
    - Implementação do método de Busca de Usuários;
    - Criação da tela de usuários;
    - Implementação do alerta de erros;
    - Implementação do métodos de Google Sign-In;
    - Redesign da tela de Usuário para apresentar as coleções e edições do usuário;
    - Implementado método de recuperação de Coleções e Séries Editadas do usuário;

## Versão 2.1.0
    - Redesign completo da tela de usuário:  
        Agora se trata de uma tela com detecção de gesto para o usuário navegador entre as telas de comentários, coleções e perfil visitado;
    - Criação da tela de comentários;
    - Reestruturação do método de busca das Coleções;
    - Redesign dos cards de coleções ao salvar uma série;

## Versão 3.0.0  
    - Atualização de todos os plugins;
    - Reestruturação do interceptador hhtp;
    - Possível correção do StackOverflowError;
    - Botão de favoritar é responsivo;
    - Refatoração dos métodos do Firebase e adição do arquivo Export;
    - Criação da lista de Usuários Seguindo;
    - Implementação do método de Seguir usuários;
    - Implementação do método de seguir Coleções;
    - Design da Tela de visualização de Coleção de outro usuário;
    - Refatoração da tela de Usuários;
    - Criação do botão de seguir usuário através da coleção; 

## Versão 3.0.1  
    - Implementação da validação ao fazer Login ou Cadastrar;
    - Implementação de mensagens de alerta caso;
    - Implementação do botão que permite escolher as temporadas;
    - Adição de um limitador de comprimento nas Sinopses coletadas da Api que estavam maiores que o espaço disponível dos cards;
    - Adição FlavorText quando usuário não possui comentários em sua conta;
    - Implementado Contador de seguidores;
    - Implementado Contador de Edições;
    - Implementação verificação de Primeiro Login;
    - Criação página de Profile;
    - Implementação da lista de Edições no Profile do usuário;
    - Usuário pode definir séries em "Assistindo agora" e "Série Favorita" que serão transformadas em banner;
    - Redesign Tela de Usuário para apresentar o banner da Série;
    - Implementação da aba de detalhes da Série;

## Versão 3.0.2
    CORREÇÕES:      
    - Imagem e borda de containers em forma de circulo conflitavam, com a imagem cobrindo pedaçoes da borda;
    - Falta de limite em width fazia a imagem tentar preencher a tela inteira horizontalmente na tela de Profile;

    IMPLEMENTAÇÕES:     
    - Definição de Avatar e Nome de Usuário automaticamente ao fazer cadastro utilizando conta Google;
    - Implementado edição do perfil de Usuário.
    - Implementado armazenamento de arquivos no Firebase Storage;
    - Apresentação dos Badges dos usuários no perfil;

## Versão 3.0.3
    CORREÇÕES:      
    - Método de salvar edições em episódios eram muito confuso e mal feito, ainda não está perfeito, mas melhorou;
    - Retorno de lista vazia quando perfil não tem badges, anteriormente ele tentava criar badges com lista vazia;

    IMPLEMENTAÇÕES:      
    - Criação da nova tabela que permite salvar todos comentários dos usuários com Timestamp para criarmos o feed;
    - Redesign do Dialog de edição de episódios, por hora não é mais possível adicionar link de imagem;
    - Criação da tela de Feed;
    - Tela de coleções do usuário agora é acessada através da Drawer;
    - Itens de Comentários redirecionam ao perfil do criador;

## Versão 3.1.0
    CORREÇÕES:  
    - Tamanho de nome de usuário na tela perfil foi limitado pois estava vazando da tela;
    - Patch da edição de Episódios que não estava registrando os valores inseridos pelo usuário;

    IMPLEMENTAÇÕES:  
    - Posteres que não conseguem encontrar imagem agora apresentam o nome da série junto com o texto de imagem não encontrada;
    - Uso do AutomaticKeepAliveMixin para reduzir o tempo de demora do loading do App
    - Aterações menores no Design;


PROBLEMA: JA QUE VAMOS IMPLEMENTAR O MÉTODO DE SEGUIR COLEÇÕES, NÃO PODEMOS MAIS SALVAR O NOME DA COLEÇÃO COMO UID PQ ASSIM AO SALVAR DUAS COLEÇÕES COM NOMES IGUAIS DE USUARIOS DIFERENTES, NÃO VAMOS TER OCMO DIFERENCIA-LAS        


## Ideias Futuras  
    - Entendemos como captura os dados do usuario usando o firebaseAuth para obter display image, usernmae etc, vamos usar estes parametros para salvar os dados dos usuários, ou seja, alterar os métodos e salvar no auth invés do cloud firestore;
    - Aprender a usar cachedNetwork;
    - Sistema de likes e mais curtidos;
    - Logger de erros;
    - Icon e SplashScreen
    
