import 'package:flutter/material.dart';
import 'package:untitled2/datas/details.dart';

class IngredientsList extends StatefulWidget {

  details?  detail;
  List<Widget> ingredientsWidgets = [];

  IngredientsList(this.detail, {Key? key}) : super(key: key);

  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {


  List<Widget> ingredientsWidgets = [];
  List ingredits = [];
  getIngredients() {
    for (var i = 0; i < widget.detail!.ingredients!.length; i++) {
      String label = widget.detail!.ingredients![i]["text"];
      label.contains("(optional, see note above)")? label = label.replaceRange(label.indexOf("(optional, see note above)"), label.length, "") : label = label;
      label.contains("(see note above)")? label = label.replaceRange(label.indexOf("(see note above)"), label.length, "") : label = label;
      int checker = 0;
      Color color = Colors.grey;
      widget.detail!.ingredients![i]["image"]==null ? checker = 1 : checker = 0;
      ingredientsWidgets.add(
        ListTile(
          title: Text(label, style: const TextStyle(fontSize: 20),),
          leading: checker == 0 ? ClipRRect(borderRadius: BorderRadius.circular(8.0), child: Image.network(widget.detail!.ingredients![i]["image"],)) : Container(
            width: 55,
            height: 55,
            child: const Center(child: Icon(Icons.restaurant)),
            decoration: BoxDecoration(
                color:Colors.grey[200],
                borderRadius: BorderRadius.circular(5)
            ),
          ),
          subtitle: const Text(""),
        )
        // Image.network(widget.detail!.ingredients![i]["image"], width: 20, height: 20,)
      );
      ingredientsWidgets.add(
        Divider(thickness: 1,)
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getIngredients();
  }
  @override
  Widget build(BuildContext context) {

    print("iam callsed");

    return MediaQuery(
      data: const MediaQueryData(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 2)
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
              children: ingredientsWidgets
          ),
        ),
      ),
    );
  }
}
