import 'package:flutter/material.dart';

class result_BMI extends StatelessWidget {
  const result_BMI({Key? key, required this.result, required this.isMale, required this.age}) : super(key: key);

  final double result;
  final bool isMale;
  final int age;

  String get resultphrase{
    String resultText= '';
    if (result >=30) resultText='Obese';
    else if (result >25 && result <30) resultText='OverWeight';
    else if (result >= 18.5 && result <= 24.5) resultText='Normal';
    else resultText= 'Thin';
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RESULT',style: TextStyle(color:Color(0xFF40D876)), ), centerTitle: true,backgroundColor: Colors.black,),
      backgroundColor:Colors.black ,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              Text('Gender: ${isMale? 'Male':'Female'}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,color: Colors.white),
              ),
              Text('Result: ${result.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold, color: Colors.white,)

              ),
              Text('Healthiness: $resultphrase',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,color: Colors.white,)

              ),
              Text('Age: $age',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,color: Colors.white,)

              ),
            ],
          ),
        ),
      ),
    );
  }
}
