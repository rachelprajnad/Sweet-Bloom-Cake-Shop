// Import package bawaan Dart untuk delay atau timer
import 'dart:async';

// Import package Flutter untuk membuat UI
import 'package:flutter/material.dart';

// Fungsi utama untuk menjalankan aplikasi
void main() => runApp(const MyApp());

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sweet Bloom Cake Shop 🧁',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Lobster', fontSize: 18),
        ),
      ),
      home:
          const SplashScreen(), // Menjadikan SplashScreen sebagai halaman awal
      debugShowCheckedModeBanner: false,
    );
  }
}

// Halaman daftar cake
class CakePage extends StatefulWidget {
  const CakePage({super.key});

  @override
  State<CakePage> createState() => _CakePageState();
}

class _CakePageState extends State<CakePage> {
  // Daftar kue
  final List<Map<String, dynamic>> cakes = [
    {'name': 'Snow Ice', 'price': 50000, 'image': 'assets/Snow Ice_cake.jpg'},
    {
      'name': 'Tiramisu Classic',
      'price': 45000,
      'image': 'assets/Tiramisu Classic_cake.jpg',
    },
    {
      'name': 'Triple Chocolate',
      'price': 60000,
      'image': 'assets/Triple Chocolate_cake.jpg',
    },
    {
      'name': 'Almond Carameliz',
      'price': 55000,
      'image': 'assets/Almond_Carameliz.jpg',
    },
    {'name': 'Black Forest', 'price': 52000, 'image': 'assets/blackforest.jpg'},
    {
      'name': 'Blueberry Chill',
      'price': 53000,
      'image': 'assets/Blueberry_chill.jpg',
    },
    {'name': 'Cacao Berry', 'price': 58000, 'image': 'assets/cacao_berry.jpg'},
    {'name': 'Coffee Milk', 'price': 50000, 'image': 'assets/Coffe_Milk.jpg'},
    {
      'name': 'Harmony Cake',
      'price': 54000,
      'image': 'assets/Harmony_cake.jpg',
    },
    {
      'name': 'Rainbow Cake',
      'price': 49000,
      'image': 'assets/Rainbow_cake.jpg',
    },
    {'name': 'Red Velvet', 'price': 56000, 'image': 'assets/Red velvet.jpg'},
    {
      'name': 'Chocolate Supreme',
      'price': 62000,
      'image': 'assets/Chocolate_superme.jpg',
    },
    {'name': 'Coklat Chill', 'price': 51000, 'image': 'assets/Coklat_chil.jpg'},
    {
      'name': 'Tiramisu Choco',
      'price': 55000,
      'image': 'assets/Tiramisu_Chocolate.jpg',
    },
  ];

  // Data keranjang: key = index cake, value = jumlah beli
  final Map<int, int> cart = {};

  // Hitung total harga dari item dalam keranjang
  int get totalPrice {
    int total = 0;
    cart.forEach((index, quantity) {
      int price = cakes[index]['price'] as int;
      total += price * quantity;
    });
    return total;
  }

  // Fungsi menambah item ke keranjang
  void addToCart(int index) {
    setState(() {
      cart[index] = (cart[index] ?? 0) + 1;
    });
  }

  // Widget tombol + dan -
  Widget _buildCartButton(int index, {required bool isAdd}) {
    return SizedBox(
      width: 28,
      height: 28,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (isAdd) {
              addToCart(index);
            } else {
              if (cart[index] != null && cart[index]! > 0) {
                cart[index] = cart[index]! - 1;
                if (cart[index] == 0) cart.remove(index);
              }
            }
          });
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.pink[100],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Icon(
          isAdd ? Icons.add : Icons.remove,
          size: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  // Tampilkan dialog keranjang belanja
  void showCartDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxHeight: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Keranjang Belanja",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child:
                      cart.isEmpty
                          ? const Center(child: Text("Keranjang kosong"))
                          : ListView(
                            children:
                                cart.entries.map((entry) {
                                  final cake = cakes[entry.key];
                                  int price = cake['price'] as int;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.asset(
                                            cake['image'],
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cake['name'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text("Jumlah: ${entry.value}"),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text('Rp ${price * entry.value}'),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  cart.remove(entry.key);
                                                });
                                                Navigator.pop(context);
                                                showCartDialog();
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                ),
                const SizedBox(height: 10),
                if (cart.isNotEmpty)
                  Column(
                    children: [
                      Text('Total Harga: Rp $totalPrice'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showPaymentPage();
                        },
                        child: const Text("Lanjutkan ke Pembayaran"),
                      ),
                    ],
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Kembali"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Navigasi ke halaman pembayaran
  void _showPaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(totalPrice: totalPrice),
      ),
    );
  }

  // Build UI halaman utama
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sweet Bloom 🧁',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pink[300],
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: showCartDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Our Menu',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lobster',
                color: Colors.pink,
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 2;
                if (constraints.maxWidth >= 600) crossAxisCount = 3;
                if (constraints.maxWidth >= 900) crossAxisCount = 4;

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: cakes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final cake = cakes[index];
                    return Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.pink[50],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: Image.asset(
                                cake['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  cake['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text('Rp ${cake['price']}'),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildCartButton(index, isAdd: false),
                                    const SizedBox(width: 8),
                                    Text('${cart[index] ?? 0}'),
                                    const SizedBox(width: 8),
                                    _buildCartButton(index, isAdd: true),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman Pembayaran
class PaymentPage extends StatefulWidget {
  final int totalPrice;
  const PaymentPage({super.key, required this.totalPrice});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  String orderStatus = "";

  // Proses pembayaran
  void processOrder() {
    setState(() {
      orderStatus = "Pesanan sedang diproses...";
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        orderStatus = "Pesanan selesai! 🎉";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran"),
        backgroundColor: Colors.pink[300],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Harga", style: Theme.of(context).textTheme.titleLarge),
            Text(
              "Rp ${widget.totalPrice}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Metode Pembayaran"),
              value: selectedPaymentMethod,
              items:
                  ['CASH', 'BCA', 'BNI', 'MANDIRI']
                      .map(
                        (method) => DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.payment),
                onPressed: selectedPaymentMethod != null ? processOrder : null,
                label: const Text("Bayar Sekarang"),
              ),
            ),
            const SizedBox(height: 20),
            if (orderStatus.isNotEmpty)
              Center(
                child: Text(
                  orderStatus,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome to\nSweet Bloom Cake Shop 🧁',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontFamily: 'Lobster',
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: const Icon(Icons.cake),
              label: const Text(
                "Masuk ke Menu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const CakePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
