import 'package:flutter/material.dart';
import 'package:leaf_loom/database_helper.dart';

class AddPlantPage extends StatelessWidget {
  final String username;
  AddPlantPage({required this.username});
  final TextEditingController plantNameController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController plantedDateController = TextEditingController();
  final TextEditingController plantLocationController = TextEditingController();
  final TextEditingController soilTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF588C7E), // Viridian
        title: Text('Add Plant'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/home_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Add a New Plant',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF588C7E), // Viridian
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: plantNameController,
                        decoration: InputDecoration(
                          labelText: 'Plant Name:',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: speciesController,
                        decoration: InputDecoration(
                          labelText: 'Variety:',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: plantedDateController,
                        decoration: InputDecoration(
                          labelText: 'Planted Date:',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: plantLocationController,
                        decoration: InputDecoration(
                          labelText: 'Location:',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: soilTypeController,
                        decoration: InputDecoration(
                          labelText: 'Type of Soil:',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          // Get the plant data from the text controllers
                          String plantName = plantNameController.text;
                          String species = speciesController.text;
                          String planted_date = plantedDateController.text;
                          String location = plantLocationController.text;
                          String soilType = soilTypeController.text;

                          // Create a map with the plant data
                          Map<String, dynamic> plantData = {
                            'user': username, // Assuming you have a way to get the current user's username
                            'name': plantName,
                            'species': species,
                            'planted_date': planted_date, // You can use a date picker to select the planted date
                            'location': location, // Assuming you have a way to determine the plant's location
                            'soil_type': soilType,
                          };

                          // Insert the plant data into the database

                          await DatabaseHelper.instance.insertPlant(plantData);

                          // Show a snackbar to indicate that the plant has been added
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Plant added successfully!'),
                            ),
                          );

                          // Navigate back to the previous screen
                          Navigator.pop(context);
                        },
                        child: Text('Add Plant'),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF588C7E), // Viridian
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
