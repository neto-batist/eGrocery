import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/user_controller.dart';
import '../providers/user_provider.dart';
import '../../domain/entities/user.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late UserController userController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserProvider>(context, listen: false);
    userController = UserController(provider);
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    await userController.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text('Erro: ${provider.error}'));
          }

          final users = provider.users;

          if (users.isEmpty) {
            return const Center(child: Text('Nenhum usuário encontrado.'));
          }

          return RefreshIndicator(
            onRefresh: _loadUsers,
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(user.name ?? 'Sem nome'),
                  subtitle: Text('ID: ${user.id}'),
                  onTap: () {
                    // Ação ao clicar no usuário
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
