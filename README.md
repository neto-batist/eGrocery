# 🛒 Flutter Grocery App 

![Preview](/gif.gif)  

## 📱 Aplicativo eGrocery  

![App UI](/ui.png)  
![App UI](/g_0.png)  
![App UI](/g_1.png)  

---

## 📌 *Descrição do Aplicativo eGrocery*  
O *eGrocery* é um aplicativo de compras online voltado para mercados de bairro e pequenas lojas, com o objetivo de conectar diretamente o estabelecimento aos seus clientes. Ele permite que os consumidores realizem pedidos de produtos de supermercado de forma prática e rápida, enquanto o mercado obtém uma visão mais clara sobre os hábitos de compra de seus clientes.  

---

## 🎯 *Objetivo do Aplicativo*  
Facilitar o processo de compra de produtos de mercado, permitindo que os usuários:

✅ Naveguem por categorias de produtos

✅ Adicionem itens ao carrinho

✅ Finalizem pedidos com diferentes opções de pagamento e entrega


Além disso, o app serve como uma ferramenta para que o mercado entenda melhor os comportamentos e preferências de seus consumidores, sem depender de plataformas intermediárias como o iFood. 

---

## 👥 *Perfil do Usuário*  
#🔹 Clientes finais, que desejam:

   🔹Evitar deslocamentos e filas
    
   🔹Reabastecer sua casa de forma prática
    
   🔹Comprar produtos diretamente do seu mercado local
    
#🔹 Administrador do mercado, que:

   🔹Informa aos desenvolvedores os produtos disponíveis e promoções atuais
    
   🔹Não interage diretamente com o app, mas fornece os dados que serão inseridos na API consumida pelo aplicativo
    
   🔹Utiliza as informações geradas pelo uso do app para conhecer melhor seus clientes  
    
---

## 🚀 *Funcionalidades Principais*  

✔ Cadastro e login de usuários (com suporte a e-mail, telefone e redes sociais)

✔ Catálogo de produtos organizado por categorias (com fotos, descrições e preços)

✔ Carrinho de compras e gerenciamento de pedidos (adicionar/remover itens, aplicar cupons)

✔ Pagamento online (cartão de crédito, débito e carteiras digitais)

✔ Rastreamento de pedidos e notificações sobre o status da entrega

✔ Lista de favoritos para facilitar compras futuras

✔ Histórico de pedidos para reabastecimento rápido 

O *eGrocery* proporciona uma *experiência fluida e moderna, com um design **limpo e intuitivo, permitindo que qualquer usuário **navegue facilmente pelo app e realize suas compras com poucos toques.*  

---

## 📌 *Primeira Entrega do Projeto*  

📌 *Equipe do Projeto:*  

👨‍💻 Felipe Mendes - 📩 felipe.mendess@ufape.edu.br

👨‍💻 Neto Batista - 📩 netobatista090@gmail.com

👨‍💻 Pedro William - 📩 pedrowilliam014@hotmail.com

📂 Conteúdo da Primeira Entrega

📄 📑 Documentação → Disponível na pasta "Documentação do Projeto".

🎥 📽️ Fluxo de Telas → Explicado no vídeo da primeira parte.

📸 🖼️ Prints de Referência → Localizados logo abaixo do vídeo. 

---

## 💻 Tecnologias Utilizadas

🔹 **Flutter** - Framework principal para construção da interface e lógica da aplicação mobile  
🔹 **Dart** - Linguagem de programação utilizada com Flutter  
🔹 **Dio** - Cliente HTTP utilizado para comunicação com APIs REST  
🔹 **GetIt** - Gerenciador de injeção de dependências  
🔹 **Equatable** - Facilita a comparação de objetos, útil especialmente com BLoC  
🔹 **Bloc (flutter_bloc)** - Gerenciamento de estado baseado em eventos e estados  
🔹 **JsonSerializable** - Geração automática de código para serialização JSON  
🔹 **Hive** - Armazenamento local leve e rápido  
🔹 **Path Provider** - Permite acessar diretórios locais em dispositivos  
🔹 **Freezed** - Geração automática de classes imutáveis e union types  
🔹 **Build Runner** - Ferramenta para geração de código com base em anotações  
🔹 **Google Fonts** - Utilização de fontes do Google na UI  
🔹 **Flutter SVG** - Renderização de arquivos SVG  
🔹 **Lottie** - Animações baseadas em arquivos JSON

---

## 🧩 Padrões de Projeto Utilizados

🔸 **Repository Pattern** - Separa a lógica de negócios da lógica de acesso a dados, facilitando testes e manutenção  
🔸 **Data Source Pattern** - Organiza a camada de dados em fontes remota e local  
🔸 **Dependency Injection (com GetIt)** - Torna as dependências desacopladas e de fácil substituição  
🔸 **Clean Architecture** - Estrutura o projeto em camadas: Domain, Data e Presentation, aumentando a escalabilidade e manutenibilidade  
🔸 **DTO (Data Transfer Object)** - Facilita o transporte de dados entre camadas e serialização  
🔸 **State Management com BLoC** - Gerencia os estados de forma previsível e baseada em eventos  
🔸 **Service Locator** - Implementação de injeção de dependência via GetIt  
🔸 **Use Cases (Casos de Uso)** - Representam as regras de negócio de forma isolada da camada de apresentação



---

## 🏗 *Como Rodar o Projeto*  

### 🔧 *Pré-requisitos*  
Antes de começar, certifique-se de ter instalado:  
- Flutter SDK  
- Android Studio / VS Code  
- Emulador ou dispositivo físico conectado  

### 📥 *Clonando o Repositório*  
```bash
git clone https://github.com/seu-usuario/eGrocery.git
cd eGrocery
flutter pub get
```

---

## 🗂️ Organização do Projeto
### Para acompanhar o progresso do desenvolvimento, tarefas e estrutura de funcionalidades, acesse o quadro do Trello:

🔗 [Acesse o Trello do Projeto](https://trello.com/invite/b/67fe7bfbdcd9d399e88e4a06/ATTI3acbec4657954482677b2710a33b4563A21F8B8E/damhttps://trello.com/invite/b/67fe7bfbdcd9d399e88e4a06/ATTI3acbec4657954482677b2710a33b4563A21F8B8E/dam)

🔹Lá você encontra:

🔹Tarefas concluídas e pendentes

🔹Etapas de desenvolvimento por sprint

🔹Organização por módulos e funcionalidades

🔹Colaboração entre os membros da equipe

---


## O aplicativo eGrocery consome dados de uma API REST desenvolvida especialmente para esse projeto.
### Nela estão os produtos, promoções e dados necessários para o funcionamento do app.

📡 Repositório da API:

👉 https://github.com/neto-batist/eGrocery_back
