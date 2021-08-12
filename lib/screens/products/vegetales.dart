import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:fresh_and_fruits/screens/products/reusableCard.dart';
import 'package:provider/provider.dart';

class Vegetable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Consumer<ProductManager>(
      builder: (context, itemData, child) {
        return LiveGrid.options(
          options: LiveOptions(
            delay: Duration(milliseconds: 100),
            showItemInterval: Duration(milliseconds: 100),
            showItemDuration: Duration(milliseconds: 200),
            visibleFraction: 0.05,
            reAnimateOnVisibility: false,
          ),
          itemBuilder: (context, index, animation) {
            itemData.isAddedToCart(itemData.vegetableData[index].itemEngName);
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  // Paste you Widget
                  child: ReusableProductCard(
                    imageUrl: itemData.vegetableData[index].imageUrl,
                    productEngName: itemData.vegetableData[index].itemEngName,
                    productUrduName: itemData.vegetableData[index].itemUrduName,
                    price: itemData.vegetableData[index].itemPrice,
                    shadowColor: (Colors.green[300])!,
                    buttonColor: (Colors.green[800])!,
                    rating: itemData.vegetableData[index].rating,
                    reviews: itemData.vegetableData[index].reviews,
                    isChecked: itemData.isChecked,
                  )),
            );
          },
          itemCount: itemData.vegetableData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.2,
          ),
        );
      },
    ));
  }
}
