import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/di/dependency_provider.dart';
import 'package:restaurant_app/core/domain/use_case/add_restaurant_to_database.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';
import 'package:restaurant_app/core/util/notification_helper.dart';
import 'package:restaurant_app/restaurant_detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/restaurant_list/restaurant_favorite_screen.dart';
import 'package:restaurant_app/restaurant_list/restaurant_list_item.dart';
import 'package:restaurant_app/restaurant_list/restaurant_search_screen.dart';
import 'package:restaurant_app/restaurant_settings/restaurant_settings_screen.dart';

class RestaurantListScreen extends ConsumerStatefulWidget {
  static const route = '/list_restaurant';

  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => RestaurantListState();
}

class RestaurantListState extends ConsumerState<RestaurantListScreen> {
  final notificationHelper = NotificationHelper();

  void _onDataReceived(
      List<SimpleRestaurant> data, AddRestaurantToDatabase addToDbUseCase) {
    data.forEach((element) async {
      await addToDbUseCase.execute(element);
    });
  }

  @override
  void initState() {
    super.initState();
    notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailScreen.route);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _optionsMenuItems = ["Favorites", "Settings"];
    final _restaurantList = ref.watch(fetchRestaurantProvider);
    final _addToDb = ref.watch(addRestaurantToDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RestaurantSearchScreen.route);
              },
              icon: const Icon(Icons.search)),
          PopupMenuButton(
            itemBuilder: ((context) {
              return _optionsMenuItems
                  .map((item) => PopupMenuItem(child: Text(item), value: item))
                  .toList();
            }),
            onSelected: (option) {
              if (option == "Favorites") {
                Navigator.pushNamed(context, RestaurantFavoritesScreen.route);
              } else {
                Navigator.pushNamed(context, RestaurantSettingsScreen.route);
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(fetchRestaurantProvider);
        },
        child: _restaurantList.when(
          data: (data) {
            _onDataReceived(data, _addToDb);
            return _buildListItemViews(restaurants: data);
          },
          error: (err, stack) => _buildErrorView(onRetry: () async {
            ref.refresh(fetchRestaurantProvider);
          }),
          loading: () => _buildCenterLoadingView(),
        ),
      ),
    );
  }

  Widget _buildCenterLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorView({Function()? onRetry}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Fetching data failed!"),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }

  Widget _buildListItemViews({
    required List<SimpleRestaurant> restaurants,
  }) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final item = restaurants[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RestaurantListItem(restaurant: item),
        );
      },
    );
  }
}
