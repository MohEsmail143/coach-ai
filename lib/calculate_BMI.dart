import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/src/material/colors.dart';
import 'result_BMI.dart';

class BMI extends StatefulWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  bool isMale= true;
  double heightVal = 170;
  int weight= 55;
  int age= 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI CALCULATOR',style: TextStyle(color:Color(0xFF40D876)), ), centerTitle: true,backgroundColor: Colors.black,),
      backgroundColor:Colors.black ,
      //body: const result_BMI(age:22, isMale:true, result:32.44,),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    m1Expanded('male'),
                    SizedBox(width: 15,),
                    m1Expanded('female'),
                  ],
                ),
              ),
            ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Colors.white24,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Height',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text(heightVal.toStringAsFixed(1),style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold,color: Colors.white),),
                          Text(' cm',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),),
                        ],),
                        Slider(min:90,max:220,value: heightVal, onChanged: (newValue)=> setState(() => heightVal= newValue),),
                      ],
                    ),
                  )
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      m2Expanded('weight'),
                      SizedBox(width: 15,),
                      m2Expanded('age'),
                    ],
                  ),
                ),
              ),
              Container(
                  color: Color(0xFF40D876),
                  width: double.infinity,
                  height:MediaQuery.of(context).size.height/16,
                  child: TextButton(
                    onPressed:(){
                      var result=weight / pow(heightVal/100, 2);
                      print(result);
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                       return result_BMI(age:age, isMale:isMale, result:result, );
                      }),);
                    },
                    child: Text('Calculate',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:Colors.white),),)),
            ],
          ),
      ),
    );
  }

  Expanded m1Expanded(String gender) {
    return Expanded(
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    isMale= gender=='male'? true:false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color: (isMale&&gender=='male')||(!isMale&&gender=='female')? Color(0xFF40D876): Colors.white24,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Icon(gender=='male'?Icons.male : Icons.female, color: Colors.white, size: 90,),
                      SizedBox(height: 15,),
                      Text(gender=='male'? 'Male': 'Female',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),),
                    ],
                  ),
                ),
              )

          );

  }
  Expanded m2Expanded(String type) {
    return Expanded(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            color: Colors.white24,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text(type=='age'? 'Age': 'Weight',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),),
              SizedBox(height: 15,),
              Text(type=='age'? '$age': '$weight',style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold,color: Colors.white),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(heroTag:type=='age'? 'age--': 'weight--',
                    onPressed: ()=> setState(() => type=='age'? age--: weight--),
                    child: Icon(Icons.remove), mini: true,backgroundColor: Color(0xFF40D876),),
                  SizedBox(width: 10,),
                  FloatingActionButton(heroTag:type=='age'? 'age++': 'weight++',
                    onPressed: ()=> setState(() => type=='age'? age++: weight++),
                    child: Icon(Icons.add), mini: true,backgroundColor: Color(0xFF40D876),),
                ],
              ),
            ],
          ),
        )

    );
} }

/*class BMI extends StatelessWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI SCREEN"),
      ),
      body: Container(),
    );
  }
}*/
