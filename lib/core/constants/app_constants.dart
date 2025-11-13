class AppConstants {
  // App Info
  static const String appName = 'Fortnite Shop';
  static const String appVersion = '1.0.0';
  // imagens assets
  static const String imgFundo = 'assets/images/fundo.png';
  // Pagination
  static const int defaultPageSize = 20;
  static const int initialPage = 1;

  // Debounce
  static const Duration searchDebounce = Duration(milliseconds: 500);

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Validation
  static const int minPasswordLength = 6;

  // Error Messages
  static const String networkError = 'Erro de conexão. Verifique sua internet.';
  static const String serverError =
      'Erro no servidor. Tente novamente mais tarde.';
  static const String unauthorizedError =
      'Sessão expirada. Faça login novamente.';
  static const String invalidCredentials =
      'Email ou senha inválidos. Tente novamente.';
  static const String userNotFoundError =
      'Usuário não encontrado. Crie seu cadastro.';
  static const String genericError = 'Ocorreu um erro inesperado.';

  // Success Messages
  static const String loginSuccess = 'Login realizado com sucesso!';
  static const String registerSuccess = 'Cadastro realizado com sucesso!';
  static const String purchaseSuccess = 'Cosmético comprado com sucesso!';
  static const String returnSuccess = 'Cosmético devolvido com sucesso!';

  // Cosmetic Types
  static const List<String> cosmeticTypes = [
    'Outfit',
    'Glider',
    'Pickaxe',
    'Back Bling',
    'Emote',
    'Wrap',
  ];

  // Cosmetic Rarities
  static const List<String> cosmeticRarities = [
    'Common',
    'Uncommon',
    'Rare',
    'Epic',
    'Legendary',
  ];
}
