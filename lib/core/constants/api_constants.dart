class ApiConstants {
  // Base URL - API local do backend
  static const String baseUrl =
      'https://shopfortnite-production.up.railway.app/';

  // Fortnite External API (para cosméticos)
  static const String fortniteApiBaseUrl = 'https://fortnite-api.com/v2';

  // Auth Endpoints
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';

  // Cosmetics Endpoints
  static const String cosmetics = '/api/cosmetics';
  static String cosmeticDetails(String id) => '/api/cosmetics/$id';
  static String purchaseCosmetic(String id) => '/api/cosmetics/$id/purchase';
  static String returnCosmetic(String id) => '/api/cosmetics/$id/return';

  // Users Endpoints
  static const String currentUser = '/api/users/me';
  static const String users = '/api/users';
  static String userDetails(String id) => '/api/users/$id';
  static String userCosmetics(String id) => '/api/users/$id/cosmetics';
  static String userTransactions(String id) => '/api/users/$id/transactions';

  // Headers
  static const String authHeader = 'Authorization';
  static String bearerToken(String token) => 'Bearer $token';

  // Storage Keys
  static const String jwtTokenKey = 'jwt_token';
  static const String userKey = 'user_data';
}
