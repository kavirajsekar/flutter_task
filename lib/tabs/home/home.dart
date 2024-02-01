import 'package:flutter/material.dart';

class Item {
  String name;
  String description;

  Item({required this.name, required this.description});
}

class home_screen extends StatefulWidget {
  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  List<Item> items = [];

  // Add item method
  void addItem() {
    Item newItem = Item(name: 'New Item', description: 'Description');
    setState(() {
      items.add(newItem);
    });
  }

  // Edit item method
  void editItem(int index) {
    // Implement editing logic here
    showEditDialog(index);
  }

  // Delete item method
  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  // Show edit dialog
  void showEditDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            children: [
              TextField(
                controller: TextEditingController(text: items[index].name),
                onChanged: (value) {
                  // Update name
                  items[index].name = value;
                },
              ),
              TextField(
                controller:
                    TextEditingController(text: items[index].description),
                onChanged: (value) {
                  // Update description
                  items[index].description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save changes
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: (items.isEmpty)
          ? Center(
              child: Text(
                  'Empty list please click Add button to add the list items'),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].name),
                  subtitle: Text(items[index].description),
                  onTap: () {
                    // Edit item when tapped
                    editItem(index);
                  },
                  onLongPress: () {
                    // Delete item when long pressed
                    deleteItem(index);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          addItem();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 78, 42, 194),
      ),
    );
  }
}
