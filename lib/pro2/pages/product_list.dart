import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;


import '../Constants/constants.dart';
import '../cubit/cubit_couter.dart';
import '../models/Category.dart';
import '../models/Product.dart';







class ProductList extends StatefulWidget {
  const ProductList({super.key
  });

  @override
  State<ProductList> createState() => _HomePageState();
}

// class _HomePageState extends State<ProductList> {
//   late Future<List<Product>> futureProducts;
//   List<Product> products= [];
//   final TextEditingController _searchController = TextEditingController();
//   int currentPage = 0;
//   final int pageSize = 5;
//
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchInitialProducts();
//
//     // futureProducts = fetchProducts(0,5);
//     _searchController.addListener(() async {
//       final baseUrl = Uri.parse('${Constants.baseUrl}/products/search?limit=${pageSize}&q=${_searchController.text}');
//       final response = await http.get(baseUrl,
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-16',
//           });
//
//       if (response.statusCode == 200) {
//
//         final result=  _parseProducts(response.bodyBytes);
//         setState(() {
//           futureProducts = Future.value(result);
//         });
//       }
//
//
//       https://dummyjson.com/products/search?q=phone
//       print("hello world");
//     });
//   }
//   void _fetchInitialProducts() {
//     setState(() {
//       futureProducts = fetchProducts( currentPage,  pageSize);
//       futureProducts.then((newProducts) {
//         setState(() {
//           products.clear();
//           products.addAll(newProducts);
//         });
//       });
//     });
//   }
//
//
//   void _fetchMoreProducts() {
//     setState(() {
//       isLoading = true;
//     });
//
//     // if (type == "down") {
//       fetchProducts( currentPage*pageSize + pageSize,  pageSize).then((newProducts) {
//         setState(() {
//
//           currentPage++;
//            products.clear();
//           products.addAll(newProducts);
//           print('số trag hiện taiiiiiiiiiiiiiiiiiii ${currentPage}');
//
//
//           isLoading = false;
//         });
//       }).catchError((error) {
//         setState(() {
//           isLoading = false;
//         });
//       });
//    // }
//     // else if (type == "up"){
//     //   if (currentPage == 0) {
//     //     currentPage = 1;
//     //   }
//     //   fetchProducts( currentPage *pageSize -pageSize,  pageSize).then((newProducts) {
//     //     setState(() {
//     //
//     //       currentPage--;
//     //        products.clear();
//     //       products.addAll(newProducts);
//     //       print('số trag hiện taiiiiiiiiiiiiiiiiiii ${currentPage}');
//     //
//     //
//     //       isLoading = false;
//     //     });
//     //   }).catchError((error) {
//     //     setState(() {
//     //       isLoading = false;
//     //     });
//     //   });
//     // }
//   }
//
//
//   Future<List<Product>> fetchProducts(int skip, int limit) async {
//     // Define the base URL
//
//     final baseUrl = Uri.parse('${Constants.baseUrl}/products?limit=${limit}&skip=${skip}');
//     final response = await http.get(baseUrl,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-16',
//         });
//
//     if (response.statusCode == 200) {
//
//       return _parseProducts(response.bodyBytes);
//     }
//
//     throw Exception('Failed to load Product');
//   }
//
//
//
//
//   Future<void> _refreshProducts() async {
//     final result = fetchProducts(0,5);
//     setState(() {
//       futureProducts = result;
//     });
//   }
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//
//
//   Widget ProductPageView(BuildContext context) {
//     final PageController _pageController = PageController();
//
//
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Swipe to View Products'),
//         backgroundColor: Colors.blue,
//       ),
//       body:Column(
//         children: [
//           Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           child: TextField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               hintText: 'Type something...',
//               prefixIcon: const Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//           ),), Expanded(
//             child: NotificationListener<ScrollNotification>(
//               onNotification: (scrollNotification)   {
//                 if (scrollNotification is ScrollEndNotification) {
//                   // int indexPage = context.read<CartCubit>().getIndexPage();
//                   // indexPage = indexPage + 1;
//                   // context.read<CartCubit>().setIndexPage(indexPage);
//                   //
//                   // final newProducts =  fetchProducts(indexPage * 5, 5);
//                   print('số lần kik hoatttttttttttttt');
//                   _fetchMoreProducts();
//                   //futureProducts = fetchProducts((indexPage * 5), 5);
//                 }
//
//                 return false;
//               },
//               child: RefreshIndicator(
//                 onRefresh: _refreshProducts,
//                 child: FutureBuilder(
//                   future: futureProducts,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return Text('Retrieve Failed ${snapshot.error}');
//                     } else if (snapshot.hasData) {
//                       //final List<Product> products = snapshot.data!;
//
//                       return ListView.builder(
//                         controller: _pageController,
//                         scrollDirection: Axis.vertical,
//                         itemCount: products.length ,
//                         itemBuilder: (context, index) {
//
//                           final product = products[index];
//                             if (product.stock != null) {
//                               return Card(
//                                 elevation: 2,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 8,
//                                     vertical: 10,
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(8),
//                                         child: Image.network(
//                                           '${product.thumbnail}',
//                                           fit: BoxFit.contain,
//                                           height: 80,
//                                           loadingBuilder: (context, child, loadingProgress) {
//                                             if (loadingProgress == null) return child;
//                                             return Container(
//                                               height: 80,
//                                               width: 80,
//                                               color: Colors.grey.shade200,
//                                               child: const Center(
//                                                 child: CircularProgressIndicator(),
//                                               ),
//                                             );
//                                           },
//                                           errorBuilder: (context, error, stackTrace) {
//                                             return const Icon(Icons.error);
//                                           },
//                                         ),
//                                       ),
//                                       const SizedBox(width: 16),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Text(
//                                               '${product.title}',
//                                               style: const TextStyle(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                             const SizedBox(width: 16),
//                                             Text(
//                                               '\$${product.id} USD',
//                                               style: const TextStyle(fontSize: 12),
//                                             ),
//                                             const SizedBox(width: 16),
//                                             Text(
//                                               '${product.stock} units in stock',
//                                               style: const TextStyle(fontSize: 12),
//                                             ),
//                                             const SizedBox(width: 16),
//                                             Text(
//                                               '${product.discountPercentage} discountPercentage',
//                                               style: const TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(width: 16),
//                                       ElevatedButton(
//                                         onPressed: () {},
//                                         child: const Text(
//                                           'Details',
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                         style: ElevatedButton.styleFrom(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 8,
//                                             vertical: 4,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               return const SizedBox.shrink();
//                             }
//
//
//                         },
//                       );
//                     } else {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                   },
//                 ),
//               ),
//             ),
//           )
//         ],
//       )
//
//
//
//       // Bọc ListView trong Expanded để nó có thể lấy hết không gian còn lại
//       ,
//
//
//     );
//   }
//
//
//
//
//   // class MyHomePage extends StatefulWidget {
//   // @override
//   // _MyHomePageState createState() => _MyHomePageState();
//   // }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartCubit, Map<String, dynamic>>(
//         builder: (context, state) {
//           bool isDetailProduct = state['isDetailProduct'] ?? false;
//           // if (!isDetailProduct) {
//           //   return buildProductList(context);
//           // }
//           //  else {
//           //    return ProductPageView(context);
//           //  }
//             return ProductPageView(context);
//         }
//     );
//   }
//
//
//
//   List<Product> _parseProducts(List<int> response) {
//     // Parse the JSON response
//     //final List<dynamic> jsonResponse = json.decode(response);
//
//     final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response));
//
//     // final List<Product> products = jsonResponse["content"]
//     //     .map<Product>((json) => Product.fromJson(json))
//     //     .toList();
//     setState(() {
//       List<dynamic> content = jsonResponse["products"];
//       for (var item in content) {
//         if (item is Map<String, dynamic>) {
//           if (!item.containsKey("Qty") || item["Qty"] == null) {
//             item[
//             "Qty"
//             ] = 1; // Nếu thuộc tính "Qty" không tồn tại hoặc null, gán giá trị mặc định là 1
//           }
//         }
//       }
//     });
//     //Provider.of<ProductProvider>(context, listen: false).setProducts(products);
//
//     print('in ra ds sản pham $jsonResponse');
//
//
//
//     return jsonResponse[
//     "products"
//     ].map<Product>((json) => Product.fromJson(json)).toList();
//   }
//
//
//
// }
class _HomePageState extends State<ProductList> {
  late Future<List<Product>> futureProducts;
  late Future<List<Categorytt>> futureCategories;
  List<Product> products = [];
  List<Categorytt> Categories = [];
  final TextEditingController _searchController = TextEditingController();
  int currentPage = 0;
  final int pageSize = 5;

  bool isLoading = false;
  String? dropdownValue;


  @override
  void initState() {
    super.initState();
    _fetchInitialProducts();

    _searchController.addListener(() async {
      final query = _searchController.text;

      if (query.isNotEmpty) {
        final baseUrl = Uri.parse(
            'https://dummyjson.com/products/search?q=$query');
        final response = await http.get(baseUrl, headers: {
          'Content-Type': 'application/json; charset=UTF-16',
        });

        if (response.statusCode == 200) {
          final result = _parseProducts(response.bodyBytes);

          setState(() {
            products = result; // Cập nhật danh sách sản phẩm hiển thị
          });
        } else {
          print("Error fetching search results: ${response.statusCode}");
        }
      } else {
        // Nếu ô tìm kiếm rỗng, hiển thị lại danh sách ban đầu
        _fetchInitialProducts();
      }
    });
    _fetchInitialCategories();

  }

  void _fetchInitialProducts() {
    setState(() {
      futureProducts = fetchProducts(currentPage, pageSize);
      futureProducts.then((newProducts) {
        setState(() {
          products.clear();
          products.addAll(newProducts);
        });
      });
    });
  }

  void _fetchMoreProducts() {
    setState(() {
      isLoading = true;
    });

    fetchProducts(currentPage * pageSize + pageSize, pageSize).then((newProducts) {
      setState(() {
        currentPage++;
        products.clear();
        products.addAll(newProducts);
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<List<Product>> fetchProducts(int skip, int limit) async {
    final baseUrl = Uri.parse(
        'https://dummyjson.com/products?limit=$limit&skip=$skip');
    final response = await http.get(baseUrl, headers: {
      'Content-Type': 'application/json; charset=UTF-16',
    });

    if (response.statusCode == 200) {
      return _parseProducts(response.bodyBytes);
    }

    throw Exception('Failed to load Product');
  }

  Future<void> _refreshProducts() async {
    final result = fetchProducts(0, pageSize);
    setState(() {
      futureProducts = result;
    });
  }

  List<Product> _parseProducts(List<int> response) {
    final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response));
    final List<dynamic> content = jsonResponse["products"];
    for (var item in content) {
      if (item is Map<String, dynamic>) {
        if (!item.containsKey("Qty") || item["Qty"] == null) {
          item["Qty"] = 1;
        }
      }
    }

    return content.map<Product>((json) => Product.fromJson(json)).toList();
  }
  Future<List<Categorytt>> _fetchCategories() async {
    final baseUrl = Uri.parse('https://dummyjson.com/products/categories');
    final response = await http.get(baseUrl, headers: {
      'Content-Type': 'application/json; charset=UTF-16',
    });

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((category) => Categorytt(slug: category['slug'], name: category['name'], url: category['url']))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Hàm khởi tạo và tải danh sách categories
  void _fetchInitialCategories() {
    futureCategories = _fetchCategories();
    futureCategories.then((fetchedCategories) {
      setState(() {
        Categories = fetchedCategories; // Cập nhật danh sách từ API
        if (Categories.isNotEmpty) {
          dropdownValue = Categories.first.slug; // Đặt giá trị mặc định
        }
      });
    });
  }
  void _fetchProductsByCategory(String category) async {
    final baseUrl = Uri.parse('https://dummyjson.com/products/category/$category');
    final response = await http.get(baseUrl, headers: {
      'Content-Type': 'application/json; charset=UTF-16',
    });

    if (response.statusCode == 200) {
      final result = _parseProducts(response.bodyBytes);
      setState(() {
        products = result; // Cập nhật danh sách sản phẩm theo danh mục
      });
    } else {
      print("Error fetching products by category: ${response.statusCode}");
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Products'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              children: [
                Expanded(child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                )),

                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _fetchInitialProducts(); // Load lại danh sách ban đầu
                  },
                ),
                DropdownButton<String>(
    value: dropdownValue,
    icon: const Icon(Icons.arrow_downward),
    iconSize: 24,
    elevation: 16,
    style: const TextStyle(color: Colors.deepPurple),
    underline: Container(
    height: 2,
    color: Colors.deepPurpleAccent,
    ),
    onChanged: (String? newValue) {
    setState(() {
    dropdownValue = newValue!;
    });
    _fetchProductsByCategory(dropdownValue!);


    https://dummyjson.com/products/category/smartphones
    // In ra "Hello World" khi chọn một mục
    print("Hello World categoryyyyyyyyyyyyyy ${dropdownValue}");
    },
    items: Categories.map<DropdownMenuItem<String>>((Categorytt category) {
    return DropdownMenuItem<String>(
    value: category.slug, // Sử dụng slug làm giá trị
    child: Text(category.name), // Hiển thị tên danh mục
    );
    }).toList(),
    ),


              ],
            )
            ,
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification) {
                  _fetchMoreProducts();
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: _refreshProducts,
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                '${product.thumbnail}',
                                fit: BoxFit.contain,
                                height: 80,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: 80,
                                    width: 80,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${product.title}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    '\$${product.price} USD',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    '${product.stock} units in stock',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    '${product.discountPercentage} discountPercentage',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
