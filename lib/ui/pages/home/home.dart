import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/category_store.dart';
import 'package:yemak_app/store/restaurants_store.dart';
import 'package:yemak_app/ui/widgets/category_item.dart';
import 'package:yemak_app/ui/widgets/restaurant_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryStore>().addCategory();
      context.read<RestaurantsStore>().setRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              "assets/icons/logo_black.svg",
              width: 200,
              height: 30,
            ),
            InkWell(
              onTap: () {
                context.go("/maps");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Text(
                          "Yetkazib berish manzili",
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 113, 118, 121),
                          ),
                        ),
                        Icon(
                          Icons.location_on_outlined,
                          color: const Color.fromARGB(255, 113, 118, 121),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      "Ko'rsatilgan manzil",
                      style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    context
                        .watch<CategoryStore>()
                        .category
                        .map((e) => CategoryItem(category: e))
                        .toList(),
              ),
            ),
          ),
          Expanded(
            child: Consumer<RestaurantsStore>(
              builder: (context, restaurantsStore, child) {
                if (restaurantsStore.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.amberAccent),
                  );
                }
                if (restaurantsStore.restaurants.isEmpty) {
                  return Center(child: Text("Restoranlar yo'q!"));
                }

                return ListView.builder(
                  itemCount: restaurantsStore.restaurants.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.go(
                          "/restaurant/${restaurantsStore.restaurants[index].id}",
                        );
                      },
                      child: RestaurantCard(
                        restaurant: restaurantsStore.restaurants[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
