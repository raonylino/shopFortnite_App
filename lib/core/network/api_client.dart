import 'package:dio/dio.dart';
import 'package:fortnite_flutter/core/constants/api_constants.dart';
import 'package:fortnite_flutter/core/constants/app_constants.dart';
import 'package:fortnite_flutter/data/services/storage_service.dart';

class ApiClient {
  late final Dio _dio;
  final StorageService _storageService;

  ApiClient(this._storageService) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Adicionar JWT token automaticamente
          final token = await _storageService.getToken();
          if (token != null) {
            options.headers[ApiConstants.authHeader] = ApiConstants.bearerToken(
              token,
            );
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          // Tratar erro 401 (token expirado)
          if (error.response?.statusCode == 401) {
            await _storageService.clearToken();
            // Aqui você pode adicionar navegação para login se necessário
          }
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  // GET Request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST Request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT Request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE Request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error Handler
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(AppConstants.networkError);

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;

        // Tentar extrair mensagem de erro de diferentes formatos
        String? message;
        if (responseData is Map<String, dynamic>) {
          message =
              responseData['message'] as String? ??
              responseData['error'] as String? ??
              responseData['Message'] as String? ??
              responseData['Error'] as String? ??
              responseData['title'] as String?;
        } else if (responseData is String) {
          message = responseData;
        }

        message ??= error.response?.statusMessage;
        switch (statusCode) {
          case 400:
            // Erros de validação (senha incorreta, dados inválidos)
            if (message != null) {
              if (message.toLowerCase().contains('password') ||
                  message.toLowerCase().contains('senha')) {
                return Exception('Senha incorreta. Tente novamente.');
              }
              if (message.toLowerCase().contains('email') ||
                  message.toLowerCase().contains('e-mail')) {
                return Exception('Email inválido ou não cadastrado.');
              }
              if (message.toLowerCase().contains('invalid credentials') ||
                  message.toLowerCase().contains('credenciais')) {
                return Exception('Email ou senha incorretos.');
              }
              return Exception(message);
            }
            return Exception('Dados inválidos. Verifique as informações.');

          case 401:
            // Não autorizado
            if (message != null && message.toLowerCase().contains('password')) {
              return Exception('Senha incorreta. Tente novamente.');
            }
            if (message != null &&
                !message.toLowerCase().contains('token') &&
                !message.toLowerCase().contains('sessão') &&
                !message.toLowerCase().contains('expirada')) {
              return Exception(message);
            }
            return Exception('Email ou senha incorretos.');

          case 404:
            // Não encontrado
            if (message != null &&
                (message.toLowerCase().contains('user') ||
                    message.toLowerCase().contains('usuário'))) {
              return Exception('Usuário não cadastrado.');
            }
            return Exception(message ?? 'Recurso não encontrado');

          case 500:
            return Exception(AppConstants.serverError);

          default:
            return Exception(message ?? AppConstants.genericError);
        }

      case DioExceptionType.cancel:
        return Exception('Requisição cancelada');

      case DioExceptionType.unknown:
      default:
        if (error.error.toString().contains('SocketException')) {
          return Exception(AppConstants.networkError);
        }
        return Exception(AppConstants.genericError);
    }
  }
}
