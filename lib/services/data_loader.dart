import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api.dart';

class DataLoader {
  Api apiInstance = Api();

  Future<void> fetchAndStoreData() async {
    var colorData = await apiInstance.getColors();
    var categoryData = await apiInstance.getCategories();
    var imprimanteData = await apiInstance.getImprimante();

    Map<String, dynamic> couleur = {
      'colors': colorData,
    };
    Map<String, dynamic> categorie = {
      'categories': categoryData,
    };

    Map<String, dynamic> imprimantes = {
      'imprimantes': imprimanteData,
    };

    String couleurs = jsonEncode(couleur);
    String categories = jsonEncode(categorie);

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('couleur', couleurs);
    localStorage.setString('categorie', categories);
    localStorage.setString('imprimantes', jsonEncode(imprimantes));
    print(imprimanteData);
  }

  Future<List<dynamic>> getStoredColors() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? colorsJson = localStorage.getString('couleur');
    if (colorsJson != null) {
      Map<String, dynamic> colorsMap = jsonDecode(colorsJson);
      return colorsMap['colors'];
    }
    return [];
  }

  Future<List<dynamic>> getStoredCategories() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? categoriesJson = localStorage.getString('categorie');
    if (categoriesJson != null) {
      Map<String, dynamic> categoriesMap = jsonDecode(categoriesJson);
      return categoriesMap['categories'];
    }
    return [];
  }

  Future<List<dynamic>> getStoredImprimantes() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? imprimantesJson = localStorage.getString('imprimantes');
    if (imprimantesJson != null) {
      Map<String, dynamic> imprimantesMap = jsonDecode(imprimantesJson);
      return imprimantesMap['imprimantes'];
    }
    return [];
  }
}
