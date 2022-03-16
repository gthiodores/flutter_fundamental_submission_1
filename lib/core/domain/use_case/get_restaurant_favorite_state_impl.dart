import 'package:restaurant_app/core/domain/use_case/get_restaurant_favorite_state.dart';
import 'package:restaurant_app/core/domain/repository/restaurant_repository_interface.dart';

class GetRestaurantFavoriteStateImpl extends GetRestaurantFavoriteState {
  final IRestaurantRepository _repository;

  GetRestaurantFavoriteStateImpl(this._repository);

  @override
  Future<bool> execute(String id) async {
    return await _repository.isRestaurantFavorite(id);
  }
}
