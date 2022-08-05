import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    builder: (context, greatPlaces, ch) {
                      return greatPlaces.items.isEmpty
                          ? ch!
                          : ListView.builder(
                              itemCount: greatPlaces.items.length,
                              itemBuilder: (context, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    greatPlaces.items[index].image,
                                  ),
                                ),
                                title: Text(greatPlaces.items[index].title),
                                onTap: () {
                                  //....
                                },
                              ),
                            );
                    },
                    child: const Center(
                      child: Text('No places yet, adding some!'),
                    ),
                  ),
      ),
    );
  }
}
