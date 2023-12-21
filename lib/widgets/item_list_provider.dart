import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warframemarket_app/model/item_loader.dart';

class ItemListProvider extends StatelessWidget {
  const ItemListProvider({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadGenericSet("wisp_prime"),
      builder: (BuildContext context, AsyncSnapshot<GenericSetData> snapshot) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        return Provider.value(value: snapshot.data, child: child);
      },
    );
  }
}
