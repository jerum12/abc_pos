import 'package:abc_pos/source/home/bloc/menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String isActiveMenu;
  //late dynamic listItem;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late List<Product> productList = [];
  String dynamicText = 'Hello, World!';
  @override
  void initState() {
    super.initState();
    //listItem = _list_item_lasagna();
    productList = getProductsLasagna();
    isActiveMenu = "lasagna";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 41, 41, 40),
        drawer: Drawer(child: BlocBuilder<MenuBloc, MenuState>(
          builder: (context, state) {
            if (state is MenuSuccess) {
              final cartBloc = context.read<MenuBloc>();

              if (state.cartItems.isEmpty) {
                return const Center(child: Text('Your cart is empty!'));
              } else {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Cart Details',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cartItems.length,
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        itemBuilder: (context, index) {
                          final cartItems = state.cartItems[index];

                          return Card(
                            child: ListTile(
                              title: Text(cartItems.title),
                              subtitle: Text(cartItems.price),
                              trailing: FittedBox(
                                child: Row(children: [
                                  IconButton(
                                      onPressed: () {
                                        int currentQuantity =
                                            cartItems.quantity;

                                        if (currentQuantity == 1) {
                                          cartBloc
                                              .add(RemoveItemEvent(cartItems));
                                        } else {
                                          cartBloc.add(ChangeQuantityEvent(
                                              cartItems.id, -1));
                                        }
                                      },
                                      icon: const Icon(Icons.remove)),
                                  Text(cartItems.quantity.toString()),
                                  IconButton(
                                      onPressed: () {
                                        cartBloc.add(ChangeQuantityEvent(
                                            cartItems.id, 1));
                                      },
                                      icon: const Icon(Icons.add))
                                ]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:'),
                          Text('₱${state.total}'),
                        ],
                      ),
                    ),
                  ],
                );
              }
            } else {
              return const Center(child: Text('Your cart is empty!'));
            }
          },
        )),
        key: _scaffoldKey,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   backgroundColor: const Color(0xFFCD8E00),
        //   child: const Icon(Icons.shopping_cart_checkout),
        // ),
        floatingActionButton: FittedBox(
          child: Stack(
            alignment: const Alignment(1.4, -1.5),
            children: [
              FloatingActionButton(
                // Your actual Fab
                onPressed: () => {_scaffoldKey.currentState?.openDrawer()},
                backgroundColor: const Color(0xFFCD8E00),
                child: const Icon(Icons.shopping_cart_checkout),
              ),
              Container(
                  // This is your Badge
                  padding: const EdgeInsets.all(5),
                  constraints:
                      const BoxConstraints(minHeight: 25, minWidth: 25),
                  decoration: BoxDecoration(
                    // This controls the shadow
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 5,
                          color: Colors.black.withAlpha(50))
                    ],
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(
                        0xFFABCDEF), // This would be color of the Badge
                  ),
                  // This is your Badge
                  child: BlocBuilder<MenuBloc, MenuState>(
                      builder: (context, state) {
                    if (state is MenuLoading) {
                      return const Center(child: Text('0'));
                    } else if (state is MenuSuccess) {
                      //final state = state is MenuSuccess;
                      String cnt = state.cartItems.length.toString();
                      return Center(child: Text(cnt));
                    } else {
                      // ScaffoldMessenger.of(context)
                      //     .showSnackBar(const SnackBar(
                      //   content: Text('Product successfully added to cart!'),
                      //   duration: Duration(seconds: 1),
                      // ));
                      return const Center(child: Text('!'));
                    }
                  }))
            ],
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  _topMenu(
                    title: "Antigua's Bake & Cuisine",
                    subTitle: '',
                    action: _search(),
                  ),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _itemTab(
                            icon: 'assets/icons/icon-lasagna.png',
                            title: 'Lasagna',
                            isActive: isActiveMenu == 'lasagna' ? true : false,
                            type: 'lasagna'),
                        _itemTab(
                            icon: 'assets/icons/icon-cookies.png',
                            title: 'Cookies',
                            isActive: isActiveMenu == 'cookies' ? true : false,
                            type: 'cookies'),
                        _itemTab(
                            icon: 'assets/icons/icon-moist-cake.png',
                            title: 'Moist Cake',
                            isActive: isActiveMenu == 'cake' ? true : false,
                            type: 'cake'),
                        _itemTab(
                            icon: 'assets/icons/icon-coffee-jelly.png',
                            title: 'Coffe Jelly',
                            isActive: isActiveMenu == 'coffee' ? true : false,
                            type: 'coffee'),
                        _itemTab(
                            icon: 'assets/icons/icon-mango.png',
                            title: 'Mango',
                            isActive: isActiveMenu == 'mango' ? true : false,
                            type: 'mango')
                      ],
                    ),
                  ),
                  //FOR LIST OF ITEMS

                  Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            final product = productList[index];
                            return GestureDetector(
                              onTap: () {
                                final cartBloc = context.read<MenuBloc>();
                                final state = cartBloc.state;
                                bool right = true;

                                if (state is MenuSuccess) {
                                  final cartItems = state.cartItems;
                                  final index = cartItems
                                      .indexWhere((pr) => pr.id == product.id);

                                  if (index > -1) {
                                    right = false;
                                  }
                                }
                                if (right) {
                                  cartBloc.add(AddItemEvent(product));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      'Product successfully added to cart!',
                                    ),
                                    duration: Duration(seconds: 1),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Product already exist!'),
                                    duration: Duration(seconds: 1),
                                  ));
                                }
                              },
                              child: _item(
                                  image: product.image,
                                  title: product.title,
                                  price: product.price,
                                  item: product.item),
                            );
                          }))
                ],
              ),
            ),
          ],
        ));
  }

  double calculateTotal() {
    // Assuming there is a fixed tax rate of 10%
    double taxRate = 0.1;
    double subtotal = 123;
    double total = subtotal + (subtotal * taxRate);
    return total;
  }

  List<Product> getProductsLasagna() {
    return [
      const Product(
          id: 1,
          image: 'assets/items/solo.png',
          title: 'Solo Lasagna',
          price: '₱88.00',
          item: '11 item',
          quantity: 1),
      const Product(
        id: 2,
        image: 'assets/items/sharing.png',
        title: 'Sharing Lasagna',
        price: '₱240.00',
        item: '10 item',
        quantity: 1,
      ),
      const Product(
        id: 3,
        image: 'assets/items/family.png',
        title: 'Family Lasagna',
        price: '₱480.00',
        item: '10 item',
        quantity: 1,
      ),
    ];
  }

  List<Product> getProductsCookies() {
    return [
      const Product(
        id: 21,
        image: 'assets/items/cookie.png',
        title: 'Chocolate Chips By 3s',
        price: '₱88.00',
        item: '11 item',
        quantity: 1,
      ),
      const Product(
        id: 22,
        image: 'assets/items/cookie.png',
        title: 'Choco Wallnut By 3s',
        price: '₱240.00',
        item: '10 item',
        quantity: 1,
      ),
      const Product(
        id: 23,
        image: 'assets/items/cookie.png',
        title: 'Premium Nutty By 3s',
        price: '₱480.00',
        item: '10 item',
        quantity: 1,
      ),
      const Product(
        id: 24,
        image: 'assets/items/cookie.png',
        title: 'Chocolate Chips By 6s',
        price: '₱88.00',
        item: '11 item',
        quantity: 1,
      ),
      const Product(
        id: 25,
        image: 'assets/items/cookie.png',
        title: 'Choco Wallnut By 6s',
        price: '₱240.00',
        item: '10 item',
        quantity: 1,
      ),
      const Product(
        id: 26,
        image: 'assets/items/cookie.png',
        title: 'Premium Nutty By 6s',
        price: '₱480.00',
        item: '10 item',
        quantity: 1,
      ),
      const Product(
        id: 27,
        image: 'assets/items/cookie.png',
        title: 'Chocolate Chips By 8s',
        price: '₱88.00',
        item: '11 item',
        quantity: 1,
      ),
      const Product(
        id: 28,
        image: 'assets/items/cookie.png',
        title: 'Choco Wallnut By 8s',
        price: '₱240.00',
        item: '10 item',
        quantity: 1,
      ),
      const Product(
        id: 29,
        image: 'assets/items/cookie.png',
        title: 'Premium Nutty By 8s',
        price: '₱480.00',
        item: '10 item',
        quantity: 1,
      ),
      const Product(
        id: 30,
        image: 'assets/items/cookie.png',
        title: 'Chocolate Chips By 10s',
        price: '₱88.00',
        item: '11 item',
        quantity: 1,
      ),
      const Product(
        id: 31,
        image: 'assets/items/cookie.png',
        title: 'Choco Wallnut By 10s',
        price: '₱240.00',
        item: '10 item',
        quantity: 1,
      ),
      const Product(
        id: 32,
        image: 'assets/items/cookie.png',
        title: 'Premium Nutty By 10s',
        price: '₱480.00',
        item: '10 item',
        quantity: 1,
      ),
    ];
  }

  // Widget _list_item_lasagna() {
  //   return Expanded(
  //     child: GridView.count(
  //       crossAxisCount: 3,
  //       childAspectRatio: (1 / 1),
  //       children: [
  //         _item(
  //           image: 'assets/items/solo.png',
  //           title: 'Solo Lasagna',
  //           price: '₱88.00',
  //           item: '11 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/sharing.png',
  //           title: 'Sharing Lasagna',
  //           price: '₱240.00',
  //           item: '10 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/family.png',
  //           title: 'Family Lasagna',
  //           price: '₱480.00',
  //           item: '10 item',
  //           quantity: 1,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _list_item_cookies() {
  //   return Expanded(
  //     child: GridView.count(
  //       crossAxisCount: 3,
  //       childAspectRatio: (1 / 1),
  //       children: [
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Chocolate Chips By 3s',
  //           price: '₱88.00',
  //           item: '11 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Choco Wallnut By 3s',
  //           price: '₱240.00',
  //           item: '10 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Premium Nutty By 3s',
  //           price: '₱480.00',
  //           item: '10 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Chocolate Chips By 6s',
  //           price: '₱88.00',
  //           item: '11 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Choco Wallnut By 6s',
  //           price: '₱240.00',
  //           item: '10 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Premium Nutty By 6s',
  //           price: '₱480.00',
  //           item: '10 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Chocolate Chips By 8s',
  //           price: '₱88.00',
  //           item: '11 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Choco Wallnut By 8s',
  //           price: '₱240.00',
  //           item: '10 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Premium Nutty By 8s',
  //           price: '₱480.00',
  //           item: '10 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Chocolate Chips By 10s',
  //           price: '₱88.00',
  //           item: '11 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Choco Wallnut By 10s',
  //           price: '₱240.00',
  //           item: '10 item',
  //           quantity: 1,
  //         ),
  //         _item(
  //           image: 'assets/items/cookie.png',
  //           title: 'Premium Nutty By 10s',
  //           price: '₱480.00',
  //           item: '10 item',
  //           quantity: 1,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _itemOrder({
    required String image,
    required String title,
    required String qty,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xff1f2029),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Text(
            '$qty x',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String image,
    required String title,
    required String price,
    required String item,
    int? quantity,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xff1f2029),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xFFCD8E00),
                  fontSize: 15,
                ),
              ),
              Text(
                item,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _tapItemTab(String type) {
    switch (type) {
      case "lasagna":
        setState(() {
          productList = getProductsLasagna();
          isActiveMenu = "lasagna";
        });

        break;
      case "cookies":
        setState(() {
          productList = getProductsCookies();
          isActiveMenu = "cookies";
        });
        break;
      default:
        setState(() {
          productList = getProductsLasagna();
        });
        break;
    }
  }

  Widget _itemTab(
      {required String icon,
      required String title,
      required bool isActive,
      required String type}) {
    return GestureDetector(
        onTap: () => {_tapItemTab(type)},
        child: Container(
            width: 180,
            margin: const EdgeInsets.only(right: 26),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xff1f2029),
              border: isActive
                  ? Border.all(color: const Color(0xFFCD8E00), width: 3)
                  : Border.all(color: const Color(0xff1f2029), width: 3),
            ),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: 38,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )));
  }

  Widget _topMenu({
    required String title,
    required String subTitle,
    required Widget action,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subTitle,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
          ],
        ),
        Expanded(flex: 1, child: Container(width: double.infinity)),
        Expanded(child: action),
      ],
    );
  }

  Widget _search() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: 100,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xff1f2029),
        ),
        child: Row(
          children: const [
            Icon(
              Icons.search,
              color: Colors.white54,
            ),
            SizedBox(width: 10),
            Text(
              'Search menu here...',
              style: TextStyle(color: Colors.white54, fontSize: 11),
            )
          ],
        ));
  }
}
