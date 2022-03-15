import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';

/// The mock http client used in fake api service.
/// Responses are taken from https://restaurant-api.dicoding/dev
final mockHttpClient = MockClient((request) async {
  switch (request.url.path) {
    case "https://restaurant-api.dicoding.dev/list":
      return Response(
        jsonEncode({
          "error": false,
          "message": "success",
          "count": 20,
          "restaurants": [
            {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description":
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
              "pictureId": "14",
              "city": "Medan",
              "rating": 4.2
            },
            {
              "id": "s1knt6za9kkfw1e867",
              "name": "Kafe Kita",
              "description":
                  "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
              "pictureId": "25",
              "city": "Gorontalo",
              "rating": 4
            }
          ]
        }),
        200,
      );
    case "https://restaurant-api-dicoding.dev/detail":
      return Response(
        jsonEncode({
          "error": false,
          "message": "success",
          "restaurant": {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
            "city": "Medan",
            "address": "Jln. Pandeglang no 19",
            "pictureId": "14",
            "categories": [
              {
                "name": "Italia"
              },
              {
                "name": "Modern"
              }
            ],
            "menus": {
              "foods": [
                {
                  "name": "Paket rosemary"
                },
                {
                  "name": "Toastie salmon"
                }
              ],
              "drinks": [
                {
                  "name": "Es krim"
                },
                {
                  "name": "Sirup"
                }
              ]
            },
            "rating": 4.2,
            "customerReviews": [
              {
                "name": "Ahmad",
                "review": "Tidak rekomendasi untuk pelajar!",
                "date": "13 November 2019"
              }
            ]
          }
        }),
        200,
      );
    case "https://restaurant-api-dicoding.dev/search?q=test":
      return Response(
        jsonEncode({
          "error": false,
          "founded": 1,
          "restaurants": [
            {
              "id": "fnfn8mytkpmkfw1e867",
              "name": "Makan mudah",
              "description": "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
              "pictureId": "22",
              "city": "Medan",
              "rating": 3.7
            }
          ]
        }),
        200,
      );
    default:
      return Response(
        jsonEncode({"message": "Unknown endpoint"}),
        404,
      );
  }
});
