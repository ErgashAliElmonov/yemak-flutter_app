import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/product_store.dart';
import 'package:yemak_app/store/restaurants_store.dart';
import 'package:yemak_app/ui/widgets/product_card.dart';

class Restaurant extends StatelessWidget {
  final String id;
  const Restaurant({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantsStore>(context, listen: false).setRestaurant(id);
      Provider.of<ProductStore>(context, listen: false).setProducts(id);
    });

    return Scaffold(
      body: Consumer2<RestaurantsStore, ProductStore>(
        builder: (context, RestaurantsStore value, ProductStore value2, child) {
          if (value.restaurant.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: Colors.amberAccent),
            );
          }
          var data = value.restaurant[0];
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  onPressed: () {
                    context.go("/");
                  },
                ),
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    data.image,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Image.asset(
                          "assets/images/error-images.png",
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
                title: Text(
                  data.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.amberAccent,
                centerTitle: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        value2.products.isNotEmpty
                            ? Column(
                              children: [
                                ...value2.products.map(
                                  (item) => Column(
                                    children: [
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27,
                                        ),
                                      ),
                                      ...item.products.map(
                                        (e) => ProductCard(data: e),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                            : Center(
                              child: CircularProgressIndicator(
                                color: Colors.amberAccent,
                              ),
                            ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
