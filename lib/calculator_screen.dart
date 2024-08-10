import 'package:flutter/material.dart';
import 'package:simple_calculator/button_values.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState  createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1='';
  String operand='';
  String number2='';

  @override
  Widget build(BuildContext context) {
    final screenSize=MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(title:Text('CALCULATOR',style:const TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.black),),centerTitle: true,backgroundColor: Colors.grey,) ,
      body:SafeArea(
        bottom:false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment:Alignment.bottomRight ,
                  padding: EdgeInsets.all(16),
                  child: Text(
                    '$number1$operand$number2'.isEmpty?'0'
                        :'$number1$operand$number2',
                     style: const TextStyle(fontSize: 48,fontWeight: FontWeight.bold),
                  textAlign:TextAlign.end ,),
                ),
              ),
            ),
            Wrap(
              children:Btn.buttonValues
                  .map(
                    (value)=>SizedBox(
                      width:value==Btn.n0?screenSize.width/2:(screenSize.width/4),
                        height:screenSize.width/5 ,
                        child: buildButton(value))
              )
                        .toList(),

            )

          ],
        ),
      )
    );
  }
  Widget buildButton(value){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
      color:getBtncolor(value),
        clipBehavior:Clip.hardEdge ,
        shape:OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap:()=> onBtntap(value),

          child:Center(child: Text(value,style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ) ,)
          ),
        ),
      ),
    );

  }
   void onBtntap(String value){
    if(value==Btn.del){
      delete();
      return;
    }if(value==Btn.clr){
      clearall();
      return;
    }
    if(value==Btn.per){
      percentage();
      return;
    }
    if(value==Btn.calculate){
      calculate();
      return;
    }
    appendvalue(value);
   }

   void delete() {
     if (number2.isNotEmpty) {
       number2 = number2.substring(0, number2.length - 1);
     } else if (operand.isNotEmpty) {
       operand = '';
     } else if (number1.isNotEmpty) {
       number1 = number1.substring(0, number1.length - 1);
     }
     setState(() {

     });
   }
   void clearall(){
    setState(() {
      number1='';
      operand='';
      number2='';
    });
   }
   void percentage(){
    if(number1.isNotEmpty&&operand.isNotEmpty&&number2.isNotEmpty){
  calculate();
    }
    if(operand.isNotEmpty){
      return;
    }
    final number=double.parse(number1);
    setState(() {
      number1='${(number/100)}';
      operand='';
      number2='';
    });
   }
   void calculate(){
    if(number1.isEmpty) return;
    if(operand.isEmpty) return;
    if(number2.isEmpty) return;

    double num1=double.parse(number1);
    double num2=double.parse(number2);

    var result=0.0;
    switch(operand){
      case Btn.add:
        result=num1+num2;
        break;
      case Btn.substract:
        result=num1-num2;
        break;
      case Btn.multiply:
        result=num1*num2;
        break;
      case Btn.divide:
        result=num1/num2;
        break;
      default:
    }
    setState(() {
      number1='$result';
      if(number1.endsWith('.0')){
        number1=number1.substring(0,number1.length-2);
      }
      operand='';
      number2='';
    });
   }
   void appendvalue(String value){
     if(value!=Btn.dot && int.tryParse(value)==null ){

       if(operand.isNotEmpty && number2.isNotEmpty){
    calculate();
       }
       operand=value;
     }else if(number1.isEmpty||operand.isEmpty){

       if(value==Btn.dot && number1.contains(Btn.dot)) return;
       if(value==Btn.dot && (number1.isEmpty ||number1==Btn.n0)) {
         value='0.';
       }
       number1+=value;
     }else if(number2.isEmpty||operand.isNotEmpty){

       if(value==Btn.dot && number2.contains(Btn.dot)) return;
       if(value==Btn.dot && (number2.isEmpty ||number2==Btn.n0)) {
         value='0.';
       }
       number2+=value;
     }
     setState(() {

     });
   }
   }
  Color getBtncolor(value){
    return [Btn.del,Btn.clr].contains(value)?Colors.blueGrey:[Btn.per,Btn.multiply,Btn.add,Btn.substract,Btn.per,
      Btn.divide].contains(value)?Colors.orange:Colors.black;

  }

