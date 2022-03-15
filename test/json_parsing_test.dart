import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/core/model/category.dart';
import 'package:restaurant_app/core/model/customer_review.dart';
import 'package:restaurant_app/core/model/menu.dart';
import 'package:restaurant_app/core/model/restaurant.dart';
import 'package:restaurant_app/core/model/restaurant_detail.dart';
import 'package:restaurant_app/core/model/restaurant_list.dart';
import 'package:restaurant_app/core/model/restaurant_search.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';

// This test file will test parsing for the entire
void main() {
  test('Get List Restaurant Parsing Returns Simple Restaurant List', () {
    // Fake api response taken from https://restaurant-api.dicoding.dev/
    const apiResponse =
        '{"error":false,"message":"success","count":20,"restaurants":[{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...","pictureId":"14","city":"Medan","rating":4.2},{"id":"s1knt6za9kkfw1e867","name":"Kafe Kita","description":"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...","pictureId":"25","city":"Gorontalo","rating":4}]}';
    final RestaurantList restaurantList =
        RestaurantList.fromRawJson(apiResponse);

    // Test out all the fields in restaurant list
    expect(restaurantList.count, 20);
    expect(restaurantList.message, 'success');
    expect(restaurantList.error, false);
    expect(restaurantList.restaurants.isNotEmpty, true);
    expect(restaurantList.restaurants.length, 2);

    // Prep the restaurant objects for testing
    final SimpleRestaurant firstRestaurant = restaurantList.restaurants[0];
    final SimpleRestaurant secondRestaurant = restaurantList.restaurants[1];

    // Test out all the fields in firstRestaurant
    expect(firstRestaurant.name, "Melting Pot");
    expect(firstRestaurant.id, "rqdv5juczeskfw1e867");
    expect(firstRestaurant.pictureId, "14");
    expect(firstRestaurant.city, "Medan");
    expect(firstRestaurant.rating, 4.2);
    expect(firstRestaurant.description,
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...");

    // Test out all the fields in secondRestaurant
    expect(secondRestaurant.name, "Kafe Kita");
    expect(secondRestaurant.id, "s1knt6za9kkfw1e867");
    expect(secondRestaurant.pictureId, "25");
    expect(secondRestaurant.city, "Gorontalo");
    expect(secondRestaurant.rating, 4);
    expect(secondRestaurant.description,
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...");
  });

  test('Get Restaurant Detail Parsing Returns Restaurant', () {
    // Fake api response taken from https://restaurant-api.dicoding.dev/
    const apiResponse =
        '{"error":false,"message":"success","restaurant":{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...","city":"Medan","address":"Jln. Pandeglang no 19","pictureId":"14","categories":[{"name":"Italia"},{"name":"Modern"}],"menus":{"foods":[{"name":"Paket rosemary"},{"name":"Toastie salmon"}],"drinks":[{"name":"Es krim"},{"name":"Sirup"}]},"rating":4.2,"customerReviews":[{"name":"Ahmad","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"}]}}';
    final RestaurantDetail restaurantDetail =
        RestaurantDetail.fromRawJson(apiResponse);
    final Restaurant restaurant = restaurantDetail.restaurant;
    final List<Category> categories = restaurant.categories;
    final Menu menus = restaurant.menus;
    final List<Category> foods = menus.foods;
    final List<Category> drinks = menus.drinks;
    final List<CustomerReview> reviews = restaurant.customerReviews;

    // Test out the fields in restaurantDetail
    expect(restaurantDetail.message, "success");
    expect(restaurantDetail.error, false);

    // Test out the fields in restaurant
    expect(restaurant.name, "Melting Pot");
    expect(restaurant.id, "rqdv5juczeskfw1e867");
    expect(restaurant.description, "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...");
    expect(restaurant.city, "Medan");
    expect(restaurant.address, "Jln. Pandeglang no 19");
    expect(restaurant.pictureId, "14");
    expect(restaurant.rating, 4.2);

    // Test out the menus
    expect(foods.length, 2);
    expect(foods[0].name, "Paket rosemary");
    expect(foods[1].name, "Toastie salmon");

    expect(drinks.length, 2);
    expect(drinks[0].name, "Es krim");
    expect(drinks[1].name, "Sirup");

    // Test out the categories
    expect(categories.length, 2);
    expect(categories[0].name, "Italia");
    expect(categories[1].name, "Modern");

    // Test out the reviews
    expect(reviews.length, 1);
    final CustomerReview review = reviews[0];
    expect(review.name, "Ahmad");
    expect(review.review, "Tidak rekomendasi untuk pelajar!");
    expect(review.date, "13 November 2019");
  });

  test('Search Restaurant Parsing Returns Simple Restaurant List', () {
    // Fake api response taken from https://restaurant-api.dicoding.dev/
    const apiResponse =
        '{"error":false,"founded":1,"restaurants":[{"id":"fnfn8mytkpmkfw1e867","name":"Makan mudah","description":"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...","pictureId":"22","city":"Medan","rating":3.7}]}';
    final RestaurantSearch searchResult = RestaurantSearch.fromRawJson(apiResponse);

    // Test out the search result fields.
    expect(searchResult.restaurants.length, 1);
    expect(searchResult.error, false);
    expect(searchResult.founded, 1);

    // Test out the restaurant fields.
    final SimpleRestaurant restaurant = searchResult.restaurants[0];
    expect(restaurant.id, "fnfn8mytkpmkfw1e867");
    expect(restaurant.name, "Makan mudah");
    expect(restaurant.description, "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...");
    expect(restaurant.rating, 3.7);
    expect(restaurant.pictureId, "22");
    expect(restaurant.city, "Medan");
  });
}
