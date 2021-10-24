import 'package:ecommerce_admin_tut/models/brands.dart';
import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopupButton extends StatefulWidget {
  final IconData iconData;
  final String label;
  final Color color;


  const PopupButton(
      {Key key,
      @required this.iconData,
      @required this.label,
      @required this.color})
      : super(key: key);

  @override
  _PopupButtonState createState() => _PopupButtonState();
}

class _PopupButtonState extends State<PopupButton> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _addressEditingController =
      TextEditingController();
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _distanceEditingController =
      TextEditingController();
  final TextEditingController _ratingEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TablesProvider tablesProvider = Provider.of<TablesProvider>(context);
    return ElevatedButton.icon(
      icon: Icon(widget.iconData),
      onPressed: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
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
                        if (_formKey.currentState.validate()) {
                          // Do something like updating SharedPreferences or User Settings etc.
                          print('Adding store');
                          BrandModel store = BrandModel(
                              address: _addressEditingController.text,
                              title: _titleEditingController.text,
                              distance:
                                  double.parse(_distanceEditingController.text),
                              rating:
                                  double.parse(_ratingEditingController.text));
                          tablesProvider.addStoreData(store);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                );
              },);
            },);
      },
      label: Text(widget.label + " Item"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(widget.color),
      ),
    );
  }
}
