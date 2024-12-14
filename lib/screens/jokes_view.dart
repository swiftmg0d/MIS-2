import 'package:flutter/material.dart';
import 'package:lab2/models/Jokes.dart';
import 'package:lab2/services/api_services.dart';
import 'package:lab2/widgets/joke_view_data.dart';

class JokesView extends StatefulWidget {
  const JokesView({super.key, required this.category});
  final String category;

  @override
  State<JokesView> createState() => _JokesViewState();
}

class _JokesViewState extends State<JokesView> {
  late final Future<List<Jokes>> jokes;

  @override
  void initState() {
    jokes = ApiServices.getJokesByType(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Center(
        child: Column(
          children: [
            JokeViewData(jokes: jokes),
          ],
        ),
      ),
    );
  }
}
