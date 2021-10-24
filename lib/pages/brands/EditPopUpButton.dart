import 'package:ecommerce_admin_tut/models/brands.dart';
import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPopupButton extends StatefulWidget {
  final IconData iconData;
  final String label;
  final Color color;

  const EditPopupButton(
      {Key key,
      @required this.iconData,
      @required this.label,
      @required this.color})
      : super(key: key);

  @override
  _PopupButtonState createState() => _PopupButtonState();
}

class _PopupButtonState extends State<EditPopupButton> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _addressEditingController;
  TextEditingController _titleEditingController;
  TextEditingController _distanceEditingController;
  TextEditingController _ratingEditingController;

  @override
  Widget build(BuildContext context) {
    final TablesProvider tablesProvider = Provider.of<TablesProvider>(context);
    _addressEditingController = TextEditingController(
        text: tablesProvider.selecteds.length != 1
            ? ''
            : tablesProvider.selecteds[0]['address']);
    _titleEditingController = TextEditingController(
        text: tablesProvider.selecteds.length != 1
            ? ''
            : tablesProvider.selecteds[0]['title']);
    _distanceEditingController = TextEditingController(
        text: tablesProvider.selecteds.length != 1
            ? ''
            : tablesProvider.selecteds[0]['distance'].toString());
    _ratingEditingController = TextEditingController(
        text: tablesProvider.selecteds.length != 1
            ? ''
            : tablesProvider.selecteds[0]['rating'].toString());

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
                                    controller: _addressEditingController,
                                    validator: (value) {
                                      return value.isNotEmpty
                                          ? null
                                          : "Enter any text";
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Address',
                                      hintText: "Please Enter Address",
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _distanceEditingController,
                                    validator: (value) {
                                      return value.isNotEmpty
                                          ? null
                                          : "Enter any text";
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Distance',
                                      hintText: "Please Enter Distance",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _ratingEditingController,
                                    validator: (value) {
                                      return value.isNotEmpty
                                          ? null
                                          : "Enter any text";
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Rating',
                                      hintText: "Please Enter Rating",
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
                                print('Updating store');
                                BrandModel store = BrandModel(
                                    address: _addressEditingController.text,
                                    title: _titleEditingController.text,
                                    distance: double.parse(
                                        _distanceEditingController.text),
                                    rating: double.parse(
                                        _ratingEditingController.text));
                                tablesProvider.updateStoreDate(
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
