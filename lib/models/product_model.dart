import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;

  const Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isPopular,
    required this.isRecommended,
  });

  static List<Product> products = [
    const Product(
      name: 'Soft Drink # 1',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1629203849820-fdd70d49c38e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHNvZnRkcmlua3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2.99,
      isRecommended: true,
      isPopular: false,
    ),
    const Product(
      name: 'Soft Drink # 2',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1597357226129-7c35120cd556?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjR8fHNvZnRkcmlua3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2.99,
      isRecommended: false,
      isPopular: true,
    ),
    const Product(
      name: 'Soft Drink # 3',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1652433716968-d058e09bd22b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fHNvZnRkcmlua3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2.99,
      isRecommended: true,
      isPopular: true,
    ),
    const Product(
      name: 'Soft Drink # 4',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1632818924360-68d4994cfdb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZmFudGF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      price: 2.99,
      isRecommended: false,
      isPopular: true,
    ),
    const Product(
      name: 'Smoothie # 1',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1557799852-67fdf88b1b01?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fFNtb290aGllc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2.99,
      isRecommended: true,
      isPopular: false,
    ),
    const Product(
      name: 'Smoothie # 2',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1532301791573-4e6ce86a085f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzN8fFNtb290aGllc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2.99,
      isRecommended: false,
      isPopular: false,
    ),
    const Product(
      name: 'Smoothie # 3',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1563282396-c299392870cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzB8fFNtb290aGllc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2.99,
      isRecommended: true,
      isPopular: true,
    ),
  ];
  @override
  List<Object?> props() {
    return [
      name,
      category,
      imageUrl,
      price,
      isPopular,
      isRecommended,
    ];
  }

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      name: snap['name'],
      category: snap['category'],
      imageUrl: snap['imageUrl'],
      price: snap['price'],
      isPopular: snap['isPopular'],
      isRecommended: snap['isRecommended'],
    );

    return product;
  }
}
