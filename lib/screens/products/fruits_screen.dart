import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:fresh_and_fruits/screens/products/reusableCard.dart';
import 'package:provider/provider.dart';
import 'package:auto_animated/auto_animated.dart';

class Fruits extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<ProductManager>(
          builder: (context, itemData, child){
            return LiveGrid.options(
                options: LiveOptions(
                  delay: Duration(milliseconds: 100),
                  showItemInterval: Duration(milliseconds: 100),
                  showItemDuration: Duration(milliseconds: 200),
                  visibleFraction: 0.05,
                  reAnimateOnVisibility: false,
                ),
                itemBuilder: (context, index, animation){
                  itemData.isAddedToCart(itemData.fruitData[index].itemEngName);
                    return  FadeTransition(
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
                            imageUrl: itemData.fruitData[index].imageUrl,
                            productEngName: itemData.fruitData[index].itemEngName,
                            productUrduName: itemData.fruitData[index].itemUrduName,
                            price: itemData.fruitData[index].itemPrice,
                            shadowColor: (Colors.red[300])!,
                            buttonColor: (Colors.red[800])!,
                            rating: itemData.fruitData[index].rating,
                            reviews: itemData.fruitData[index].reviews,
                            isChecked: itemData.isChecked,
                          )
                      ),
                    );

                } ,
                itemCount: itemData.fruitData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.2,
                ),
              );
          },
        ));
  }
}
