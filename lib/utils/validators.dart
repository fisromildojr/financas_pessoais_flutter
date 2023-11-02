import 'package:fenix_front/utils/utils.dart';
import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static FormFieldValidator date(
    String message,
  ) {
    return (data) {
      if ((data as String).isEmpty) {
        return null;
      } else if (data.contains(new RegExp(r'\d{2}\/\d{2}\/\d{4}'))) {
        try {
          //Explode a data
          var expDate = data.split(new RegExp(r'(/|-)'));
          //Coloca a data no formato correto (Se necessário)
          if (data.contains('/')) {
            data = expDate.reversed.join('-');
          }

          //Retorna quantos dias tem o mês
          int daysInMonth = DateTimeRange(
                  start:
                      DateTime(int.parse(expDate[2]), int.parse(expDate[1]), 1),
                  end: DateTime(
                      int.parse(expDate[2]), int.parse(expDate[1]) + 1))
              .duration
              .inDays;

          //Valida dia e mês inválidos
          if (int.parse(expDate[0]) <= 0 ||
              int.parse(expDate[0]) > daysInMonth ||
              int.parse(expDate[1]) > 12 ||
              int.parse(expDate[1]) <= 0) {
            return message;
          }
          DateTime.parse(data);
          return null;
        } catch (e) {
          return message;
        }
      } else {
        return message;
      }
    };
  }

  static FormFieldValidator validaDataSuperiorAtual(
    String message,
  ) {
    return (data) {
      if (data.contains(new RegExp(r'\d{2}\/\d{2}\/\d{4}'))) {
        try {
          //Explode a data passada
          var expDateP = data.split(new RegExp(r'(/|-)'));
          //Coloca a data passada no formato correto (Se necessário)
          if (data.contains('/')) {
            data = expDateP.reversed.join('-');
          }

          //Explode a data atual
          var expDateA = DateTime.now().toString().split(new RegExp(r'(/|-)'));

          //Retorna quantos dias tem o mês
          int daysInMonth = DateTimeRange(
                  start: DateTime(
                      int.parse(expDateP[2]), int.parse(expDateP[1]), 1),
                  end: DateTime(
                      int.parse(expDateP[2]), int.parse(expDateP[1]) + 1))
              .duration
              .inDays;

          var dataPassada = DateTime(int.parse(expDateP[2]),
              int.parse(expDateP[1]), int.parse(expDateP[0]));

          var dataAtual = DateTime(int.parse(expDateA[0]),
              int.parse(expDateA[1]), int.parse(expDateA[2].split(' ')[0]));
          int diferenca = dataPassada.difference(dataAtual).inDays;
          print("Data Passada => $dataPassada");
          print("Data Atual => $dataAtual");
          print("Diferença => $diferenca");
          if (diferenca > 0) {
            return message;
          }
          return null;
        } catch (e) {
          return message;
        }
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator validaDataInferiorAtual(
    String message,
  ) {
    return (data) {
      if (data.contains(new RegExp(r'\d{2}\/\d{2}\/\d{4}'))) {
        try {
          //Explode a data passada
          var expDateP = data.split(new RegExp(r'(/|-)'));
          //Coloca a data passada no formato correto (Se necessário)
          if (data.contains('/')) {
            data = expDateP.reversed.join('-');
          }

          //Explode a data atual
          var expDateA = DateTime.now().toString().split(new RegExp(r'(/|-)'));

          //Retorna quantos dias tem o mês
          int daysInMonth = DateTimeRange(
                  start: DateTime(
                      int.parse(expDateP[2]), int.parse(expDateP[1]), 1),
                  end: DateTime(
                      int.parse(expDateP[2]), int.parse(expDateP[1]) + 1))
              .duration
              .inDays;

          var dataPassada = DateTime(int.parse(expDateP[2]),
              int.parse(expDateP[1]), int.parse(expDateP[0]));

          var dataAtual = DateTime(int.parse(expDateA[0]),
              int.parse(expDateA[1]), int.parse(expDateA[2].split(' ')[0]));
          int diferenca = dataPassada.difference(dataAtual).inDays;
          print("Data Passada => $dataPassada");
          print("Data Atual => $dataAtual");
          print("Diferença => $diferenca");
          if (diferenca < 0) {
            return message;
          }
          return null;
        } catch (e) {
          return message;
        }
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator minDouble(
    double min,
    String message,
  ) {
    return (data) {
      if ((data as String).isEmpty) {
        return null;
      } else {
        try {
          //Tenta converter para double
          var doubleValue = Utils.converterMoedaParaDouble(data);

          //Coloca a data no formato correto (Se necessário)
          if (doubleValue < min) return message;

          return null;
        } catch (e) {
          return message;
        }
      }
    };
  }
}
