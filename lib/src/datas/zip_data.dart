import 'dart:convert';

class ResultZip {
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  String? unidade;
  String? ibge;
  String? gia;

  ResultZip({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.unidade,
    this.ibge,
    this.gia,
  });

  factory ResultZip.fromJson(String str) => ResultZip.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultZip.fromMap(Map<String, dynamic> map) => ResultZip(
        cep: map['cep'] ?? '',
        logradouro: map['logradouro'] ?? '',
        complemento: map['complemento'] ?? '',
        bairro: map['bairro'] ?? '',
        localidade: map['localidade'] ?? '',
        uf: map['uf'] ?? '',
        unidade: map['unidade'] ?? '',
        ibge: map['ibge'] ?? '',
        gia: map['gia'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'cep': cep ?? '',
        'logradouro': logradouro ?? '',
        'complemento': complemento ?? '',
        'bairro': bairro ?? '',
        'localidade': localidade ?? '',
        'uf': uf ?? '',
        'unidade': unidade ?? '',
        'ibge': ibge ?? '',
        'gia': gia ?? '',
      };
}
