import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';
import 'user_remote_datasource.dart';

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final DioClient dioClient;

  UserRemoteDatasourceImpl(this.dioClient);

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await dioClient.get('/users');
      final List data = response.data['content'];
      return data.map((json) => UserModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Erro ao buscar usuários: ${e.message}');
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    try {
      final response = await dioClient.get('/users/$id');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Erro ao buscar usuário por ID: ${e.message}');
    }
  }

  @override
  Future<UserModel> login(UserModel user) async {
    try {
      final response = await dioClient.post(
        '/users/login',
        data: user.toJson(),
      );
      if (response.statusCode == 200){
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Erro ao fazer login');
      }
    } on DioException catch (e) {
      throw Exception('Erro ao fazer login: ${e.message}');
    }
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    try {
    final response = await dioClient.post(
        '/users/create',
        data: user.toJson(),
      );
    if (response.statusCode == 200){
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Erro ao criar usuário');
    }
    } on DioException catch (e) {
      throw Exception('Erro ao criar usuário: ${e.message}');
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    try {
      await dioClient.put(
        '/users/update/${user.id}',
        data: user.toJson(),
      );
    } on DioException catch (e) {
      throw Exception('Erro ao atualizar usuário: ${e.message}');
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      await dioClient.delete('/users/delete/$id');
    } on DioException catch (e) {
      throw Exception('Erro ao deletar usuário: ${e.message}');
    }
  }
}
