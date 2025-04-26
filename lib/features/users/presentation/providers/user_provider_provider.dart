import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../data/repositories/user_repository_impl.dart';
import '../../data/datasources/user_remote_datasource_impl.dart';
import '../../data/services/user_service.dart';
import '../../../../core/network/dio_client.dart';
import 'user_provider.dart';

// Provider global de UserProvider
final userProvider = ChangeNotifierProvider<UserProvider>((ref) {
  final dio = Dio(); // <- Instancia o Dio
  final dioClient = DioClient(dio); // <- Passa o Dio para o DioClient
  final userService = UserService(dioClient);
  final userRemoteDatasource = UserRemoteDatasourceImpl(dioClient);
  final userRepository = UserRepositoryImpl(userRemoteDatasource);

  return UserProvider(userRepository: userRepository);
});
