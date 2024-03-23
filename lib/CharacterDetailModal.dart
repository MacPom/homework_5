import 'package:flutter/material.dart';
import 'api.dart';

class CharacterDetailModal extends StatelessWidget {
  final Character item;

  const CharacterDetailModal({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: Image.network(
                item.image,
                fit: BoxFit.cover,
                height: 400.0,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 20.0),
            Text(item.status,
                style: TextStyle(color: Colors.white, fontSize: 30)),
            Text('species',
                style: TextStyle(color: Colors.white.withOpacity(0.8))),
            Text('     ' + item.species,
                style: TextStyle(color: Colors.white.withOpacity(0.4))),
          ],
        ),
      ),
    );
  }
}