


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../cubit/cubit_couter.dart';



class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: BlocBuilder<CartCubit, Map<String, dynamic>>(
  // builder: (context, state) {
  //   return Text('The value from first page: $state');
  // },
  builder: (context, state) => Scaffold(
    appBar: AppBar(
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Text('Cart',
            style: TextStyle(
              fontSize: 37.0,
              fontWeight: FontWeight.bold,
              //color: Colors.blue,
            ),
          ),
          Text('All products selected are in your cart'),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      toolbarHeight: 96.0,
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),

          Column(
            children: [
              Container(
                child: Column(
                    children: [
                      Container(
                        color: Color.fromARGB(255, 241, 241, 241),
                        child: Row(

                          children: <Widget>[
                            Expanded(child: Container(
                              color: Color.fromARGB(255, 241, 241, 241),
                              // Chiều rộng cố định
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Products',
                                    textAlign: TextAlign.center, // Căn giữa văn bản
                                  ),
                                ],
                              ),
                            ),
                              flex: 4,),


                            const Expanded(

                              flex: 1,
                              child: Text('Qty'),
                            ),
                            const Expanded(
                              flex: 2,
                              child: Text('Unit Price'),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Text('Price'),
                            ),

                          ],
                        ),
                      ),

                      Container(
                        height: 1,
                        color: Colors.grey,
                      )
                    ]

                ),
              ),
              SizedBox(
                  height: 100,
                  child: ListView.builder(
                      itemCount:  state['product'].length,
                      itemBuilder: (context,index) =>
                          Container(

                            child: Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20.0), // Tạo padding 8px cho tất cả các mặt
                                        child: Container(
                                          // Chiều rộng cố định
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  context.read<CartCubit>().remove(index);
                                                 // context.read<CartCubit>().updateCart();
                                                },
                                                child: const Icon(Icons.close, color: Colors.red,),
                                              ),
                                              Text(
                                                '${state['product'][index].name}',
                                                textAlign: TextAlign.center, // Căn giữa văn bản
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Text('${state['product'][index].Qty}'),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Text('\$${state['product'][index].price}'),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      Text('\$${(state['product'][index].price ?? 0) * (state['product'][index].Qty ?? 1)}'),

                                    ),

                                  ],
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          )
                  )
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    child: Text('Grand Total: \$${context.read<CartCubit>().price}',
                        style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700
                        )),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  )
                ],
              ),

            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 195,
                  child: ElevatedButton.icon(
                    onPressed: ()  {
                      context.read<CartCubit>().clearOrder();
                      //provider.addItem(products[index]);
                    },
                    icon:const CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.white,
                      child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 10.0
                      ),
                    ), // thêm icon vào nút
                    label: const Text('Clear Cart'), // văn bản của nút
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Độ cong của góc
                      ),// thiết lập màu văn bản trên nút
                    ),
                  ),),
                const SizedBox(height: 16),
                SizedBox(width: 195,
                  child: ElevatedButton.icon(
                    onPressed: ()  async {
                      if (context.read<CartCubit>().price > 0) {
                        if (state['token'] != ''){
                          
                          context.read<CartCubit>().setIndexWidget(1);
                           context.read<CartCubit>().checkOut();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Create order success'),
                                duration: Duration(seconds: 3),
                              ),
                            );


                        }
                        else {
                          context.read<CartCubit>().setIndexWidget(2);

                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Order emty. Please buy something'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }

                      //provider.addItem(products[index]);
                    },
                    icon: const Icon(Icons.shopping_cart), // thêm icon vào nút
                    label: const Text('Check out'), // văn bản của nút
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Độ cong của góc
                      ),// thiết lập màu văn bản trên nút
                    ),
                  ),),
                const SizedBox(height: 16),
                SizedBox(width: 195,
                  child: ElevatedButton.icon(
                    onPressed: ()  {
                      context.read<CartCubit>().setIndexWidget(0);

                    },
                    icon: const CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.white,
                      child: Icon(
                          Icons.arrow_back,
                          color: Colors.green,
                          size: 10.0
                      ),
                    ), // thêm icon vào nút
                    label: const Text('Continue Shopping'), // văn bản của nút
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Độ cong của góc
                      ),// thiết lập màu văn bản trên nút
                    ),
                  ),),
              ],
            ),
          )

        ],
      ),
    )
    ,





  ),

),
      // Nội dung của trang CartList ở đây
      // ...
    );
  }
}









