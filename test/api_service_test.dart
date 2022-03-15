import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/core/data/api/api_service_interface.dart';

import 'fakes/fake_api_service.dart';

void main() {
  group('Api Service Testing', () {
    test('Get Restaurant List From Api Returns Restaurant List', () async {
      final IApiService apiService = FakeApiService();

      final restaurantLists = await apiService.getRestaurantList();

      expect(restaurantLists.restaurants.isNotEmpty, true);
    });

    test('Get Restaurant Detail From Api Returns Restaurant Detail', () async {
      final IApiService apiService = FakeApiService();

      final restaurantDetail = await apiService.getRestaurant("");

      expect(restaurantDetail.name, "Melting Pot");
    });

    test('Get Search Result From Api Returns Restaurant Search Result',
        () async {
      final IApiService apiService = FakeApiService();

      final restaurantSearch =
          await apiService.getRestaurantSearchResult("test");

      expect(restaurantSearch.restaurants.isNotEmpty, true);
    });

    test('Get Random Endpoint Returns Error', () async {
      final IApiService apiService = FakeApiService();

      final exception = apiService.getRestaurantSearchResult("query");

      expect(exception, throwsException);
    });
  });
}
