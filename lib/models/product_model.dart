import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final bool isRecommended;
  @HiveField(6)
  final bool isPopular;
  @HiveField(7)
  final String? description;

  const Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.imageUrl,
      required this.price,
      required this.isPopular,
      required this.isRecommended,
      this.description});

  static List<Product> products = [
    const Product(
      id: '0',
      name: 'Smoothie # 3',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1563282396-c299392870cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzB8fFNtb290aGllc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2,
      isRecommended: true,
      isPopular: true,
    ),
    const Product(
      id: '1',
      name: 'Soft Drink # 1',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1629203849820-fdd70d49c38e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHNvZnRkcmlua3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2,
      isRecommended: true,
      isPopular: false,
    ),
    const Product(
      id: '2',
      name: 'Soft Drink # 2',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1597357226129-7c35120cd556?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjR8fHNvZnRkcmlua3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2,
      isRecommended: false,
      isPopular: true,
    ),
    // name, category,imageUrl,price, isPopular, isRecommended
    const Product(
      id: '3',
      name: 'Soft Drink # 3',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1652433716968-d058e09bd22b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fHNvZnRkcmlua3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2,
      isRecommended: true,
      isPopular: true,
    ),
    const Product(
      id: '4',
      name: 'Soft Drink # 4',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1632818924360-68d4994cfdb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZmFudGF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      price: 2,
      isRecommended: false,
      isPopular: true,
    ),
    const Product(
      id: '5',
      name: 'Smoothie # 1',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1557799852-67fdf88b1b01?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fFNtb290aGllc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2,
      isRecommended: true,
      isPopular: false,
    ),
    // name, category,imageUrl,price, isPopular, isRecommended

    const Product(
      id: '6',
      name: 'Smoothie # 2',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1532301791573-4e6ce86a085f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzN8fFNtb290aGllc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      price: 2,
      isRecommended: false,
      isPopular: false,
    ),
  ];
  @override
  List<Object?> props() {
    return [
      id,
      name,
      category,
      imageUrl,
      price,
      isPopular,
      isRecommended,
      description
    ];
  }

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
        id: snap.id,
        name: snap['name'],
        category: snap['category'],
        imageUrl: snap['imageUrl'],
        price: (snap['price'] as num).toDouble(),
        isPopular: snap['isPopular'],
        isRecommended: snap['isRecommended'],
        description: snap['description']);

    return product;
  }
}
