# Fortnite Shop - Flutter App

Aplicativo Flutter completo usando arquitetura MVVM com Cubit para consumir a API REST do ShopFortnite. O app possui autenticação JWT e todas as funcionalidades da loja.

## 🏗️ Arquitetura

- **MVVM Pattern**: Models, Views, ViewModels
- **Cubit**: Gerenciamento de estado (flutter_bloc com Cubit - SEM Events)
- **Repository Pattern**: Camada de abstração para API
- **BLoC Provider**: Injeção de dependências

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                       # Entry point com providers
├── app.dart                        # Configuração do MaterialApp
├── core/
│   ├── constants/
│   │   ├── api_constants.dart      # URLs e endpoints da API
│   │   └── app_constants.dart      # Constantes do app
│   ├── theme/
│   │   └── fortnite_theme.dart     # Tema customizado Fortnite
│   ├── utils/
│   │   └── validators.dart         # Validadores de formulários
│   └── network/
│       └── api_client.dart         # Cliente HTTP com Dio
├── data/
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── cosmetic_model.dart
│   │   ├── transaction_model.dart
│   │   ├── user_cosmetic_model.dart
│   │   ├── auth_response_model.dart
│   │   └── paginated_response_model.dart
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── cosmetics_repository.dart
│   │   └── user_repository.dart
│   └── services/
│       └── storage_service.dart
├── presentation/
│   ├── cubits/
│   │   ├── auth/
│   │   │   ├── auth_cubit.dart
│   │   │   └── auth_state.dart
│   │   ├── cosmetics/
│   │   │   ├── cosmetics_cubit.dart
│   │   │   └── cosmetics_state.dart
│   │   ├── profile/
│   │   │   ├── profile_cubit.dart
│   │   │   └── profile_state.dart
│   │   └── users/
│   │       ├── users_cubit.dart
│   │       └── users_state.dart
│   ├── pages/
│   │   ├── auth/
│   │   │   ├── login_page.dart
│   │   │   └── register_page.dart
│   │   ├── home/
│   │   │   └── home_page.dart
│   │   ├── shop/
│   │   │   └── shop_page.dart
│   │   ├── profile/
│   │   │   └── profile_page.dart
│   │   └── users/
│   │       └── users_page.dart
│   └── widgets/
│       ├── cosmetic_card.dart
│       ├── loading_widget.dart
│       └── custom_app_bar.dart
```

## 🚀 Configuração

### Pré-requisitos

- Flutter SDK (>=3.8.0)
- Dart SDK
- API Backend rodando em `http://localhost:5106`

### Instalação

1. Clone o repositório
```bash
git clone <seu-repositorio>
cd fortnite_flutter
```

2. Instale as dependências
```bash
flutter pub get
```

3. Gere os arquivos de serialização
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Execute o aplicativo
```bash
flutter run
```

## 🔧 Configuração da API

Por padrão, a API está configurada para `http://localhost:5106`.

Para alterar o endereço da API, edite o arquivo:
```dart
lib/core/constants/api_constants.dart
```

```dart
class ApiConstants {
  static const String baseUrl = 'http://seu-endereco-aqui:porta';
  ...
}
```

## 📱 Funcionalidades

### Autenticação
- ✅ Login com email e senha
- ✅ Registro de novos usuários
- ✅ Validação de formulários
- ✅ Armazenamento seguro de JWT
- ✅ Logout

### Loja de Cosméticos
- ✅ Grid de cosméticos com imagens
- ✅ Filtros por tipo, raridade, à venda, novos
- ✅ Busca por nome
- ✅ Paginação infinita (scroll)
- ✅ Badge de raridade com cores
- ✅ Compra de cosméticos com confirmação
- ✅ Pull to refresh

### Perfil do Usuário
- ✅ Exibição de nome, email e V-Bucks
- ✅ Lista de cosméticos adquiridos
- ✅ Devolução de cosméticos
- ✅ Botão de logout

### Usuários
- ✅ Lista de todos os usuários
- ✅ Exibição de nome, email e V-Bucks
- ✅ Tabela de cosméticos de cada usuário
- ✅ Total gasto por usuário

## 🎨 Tema Fortnite

O app possui um tema customizado inspirado no Fortnite:

- **Cores principais**: Roxo (#7b5cff), Azul (#00d9ff), Escuro (#0a0e27)
- **Efeitos neon**: Textos e cards com brilho
- **Cores de raridade**:
  - Common (Cinza)
  - Uncommon (Verde)
  - Rare (Azul)
  - Epic (Roxo)
  - Legendary (Laranja)

## 🔑 Padrão Cubit

O app usa Cubit para gerenciamento de estado (SEM Events). Exemplo:

```dart
// Chamar método diretamente (SEM eventos)
context.read<AuthCubit>().login(email, password);

// Escutar mudanças de estado
BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    if (state is AuthLoading) {
      return CircularProgressIndicator();
    }
    if (state is AuthAuthenticated) {
      return Text('Bem-vindo ${state.user.name}');
    }
    return LoginForm();
  },
)
```

## 📦 Dependências Principais

```yaml
dependencies:
  flutter_bloc: ^8.1.3       # Gerenciamento de estado
  equatable: ^2.0.5          # Comparação de objetos
  dio: ^5.4.0                # Cliente HTTP
  retrofit: ^4.0.3           # REST client
  json_annotation: ^4.8.1    # Serialização JSON
  flutter_secure_storage: ^9.0.0  # Storage seguro
  shared_preferences: ^2.2.2      # Preferências
  cached_network_image: ^3.3.0    # Cache de imagens
  shimmer: ^3.0.0                 # Loading skeleton
```

## 🔒 Segurança

- JWT armazenado com `flutter_secure_storage`
- Token enviado automaticamente em todas requisições autenticadas
- Tratamento de token expirado (401)
- Validação de formulários no client-side

## 🐛 Troubleshooting

### Erro de conexão com a API
Certifique-se de que:
1. A API backend está rodando
2. O endereço está correto em `api_constants.dart`
3. Você está usando um emulador/dispositivo que pode acessar localhost

Para Android Emulator, use:
```dart
static const String baseUrl = 'http://Colocar seu IP:5106';
```

Para iOS Simulator e dispositivos físicos, use o IP da sua máquina:
```dart
static const String baseUrl = 'http://192.168.x.x:5106';
```

### Erro de build_runner
Se houver problemas com os arquivos gerados:
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📄 Licença

Este projeto é um exemplo educacional.

## 👥 Autores

Desenvolvido seguindo as especificações do padrão MVVM + Cubit.
