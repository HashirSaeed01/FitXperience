import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class foodPreferences extends StatefulWidget {
  const foodPreferences({super.key});

  @override
  State<foodPreferences> createState() => _foodPreferencesState();
}

class _foodPreferencesState extends State<foodPreferences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Preferences'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Set your food preferences:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cuisine Type',
                hintText: 'e.g., Italian, Mexican',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Dietary Restrictions',
                hintText: 'e.g., Gluten-free, Vegan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Calorie Range',
                hintText: 'e.g., 500-1000 calories',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Preparation Time',
                hintText: 'e.g., Up to 30 minutes',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your action for filtering
              },
              child: Text('Apply Filters'),
              style: ElevatedButton.styleFrom(),
            ),
          ],
        ),
      ),
    );
  }
}
