import 'package:flutter/material.dart';

class RestaurantSearchWidget extends StatefulWidget {
  final Function(String)? onSearch;

  const RestaurantSearchWidget({
    Key? key,
    this.onSearch,
  }) : super(key: key);

  @override
  State<RestaurantSearchWidget> createState() => _RestaurantSearchWidgetState();
}

class _RestaurantSearchWidgetState extends State<RestaurantSearchWidget> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = "";
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
            ),
          ),
          IconButton(
            onPressed: () {
              widget.onSearch?.call(_searchController.text);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
