// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GerencianetPixViewModel {
  final String endToEndId;
  final String transactionId;
  final String pixKey;
  final String value;
  final String dateProcess;
  final String description;

  GerencianetPixViewModel(this.endToEndId, this.transactionId, this.pixKey,
      this.value, this.dateProcess, this.description);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'endToEndId': endToEndId,
      'txid': transactionId,
      'chave': pixKey,
      'valor': value,
      'horario': dateProcess,
      'infoPagador': description,
    };
  }

  factory GerencianetPixViewModel.fromMap(Map<String, dynamic> map) {
    return GerencianetPixViewModel(
      map['endToEndId'] as String,
      map['txid'] as String,
      map['chave'] as String,
      map['valor'] as String,
      map['horario'] as String,
      map['infoPagador'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GerencianetPixViewModel.fromJson(String source) =>
      GerencianetPixViewModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
