import 'package:flutter/material.dart';
import 'package:leaf_loom/add_plant.dart'; // Import AddPlantPage
import 'package:leaf_loom/database_helper.dart';

class MyPlantsPage extends StatefulWidget {
  final String username;
  MyPlantsPage({required this.username});

  @override
  _MyPlantsPageState createState() => _MyPlantsPageState();
}

class _MyPlantsPageState extends State<MyPlantsPage> {
  late Future<List<Map<String, dynamic>>> _plants;

  @override
  void initState() {
    super.initState();
    final String username = widget.username;
    _plants = DatabaseHelper.instance.queryAllPlants(username);
    _loadPlants();
  }

  Future<void> _loadPlants() async {
    final String username = widget.username;
    if (username != null) {
      setState(() {
        print('my plants page: $username');
        _plants = DatabaseHelper.instance.queryAllPlants(username);
      });
    } else {
      // Handle case when username is not available
      print('Error: Username not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Plants',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF588C7E), // Virdian
      ),
      body: Container(
        margin: EdgeInsets.all(16.0), // Add gap around the table
        decoration: BoxDecoration(
          color: Color(0xFF588C7E), // Virdian
          borderRadius: BorderRadius.circular(10.0), // Rounded corners for the container
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _plants,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No plants found.'));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Make the content scroll horizontally
                child: DataTable(
                  columnSpacing: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.white, // White background color for the table body
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners for the table
                  ),
                  columns: [
                    DataColumn(label: Text('Plant Name', style: TextStyle(color: Color(0xFF588C7E)))), // Viridian
                    DataColumn(label: Text('Variety', style: TextStyle(color: Color(0xFF588C7E)))), // Viridian
                    DataColumn(label: Text('Planted Date', style: TextStyle(color: Color(0xFF588C7E)))), // Viridian
                    DataColumn(label: Text('Location', style: TextStyle(color: Color(0xFF588C7E)))), // Viridian
                    DataColumn(label: Text('Soil Type', style: TextStyle(color: Color(0xFF588C7E)))), // Viridian
                  ],
                  rows: snapshot.data!.map<DataRow>((plant) {
                    return DataRow(
                      cells: [
                        DataCell(Text(plant['name'] ?? 'N/A', style: TextStyle(color: Colors.black))),
                        DataCell(Text(plant['species'] ?? 'N/A', style: TextStyle(color: Colors.black))),
                        DataCell(Text(plant['planted_date'] ?? 'N/A', style: TextStyle(color: Colors.black))),
                        DataCell(Text(plant['location'] ?? 'N/A', style: TextStyle(color: Colors.black))),
                        DataCell(Text(plant['soil_type'] ?? 'N/A', style: TextStyle(color: Colors.black))),
                      ],
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPlantPage(username: widget.username)),
          );
        },
        backgroundColor: Color(0xFF588C7E), // Viridian
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF588C7E), // Virdian
        padding: EdgeInsets.all(20),
        child: Text(
          'Contact Us: support@gardeningmadeeasy.com | Phone: +91 9846263749',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
