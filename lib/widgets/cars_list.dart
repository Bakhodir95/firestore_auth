import 'package:firestore_auth/controllers/car_controller.dart';
import 'package:firestore_auth/models/car.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarsList extends StatelessWidget {
  const CarsList({super.key});
  void deleteCar() async {
    // await CarController
  }

  @override
  Widget build(BuildContext context) {
    final carsController = context.read<CarsController>();
    // Provider.of<CarsController>(context, listen: false);

    return StreamBuilder(
        stream: carsController.list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text("Mashinalar mavjud emas"),
            );
          }

          final cars = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: cars.length,
            itemBuilder: (ctx, index) {
              final car = Car.fromQuerySnapshot(cars[index]);
              return ListTile(
                leading: SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.network(
                    car.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  car.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                trailing: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.delete)),
              );
            },
          );
        });
  }
}
