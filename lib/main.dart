import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_flutter/app.dart';
import 'package:fortnite_flutter/core/network/api_client.dart';
import 'package:fortnite_flutter/data/repositories/auth_repository.dart';
import 'package:fortnite_flutter/data/repositories/cosmetics_repository.dart';
import 'package:fortnite_flutter/data/repositories/transaction_repository.dart';
import 'package:fortnite_flutter/data/repositories/user_repository.dart';
import 'package:fortnite_flutter/data/services/storage_service.dart';
import 'package:fortnite_flutter/presentation/cubits/auth/auth_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/cosmetics/cosmetics_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/profile/profile_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/transactions/transactions_cubit.dart';
import 'package:fortnite_flutter/presentation/cubits/users/users_cubit.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StorageService>(
          create: (context) => StorageService(),
        ),
        RepositoryProvider<ApiClient>(
          create: (context) => ApiClient(context.read<StorageService>()),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            context.read<ApiClient>(),
            context.read<StorageService>(),
          ),
        ),
        RepositoryProvider<CosmeticsRepository>(
          create: (context) => CosmeticsRepository(context.read<ApiClient>()),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(context.read<ApiClient>()),
        ),
        RepositoryProvider<TransactionRepository>(
          create: (context) => TransactionRepository(context.read<ApiClient>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) =>
                AuthCubit(context.read<AuthRepository>())..checkAuthStatus(),
          ),
          BlocProvider<CosmeticsCubit>(
            create: (context) =>
                CosmeticsCubit(context.read<CosmeticsRepository>()),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(context.read<UserRepository>()),
          ),
          BlocProvider<UsersCubit>(
            create: (context) => UsersCubit(context.read<UserRepository>()),
          ),
          BlocProvider<TransactionsCubit>(
            create: (context) =>
                TransactionsCubit(context.read<TransactionRepository>()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
