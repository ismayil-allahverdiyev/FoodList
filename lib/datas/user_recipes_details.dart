class UserRecipesDetails{
  String? type, title, image, uid, cuisine, description;
  String? calories, totalTime, protein, id;
  List? ingredients;
  int httpNumber = 0;


  UserRecipesDetails({this.title, this.type, this.image,
    this.cuisine, this.totalTime, this.protein, this.calories,
    this.ingredients, this.description, this.uid, this.id});

  checker(int number){
    httpNumber = number;
  }
}