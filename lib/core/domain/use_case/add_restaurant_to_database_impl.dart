import 'package:restaurant_app/core/domain/repository/restaurant_repository_interface.dart';
import 'package:restaurant_app/core/domain/use_case/add_restaurant_to_database.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';

class AddRestaurantToDatabaseImpl extends AddRestaurantToDatabase {
  final IRestaurantRepository _repository;

  AddRestaurantToDatabaseImpl(this._repository);

  @override
  Future<void> execute(SimpleRestaurant restaurant) async {
    await _repository.addRestaurantToDatabase(restaurant);
  }
}
