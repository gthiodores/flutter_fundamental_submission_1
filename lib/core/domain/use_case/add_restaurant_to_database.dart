import 'package:restaurant_app/core/model/simple_restaurant.dart';

abstract class AddRestaurantToDatabase {
  Future<void> execute(SimpleRestaurant restaurant);
}
