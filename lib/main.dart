import 'package:flutter/material.dart';
import 'CharacterDetailModal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = 'https://api.sampleapis.com/rickandmorty/characters';
  List<Character> characters = [];

  Future<void> getCharacters() async {
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Character> fetchedCharacters = jsonData.map((item) {
          return Character(
            id: int.parse(item['id'].toString()),
            name: item['name'],
            status: item['status'],
            species: item['species'],
            type: item['type'],
            gender: item['gender'],
            origin: item['origin'],
            image: item['image'],
          );
        }).toList();

        setState(() {
          characters = fetchedCharacters;
          print('Characters fetched successfully: ${characters.length}');
        });
      } else {
        print('Failed to fetch characters: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching characters: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF1E1E1E),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    return buildCard(context, characters[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, Character item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailModal(item: item),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF404040),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: Image.network(
              item.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
