import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../../../../core/network/dio_client.dart';

class UserService {
  final DioClient dioClient;

  UserService(this.dioClient);

  Future<UserModel> getUserById(int id) async {
    try {
      final Response response = await dioClient.get('/users/$id');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Erro ao buscar usuário: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Erro de conexão: ${e.message}');
    }
  }

  Future<UserModel> login(UserModel user) async {
    try {
      final Response response = await dioClient.post(
        '/users/login',
        data: user.toJson(), // Envia o JSON com os dados do usuário
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data); // Converte a resposta em um User
      } else {
        throw Exception('Erro ao fazer login: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Erro de login: ${e.response?.data ?? e.message}');
    }
  }

}

