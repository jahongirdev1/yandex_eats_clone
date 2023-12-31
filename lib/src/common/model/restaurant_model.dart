// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'product_model.dart';

class Restaurant {
    Restaurant({
      required this.name,
      required this.restaurantImage,
      required this.restaurantType,
      required this.deliveryTime,
      required this.deliveryPrice,
      required this.rate,
      required this.products,
    });

    String name;
    String restaurantImage;
    String restaurantType;
    String deliveryTime;
    String deliveryPrice;
    String rate;
    List<RestaurantProducts> products;
    
    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
        other is Restaurant &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            restaurantImage == other.restaurantImage &&
            restaurantType == other.restaurantType &&
            deliveryTime == other.deliveryTime &&
            deliveryPrice == other.deliveryPrice &&
            rate == other.rate &&
            products == other.products;

    @override
    int get hashCode =>
        name.hashCode ^
        restaurantType.hashCode ^
        restaurantImage.hashCode ^
        deliveryTime.hashCode ^
        deliveryPrice.hashCode ^
        rate.hashCode ^
        products.hashCode;

    @override
    String toString() {
      return 'Restaurant{name: $name,'
          ' restaurantType: $restaurantType,'
          ' restaurantImage: $restaurantImage,'
          ' deliveryTime: $deliveryTime,'
          ' deliveryPrice: $deliveryPrice,'
          ' rate: $rate, products: $products}';
    }

  Restaurant copyWith({
    String? name,
    String? restaurantImage,
    String? restaurantType,
    String? deliveryTime,
    String? deliveryPrice,
    String? rate,
    List<RestaurantProducts>? products,
  }) {
    return Restaurant(
      name: name ?? this.name,
      restaurantImage: restaurantImage ?? this.restaurantImage,
      restaurantType: restaurantType ?? this.restaurantType,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
      rate: rate ?? this.rate,
      products: products ?? this.products,
    );
  }
  }
