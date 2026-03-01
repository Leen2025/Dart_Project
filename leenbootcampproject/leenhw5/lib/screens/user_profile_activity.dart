import 'package:flutter/material.dart';
import 'package:leenhw5/models/posts_model.dart';
import 'package:leenhw5/models/todo_model.dart';
import 'package:leenhw5/models/user_model.dart';
import 'package:leenhw5/network/network_method.dart';

class UserProfileActivityScreen extends StatefulWidget {
  final int userId;
  const UserProfileActivityScreen({super.key, required this.userId});

  @override
  State<UserProfileActivityScreen> createState() =>
      _UserProfileActivityScreenState();
}

class _UserProfileActivityScreenState extends State<UserProfileActivityScreen> {
  UserModel? userLoaded;
  List<PostModel> postLoaded = [];
  List<TodoModel> todoLoaded = [];

  bool isLoadingUser = true;
  bool isLoadingPosts = true;
  bool isLoadingTodos = true;

  String? userError;
  String? postsError;
  String? todosError;

  @override
  void initState() {
    super.initState();
    _iniLoadedUser();
    _iniLoadedPosts();
    _iniLoadedTodos();
  }

  Future<void> _iniLoadedUser() async {
    try {
      final api = NetworkMethod();
      final users = await api.getAllUsers();
      final userIndex = widget.userId - 1;
      if (userIndex >= 0 && userIndex < users.length) {
        userLoaded = users[userIndex];
      }
    } catch (error) {
      userError = error.toString();
    } finally {
      if (mounted) {
        setState(() {
          isLoadingUser = false;
        });
      }
    }
  }

  Future<void> _iniLoadedPosts() async {
    try {
      final api = NetworkMethod();
      postLoaded = await api.getUserPosts(widget.userId);
    } catch (error) {
      postsError = error.toString();
    } finally {
      if (mounted) {
        setState(() {
          isLoadingPosts = false;
        });
      }
    }
  }

  Future<void> _iniLoadedTodos() async {
    try {
      final api = NetworkMethod();
      todoLoaded = await api.getUserTodos(widget.userId);
    } catch (error) {
      todosError = error.toString();
    } finally {
      if (mounted) {
        setState(() {
          isLoadingTodos = false;
        });
      }
    }
  }

  Widget _headerCard() {
    if (isLoadingUser) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: LinearProgressIndicator(),
      );
    }

    if (userError != null) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Text('Error loading user: $userError'),
      );
    }

    if (userLoaded == null) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Text('User not found'),
      );
    }

    final user = userLoaded!;
    return Card(
      color: const Color.fromARGB(204, 149, 194, 156),
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Phone: ${user.phone}', style: const TextStyle(color: Colors.white)),
            Text('Website: ${user.website}', style: const TextStyle(color: Colors.white)),
            Text(
              'Address: ${user.address.street}, ${user.address.suite}, ${user.address.city}',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // tap

  Widget _postsTab() {
    if (isLoadingPosts) {
      return const Center(child: CircularProgressIndicator());
    }
    if (postsError != null) {
      return Center(child: Text('Error loading posts: $postsError'));
    }
    if (postLoaded.isEmpty) {
      return const Center(child: Text('No posts found'));
    }

    return ListView.builder(
      itemCount: postLoaded.length,
      itemBuilder: (context, index) {
        final post = postLoaded[index];
        return Card(
          color: const Color.fromARGB(255, 138, 172, 151),
          child: ListTile(
            title: Text(
              post.title,
              style: TextStyle(color: const Color.fromARGB(255, 5, 12, 8)),
            ),
            subtitle: Text(post.body, style: TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  Widget _todosTab() {
    if (isLoadingTodos) {
      return const Center(child: CircularProgressIndicator());
    }
    if (todosError != null) {
      return Center(child: Text('Error loading todos: $todosError'));
    }
    if (todoLoaded.isEmpty) {
      return const Center(child: Text('No todos found'));
    }

    return ListView.builder(
      itemCount: todoLoaded.length,
      itemBuilder: (context, index) {
        final todo = todoLoaded[index];
        return ListTile(
          leading: Icon(
            todo.completed ? Icons.check_circle : Icons.cancel,
            color: todo.completed ? Colors.green : Colors.red,
          ),
          title: Text(todo.title),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 220, 239, 221),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 2, 51, 27),
          title: Text(
            'User ${widget.userId}',
            style: const TextStyle(color: Colors.white),
          ),
          bottom: const TabBar(
          indicatorColor: Colors.green,
            tabs: [
              Tab(
                child: Text('Posts', style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text('Todos', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            
            _headerCard(),
            Expanded(child: TabBarView(children: [_postsTab(), _todosTab()])),
          ],
        ),
      ),
    );
  }
}
