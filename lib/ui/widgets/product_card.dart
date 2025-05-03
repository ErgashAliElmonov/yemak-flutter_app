import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/product_store.dart';

class ProductCard extends StatelessWidget {
  final data;
  const ProductCard({required this.data, super.key});

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

    return InkWell(
      onTap: () => _showBottomSheet(context, data),
      child: Container(
        width: 300,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                data.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 12),
              child: Text(data.price.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
