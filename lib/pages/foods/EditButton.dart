import 'package:ecommerce_admin_tut/models/brands.dart';
import 'package:ecommerce_admin_tut/models/foods.dart';
import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditFoodButton extends StatefulWidget {
  final IconData iconData;
  final String label;
  final Color color;

  const EditFoodButton(
      {Key key,
        @required this.iconData,
        @required this.label,
        @required this.color})
      : super(key: key);

  @override
  _PopupButtonState createState() => _PopupButtonState();
}

class _PopupButtonState extends State<EditFoodButton> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _categoryEditingController;
  TextEditingController _descriptionEditingController;
  TextEditingController _imageURLEditingController;
  TextEditingController _priceEditingController;
  TextEditingController _titleEditingController;

  @override
  Widget build(BuildContext context) {
    final TablesProvider tablesProvider = Provider.of<TablesProvider>(context);
    _categoryEditingController = TextEditingController(
        text: tablesProvider.selecteds.length != 1
            ? ''
            : tablesProvider.selecteds[0]['categories'][0].toString());
    _descriptionEditingController = TextEditingController(
        text: tablesProvider.selecteds.length != 1
            ? ''
            : tablesProvider.selecteds[0]['description']);
    _imageURLEditingController = TextEditingController(
        text: tablesProvider.selecteds.length != 1
            ? ''
            : tablesProvider.selecteds[0]['imageURL']);
    _priceEditingController = TextEditingController(
        text: tablesProvider.selecteds.length != 1
            ? ''
            : tablesProvider.selecteds[0]['price'].toString());
    _titleEditingController = TextEditingController(
        text: tablesProvider.selecteds.length != 1
            ? ''
            : tablesProvider.selecteds[0]['title']);

    return ElevatedButton.icon(
      icon: Icon(widget.iconData),
      onPressed: () async {
        tablesProvider.selecteds.length != 1
            ? null
            : await showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  content: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _categoryEditingController,
                              validator: (value) {
                                return value.isNotEmpty
                                    ? null
                                    : "Enter any text";
                              },
                              decoration: InputDecoration(
                                labelText: 'Category',
                                hintText: "Please Enter Category",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _descriptionEditingController,
                              validator: (value) {
                                return value.isNotEmpty
                                    ? null
                                    : "Enter any text";
                              },
                              decoration: InputDecoration(
                                labelText: 'Description',
                                hintText: "Please Enter Description",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _imageURLEditingController,
                              validator: (value) {
                                return value.isNotEmpty
                                    ? null
                                    : "Enter any text";
                              },
                              decoration: InputDecoration(
                                labelText: 'Image Link',
                                hintText: "Please Enter Image Link",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _priceEditingController,
                              validator: (value) {
                                return value.isNotEmpty
                                    ? null
                                    : "Enter any text";
                              },
                              decoration: InputDecoration(
                                labelText: 'Price',
                                hintText: "Please Enter Price",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _titleEditingController,
                              validator: (value) {
                                return value.isNotEmpty
                                    ? null
                                    : "Enter any text";
                              },
                              decoration: InputDecoration(
                                labelText: 'Title',
                                hintText: "Please Enter Title",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  title: Text(widget.label + " Item"),
                  actions: <Widget>[
                    TextButton(
                      child: Text('DONE'),
                      onPressed: () {
                        print(tablesProvider.selecteds);
                        if (_formKey.currentState.validate()) {
                          // Do something like updating SharedPreferences or User Settings etc.
                          print('Updating Food');
                          FoodModel store = FoodModel(
                            categories: [_categoryEditingController.text],
                            description: _descriptionEditingController.text,
                            imageUrl: _imageURLEditingController.text,
                            price: double.parse(_priceEditingController.text),
                            title: _titleEditingController.text,
                            storeId: tablesProvider.storeId,
                          );
                          tablesProvider.updateFoodData(
                              tablesProvider.selecteds[0]['id'], store);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      label: Text(widget.label + " Item"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(widget.color),
      ),
    );
  }
}
