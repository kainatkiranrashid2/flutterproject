import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;

  const Category({
    required this.name,
    required this.imageUrl,
  });

  static List<Category> categories = [
    const Category(
      name: 'Soft Drink',
      imageUrl:
          'https://images.unsplash.com/photo-1533007716222-4b465613a984?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c29mdCUyMGRyaW5rfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    ),
    const Category(
      name: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1638176311291-36b0eacc6b08?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHNtb290aGllc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    ),
    const Category(
      name: 'Water',
      imageUrl:
          'https://images.unsplash.com/photo-1616118132534-381148898bb4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHdhdGVyJTIwYm90dGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60',
    ),
  ];

  @override
  List<Object?> props() {
    return [name, imageUrl];
  }

  static Category fromSnapshot(DocumentSnapshot snap) {
    Category category =
        Category(name: snap['name'], imageUrl: snap['imageUrl']);

    return category;
  }
}
