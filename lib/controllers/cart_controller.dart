import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class CartController extends GetxController {
  var cartsData = <dynamic>[].obs;
  var productInfoData = <dynamic>[].obs;
  var isLoading = true.obs;
  var uid = FirebaseAuth.instance.currentUser!.uid;

  getData() async {
    isLoading.value = true;
    // carts data
    cartsData.value = [];
    productInfoData.value = [];
    var resp = await FirebaseFirestore.instance.collection("carts").doc(uid).get();
    if (resp.data()?["products"] != null) {
      cartsData.value = resp.data()!["products"] as List<dynamic>;
      //product info

      if (cartsData.length > 0) {
        List<dynamic> listProductId = cartsData.map((data) => data["productId"]).toList();
        var resp2 = await FirebaseFirestore.instance.collection("products").where(FieldPath.documentId, whereIn: listProductId).get();

        //sort resp2 based on carts data
        for (var i = 0; i < listProductId.length; i++) {
          resp2.docs.where(
            (doc) {
              if (doc.id == listProductId[i]) {
                productInfoData.add(doc.data());
              }
              return true;
            },
          ).toList();
        }
      }
    }

    isLoading.value = false;
  }

  removeItem(int index, int total, String from) async {
    //update ui
    if (total > 1 && from == "remove") {
      cartsData[index]["total"] -= 1;
      cartsData.refresh();
    } else {
      cartsData.removeAt(index);
      productInfoData.removeAt(index);
    }
    //update firebase
    if (cartsData.length == 0) {
      await FirebaseFirestore.instance.collection("carts").doc(uid).delete();
    } else {
      await FirebaseFirestore.instance.collection("carts").doc(uid).set({
        "products": [...cartsData]
      });
    }
  }

  addItem(int index, int total) async {
    cartsData[index]["total"] += 1;
    cartsData.refresh();
    await FirebaseFirestore.instance.collection("carts").doc(uid).set({
      "products": [...cartsData]
    });
  }
}