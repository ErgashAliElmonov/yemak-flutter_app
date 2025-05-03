import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/product_store.dart';
import 'package:yemak_app/store/search_store.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    void _showBottomSheet(BuildContext context, data) {
      Provider.of<ProductStore>(context, listen: false).setCount(1);
      Provider.of<ProductStore>(context, listen: false).setPrice(data.price);
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ), // Yuqori burchaklarni yumaloqlash
        ),
        builder:
            (context) => Consumer<ProductStore>(
              builder:
                  (context, value, child) => Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.all(16),
                    color: const Color.fromARGB(34, 255, 255, 255),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            data.photo!,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  height: 150,
                                  width: double.infinity,
                                  color: Colors.grey[300], // Gray fon
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          data.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(data.description),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Miqdor",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${value.count} x ${value.price} UZS",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      side: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    onPressed: () {
                                      value.setCount(value.count - 1);
                                    },
                                    child: Icon(Icons.remove),
                                  ),
                                  SizedBox(width: 10),

                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                      left: 10,
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 2,
                                      ),
                                    ),
                                    child: Text("${value.count}"),
                                  ),
                                  SizedBox(width: 10),

                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      side: BorderSide(
                                        color: Colors.amberAccent,
                                        width: 2,
                                      ),
                                    ),
                                    onPressed: () {
                                      value.setCount(value.count + 1);
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16),
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.amberAccent,
                            ),
                            child: Text("Qo'shish (${value.price} UZS)"),
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
      );
    }

    return Consumer<SearchStore>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: Colors.amberAccent),
          );
        } else if (value.restaurants.isNotEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Muassasalar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.restaurants.length,
                  itemBuilder: (context, index) {
                    var data = value.restaurants[index];
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              child: Image.network(
                                data?.image,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        Icon(Icons.error),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(data?.name),
                          ],
                        ),
                      ),
                      onTap: () {
                        context.go("/restaurant/${data?.id}");
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Mahsulotlar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.products.length,
                  itemBuilder: (context, index) {
                    var data = value.products[index];
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              child: Image.network(
                                data?.photo,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        Icon(Icons.error),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(data?.name),
                          ],
                        ),
                      ),
                      onTap: () {
                        _showBottomSheet(context, data);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }

        return Text("Biror mahsulot yoki musasa nomini qidiring");
      },
    );
  }
}
