import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:fresh_and_fruits/screens/products/reusableCard.dart';
import 'package:provider/provider.dart';

class SearchProducts extends StatelessWidget {
  final Color buttonColor;
  final Color shadowColor;
  SearchProducts({required this.shadowColor,required this.buttonColor});
  @override
  Widget build(BuildContext context) {
    return Container(child: Consumer<ProductManager>(
      builder: (context, itemData, child) {
        if(itemData.searchProducts.isEmpty){
          return Center(child: Text('No Items found!'));
        }
       else{
          return LiveGrid.options(
            options: LiveOptions(
              delay: Duration(milliseconds: 100),
              showItemInterval: Duration(milliseconds: 100),
              showItemDuration: Duration(milliseconds: 200),
              visibleFraction: 0.05,
              reAnimateOnVisibility: false,
            ),
            itemBuilder: (context, index, animation) {
              itemData.isAddedToCart(itemData.searchProducts[index].itemEngName);
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
                      imageUrl: itemData.searchProducts[index].imageUrl,
                      productEngName: itemData.searchProducts[index].itemEngName,
                     // productUrduName: itemData.searchProducts[index].itemUrduName,
                      price: itemData.searchProducts[index].itemPrice,
                      shadowColor: shadowColor,
                      buttonColor: buttonColor,
                      rating: itemData.searchProducts[index].rating,
                      reviews: itemData.searchProducts[index].reviews,
                      isChecked: itemData.isChecked,
                    )),
              );
            },
            itemCount: itemData.searchProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.2,
            ),
          );
        }
      },
    ));
  }
}
