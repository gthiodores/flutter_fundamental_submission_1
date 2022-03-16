import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/di/dependency_provider.dart';
import 'package:restaurant_app/restaurant_list/restaurant_list_item.dart';
import 'package:restaurant_app/restaurant_list/widgets/restaurant_search_widget.dart';

import '../core/model/simple_restaurant.dart';

final searchTextProvider = StateProvider.autoDispose((ref) => "");

class RestaurantSearchScreen extends ConsumerWidget {
  static const route = "/search";

  const RestaurantSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchTextProvider);
    final searchStream = ref.watch(fetchSearchProvider(searchText));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Search"),
            centerTitle: false,
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: RestaurantSearchWidget(
              onSearch: (query) {
                ref.read(searchTextProvider.state).state = query;
              },
            ),
          ),
          searchStream.when(
            data: (data) {
              return data.when(
                success: (result) {
                  return _buildSearchResultWidget(result.data);
                },
                loading: (result) {
                  if (result.data == null) {
                    return _buildCenterLoadingView();
                  }
                  return result.data!.isEmpty
                      ? _buildCenterLoadingView()
                      : _buildSearchResultWidget(result.data!);
                },
                error: (result) {
                  if (result.data != null) {
                    return _buildSearchResultWidget(result.data!);
                  }
                  return _buildEmptyList();
                },
              );
            },
            error: (err, stack) => _buildErrorView(onRetry: () {
              ref.refresh(fetchSearchProvider(searchText));
            }),
            loading: _buildCenterLoadingView,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView({Function()? onRetry}) {
    return SliverToBoxAdapter(
      child: Center(
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
      ),
    );
  }

  Widget _buildCenterLoadingView() {
    return const SliverToBoxAdapter(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmptyList() {
    return const SliverFillRemaining(
      child: Center(
        child: Text("Tidak ditemukan restoran dengan nama tersebut."),
      ),
      hasScrollBody: false,
    );
  }

  Widget _buildSearchResultWidget(List<SimpleRestaurant> data) {
    return data.isEmpty
        ? _buildEmptyList()
        : SliverList(
            delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = data[index];
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RestaurantListItem(restaurant: item));
            },
            childCount: data.length,
          ));
  }
}
