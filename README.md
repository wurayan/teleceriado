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

## Ideias Futuras  
    - Criar uma lista de frases para serem exibidas enquanto as telas carregam;
    - Reduzir o tempo de demora para se carregar as imagens com o network;
    - Botao favoritar precisa ser responsivo e mostrar "Favorito" quando a série estiver na lista de favoritos;
    - usar o AutomaticKeepAliveClientMixin para manter os estado da página após sua navegação (assim não teremos que dar reload na página toda vez que abrirmos ela, usar com as páginas de trending, e na de usuário com uma verificação para atualizar a página somente quando há alterações?)