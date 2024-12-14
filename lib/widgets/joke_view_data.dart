import 'package:flutter/material.dart';
import 'package:lab2/models/Jokes.dart';

class JokeViewData extends StatelessWidget {
  const JokeViewData({
    super.key,
    required this.jokes,
  });

  final Future<List<Jokes>> jokes;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Jokes>>(
      future: jokes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              snapshot.data![index].setup,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: const Color.fromARGB(255, 33, 36, 34),
                              ),
                            ),
                            content: Text(snapshot.data![index].punchline),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: Text(snapshot.data![index].setup),
                    subtitle: Text('Click to see the punchline'),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
