## Pomodoro

Este é um aplicativo de produtividade ainda em desenvolvimento.

### O aplicativo possui:
 - Timer de 25 minutos.
 - Timer de uma hora (desafio diário, só funciona uma vez no dia).

### TO DO
 - Lista de tarefas.
 - Configurações de temas do aplicativo.
 - Armazenamento de dados de uso online para comodidade do usuário.

### Tecnologias usadas
 - Desenvolvido com o framework Flutter. Todas as telas e funcionalidades foram escritas na linguagem Dart.

### Dependências
 - Circular Countdown Timer
 - Android Power Manager
 - Permission Handler
 - Lottie

## Como usar

Instale o Flutter SDK e rode via terminal o comando `flutter doctor`. Todas as dependências solicitadas no output do comando precisam ser cumpridas.
O Android SDK precisa ser em uma versão superior a 33.
Após descompactar o arquivo .zip, vá até a pasta (via shell/bash ou prompt do Windows) e rode o comando `flutter run` na pasta mãe do projeto.
Selecione onde executar **NÃO OTIMIZADO PARA WEB** e aguarde que a depuração seja executada.
Para efetuar uma build do projeto, use o comando `flutter build <tipo de build>`. Exemplo `flutter build apk`.
Demais modelos de build e comandos, vide a [Documentação](https://docs.flutter.dev/).
