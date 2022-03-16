import 'package:restaurant_app/core/domain/repository/restaurant_repository_interface.dart';
import 'package:restaurant_app/core/domain/use_case/remove_restaurant_from_favorite.dart';

class RemoveRestaurantFromFavoriteImpl extends RemoveRestaurantFromFavorite {
  final IRestaurantRepository _repository;

  RemoveRestaurantFromFavoriteImpl(this._repository);

  @override
  Future<void> execute(String id) async {
    await _repository.removeRestaurantFromFavorite(id);
  }
}
