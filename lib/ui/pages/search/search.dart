import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/search_store.dart';
import 'package:yemak_app/ui/widgets/search_container.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Qidiruv")),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                context.read<SearchStore>().setRestaurants(value);
              },
              decoration: InputDecoration(
                hintText: "Qidiruv",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.amber,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),

            SearchContainer()
          ],
        ),
      ),
    );
  }
}
