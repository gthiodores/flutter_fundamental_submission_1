import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/core/model/category.dart';
import 'package:restaurant_app/core/model/customer_review.dart';
import 'package:restaurant_app/core/model/menu.dart';
import 'package:restaurant_app/core/model/restaurant.dart';

import 'fakes/fake_restaurant_repository.dart';

void main() async {
  test('Add to favorites return is favorite', () async {
    final fakeRestaurant = Restaurant(
      id: "testId",
      name: "Test resto",
      description: "description",
      city: "city",
      address: "address",
      pictureId: "pictureId",
      categories: [],
      menus: Menu(foods: [], drinks: []),
      rating: 2,
      customerReviews: [],
    );

    final fakeRepo = FakeRestaurantRepository();
    fakeRepo.addRestaurantToFavorite(fakeRestaurant);

    final favorite = await fakeRepo.isRestaurantFavorite(fakeRestaurant.id);
    expect(favorite, true);
  });

  test('Add to favorites return is in favorites', () async {
    final fakeRestaurant = Restaurant(
      id: "testId",
      name: "Test resto",
      description: "description",
      city: "city",
      address: "address",
      pictureId: "pictureId",
      categories: [],
      menus: Menu(foods: [], drinks: []),
      rating: 2,
      customerReviews: [],
    );

    final fakeRepo = FakeRestaurantRepository();
    fakeRepo.addRestaurantToFavorite(fakeRestaurant);

    final favoriteList = await fakeRepo.getFavoriteRestaurantList();
    expect(favoriteList.first.id, "testId");
  });

  test('Remove from favorites return empty list', () async {
    final fakeRestaurant = Restaurant(
      id: "testId",
      name: "Test resto",
      description: "description",
      city: "city",
      address: "address",
      pictureId: "pictureId",
      categories: [],
      menus: Menu(foods: [], drinks: []),
      rating: 2,
      customerReviews: [],
    );

    final fakeRepo = FakeRestaurantRepository();
    fakeRepo.addRestaurantToFavorite(fakeRestaurant);
    fakeRepo.removeRestaurantFromFavorite("testId");

    final favoriteList = await fakeRepo.getFavoriteRestaurantList();
    expect(favoriteList.isEmpty, true);
  });

  test('Get restaurant detail return detail', () async {
    final fakeRestaurant = Restaurant(
      id: "rqdv5juczeskfw1e867",
      name: "Melting Pot",
      description:
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
      city: "Medan",
      address: "Jln. Pandeglang no 19",
      pictureId: "14",
      categories: [
        Category(name: "Italia"),
        Category(name: "Modern"),
      ],
      menus: Menu(
        foods: [
          Category(name: "Pake rosemary"),
          Category(name: "Toastie salmon"),
        ],
        drinks: [
          Category(name: "Es krim"),
          Category(name: "Sirup"),
        ],
      ),
      rating: 4.2,
      customerReviews: [
        CustomerReview(
          name: "Ahmad",
          review: "Tidak rekomendasi untuk pelajar!",
          date: "13 November 2019",
        ),
      ],
    );

    final fakeRepo = FakeRestaurantRepository();
    final restaurant = await fakeRepo.getRestaurant("");

    expect(restaurant.id, fakeRestaurant.id);
  });

  test('Get restaurant list returns 2 items', () async {
    final fakeRepo = FakeRestaurantRepository();

    final restaurants = await fakeRepo.getRestaurantList();

    expect(restaurants.length, 2);
  });
}
