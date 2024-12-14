import 'package:flutter/material.dart';
import 'package:lab2/screens/jokes_view.dart';
import 'package:lab2/services/api_services.dart';
import 'package:lab2/widgets/random_joke_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Random Jokes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<String>> _categories;
  @override
  void initState() {
    super.initState();
    _categories = ApiServices.getCategories();
  }

  IconData? _getCategoryIcon(String category) {
    switch (category) {
      case 'general':
        return Icons.category;
      case 'knock-knock':
        return Icons.doorbell;
      case 'programming':
        return Icons.code;
      case 'dad':
        return Icons.family_restroom;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.ads_click),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return RandomJokeDialog();
              },
            );
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: Icon(
                      _getCategoryIcon(snapshot.data![index]),
                      color: Colors.deepPurple,
                    ),
                    tileColor: const Color.fromARGB(255, 255, 255, 255),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JokesView(category: snapshot.data![index]),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
