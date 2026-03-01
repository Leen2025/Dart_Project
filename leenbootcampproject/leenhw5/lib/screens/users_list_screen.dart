import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leenhw5/models/user_model.dart';
import 'package:leenhw5/network/network_method.dart';
import 'package:leenhw5/route/route_key.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<UserModel> userLoaded = [];
  String? loadError;

  @override
  void initState() {
    super.initState();
    _iniLoaded();
  }

  Future<void> _iniLoaded() async {
    try {
      final api = NetworkMethod();
      userLoaded = await api.getAllUsers();
      loadError = null;
    } catch (error) {
      loadError = error.toString();
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 239, 221),
      appBar: AppBar(
        title: const Text('Users List', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 2, 51, 27),
      ),
      body: SafeArea(
        child: loadError != null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Network error: $loadError'),
                ),
              )
            : userLoaded.isNotEmpty
                ? ListView.builder(
                    itemCount: userLoaded.length,
                    itemBuilder: (context, index) {
                      final user = userLoaded[index];
                      return Card(
                        color: const Color.fromARGB(255, 161, 185, 176),
                        child: ListTile(
                          title: Text(
                            user.name,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 4, 56, 37),
                            ),
                          ),
                          subtitle: Text(
                            'Username: ${user.username}\n Company: ${user.company.name}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            context.push('${RoutesKey.userProfileBase}/${user.id}');
                          },
                        ),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
