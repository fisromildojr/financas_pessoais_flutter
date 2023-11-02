import 'package:intl/intl.dart';

class Utils{
  static convertDate(String date){
    try{
      if(date.contains('T')){
        return DateFormat('dd/MM/y').format(DateTime.parse(date));
      }else{
      return date.split(
        RegExp(r"(/|-)"))
        .reversed.join(date.contains("/") ? "-" : "/");
      }
    }catch (e){
      return "";
    }
  }

  static double converterMoedaParaDouble(String? valor) {
    if (valor == null) {
      valor = "0";
      print("O valor recebido para conversão está nulo!");
    } else if (valor == "null") {
      valor = "0";
      print("O valor recebido para conversão está nulo!");
    }
    final value = double.tryParse(
        valor.replaceAll(new RegExp(r'[^0-9,]+'), '').replaceAll(',', '.'));
    return value ?? 0;
  }
}