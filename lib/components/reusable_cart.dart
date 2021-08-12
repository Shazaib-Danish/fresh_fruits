import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_and_fruits/data/data_manager.dart';
import 'package:provider/provider.dart';

class ReusableCart extends StatefulWidget {
  final String imageUrl;
  final String engName;
  final String urduName;
  final int price;

  const ReusableCart({
    required this.imageUrl,
    required this.engName,
    required this.urduName,
    required this.price,
  });

  @override
  _ReusableCartState createState() => _ReusableCartState();
}

class _ReusableCartState extends State<ReusableCart> {
  late TextEditingController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Consumer<ProductManager>(
        builder: (context, itemData, child) {
          itemData.tileIndex(widget.engName);
          itemData.getValue(itemData.itemIndex);
          final value = itemData.getController;
          _controller =
              TextEditingController(text: value == 0 ? '' : '$value');
          final val =
              TextSelection.collapsed(offset: _controller.text.length);
          _controller.selection = val;
          return Container(
            height: 150,
            width: double.infinity,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0,right: 50.0),
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 35.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.engName}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                                Text(
                                  '${widget.urduName}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Rs. ${widget.price}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.green),
                                    ),
                                    Text(
                                      widget.engName.startsWith('Orange')
                                          ? '/dozen'
                                          : widget.engName.startsWith('Banana')
                                          ? '/dozen'
                                          : widget.engName.startsWith('Kin')
                                          ? '/dozen'
                                          : '/kg',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(10.0)
                                  )
                                ),
                                child: Icon(Icons.close,size: 18, color: Colors.white,),
                              ),
                              onTap: (){
                                Provider.of<ProductManager>(context, listen: false)
                                    .deleteProduct(widget.engName);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Material(
                      elevation: 10.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.53,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          color: Colors.white,
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Rs.',style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              width: 60,
                              height: 30,
                              color: Colors.white,
                              child: TextFormField(
                                style: TextStyle(color: Colors.green,fontWeight: FontWeight.w700,fontSize: 16),
                                decoration: InputDecoration(
                                    focusColor: Colors.green,
                                    hintText: 'Enter',
                                    hintStyle: TextStyle(
                                        fontSize: 11.0,
                                        color: Colors.grey
                                    )
                                ),
                                controller: _controller,
                                cursorColor: Colors.green,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'mini 10';
                                  }
                                  else if(int.parse(value) >= 10){
                                    return null;
                                  }

                                  else{
                                    return 'mini 10';
                                  }
                                },
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if(value.isEmpty){
                                    itemData.tileIndex(widget.engName);
                                    itemData.addPrice(
                                        itemData.index, int.parse(0.toString()));
                                  }
                                  else{
                                    itemData.tileIndex(widget.engName);
                                    itemData.addPrice(
                                        itemData.index, int.parse(value));
                                  }
                                },
                              ),
                            ),
                            Icon(CupertinoIcons.equal,color: Colors.deepOrangeAccent),
                            Row(
                              children: [
                                Text(' ${itemData.ordersData[itemData.index].itemQuantity.toStringAsFixed(2)}'),
                                Text( widget.engName.startsWith('Orange')
                                    ? '/dz'
                                    : widget.engName.startsWith('Banana')
                                    ? '/dz'
                                    : widget.engName.startsWith('Kin')
                                    ? '/dz'
                                    : '/kg',)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 45.0,top: 10.0),
                    child: Material(
                      elevation: 10.0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          color: Colors.white
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
