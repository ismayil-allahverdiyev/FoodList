class details{
  String? type, label, url, image, source, mediumImage, largeImage, uri, description;
  int? calories, totalTime, protein;
  List? dietLabels, ingredients, healthLabels, cuisine, digest;
  Map? totalDaily;
  int httpNumber = 0;


  details({this.label, this.type , this.url, this.image, this.source,
    this.cuisine, this.totalTime, this.protein, this.calories,
    this.dietLabels, this.healthLabels, this.ingredients, this.mediumImage,
    this.largeImage, this.uri, this.description, this.digest, this.totalDaily});

  checker(int number){
    httpNumber = number;
  }
}