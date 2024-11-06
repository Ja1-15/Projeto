import 'dart:async';
import 'dart:io';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

bool _hidden = true;
String auth = "NllIUFNURUU4SkRTM0VIQ1NYU0c3QlE1QTU1QUxKSkE6";
late final KeyboardVisibilityController _keyboardVisibilityController;
late StreamSubscription<bool> keyboardSubscription;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

var password = '';
var cpf = '';
var cnpj = '';
var email = '';
var nome_resp = '';
var nome_empresa = '';
var ie = '';

class _SignupScreenState extends State<SignupScreen> {
  final controller_cnpj = TextEditingController();
  final controller_ie = TextEditingController();
  final controller_name = TextEditingController();
  final controller_password = TextEditingController();
  final controller_email = TextEditingController();
  final controller_empresa = TextEditingController();
  final controller_cep = TextEditingController();
  final controller_numero = TextEditingController();
  final controller_complemento = TextEditingController();
  final controller_cidade = TextEditingController();
  final controller_telefone = TextEditingController();
  final controller_bairro = TextEditingController();
  var controller_rua = TextEditingController();

  @override
  void initState() {
    super.initState();
    _keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        _keyboardVisibilityController.onChange.listen((isVisible) {
      if (!isVisible) {
        getAdress(controller_cep.text);
      }
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  final List<String> estados = [
    'Acre (AC)',
    'Alagoas (AL)',
    'Amapá (AP)',
    'Amazonas (AM)',
    'Bahia (BA)',
    'Ceará (CE)',
    'Distrito Federal (DF)',
    'Espírito Santo (ES)',
    'Goiás (GO)',
    'Maranhão (MA)',
    'Mato Grosso (MT)',
    'Mato Grosso do Sul (MS)',
    'Minas Gerais (MG)',
    'Pará (PA)',
    'Paraíba (PB)',
    'Paraná (PR)',
    'Pernambuco (PE)',
    'Piauí (PI)',
    'Rio de Janeiro (RJ)',
    'Rio Grande do Norte (RN)',
    'Rio Grande do Sul (RS)',
    'Rondônia (RO)',
    'Roraima (RR)',
    'Santa Catarina (SC)',
    'São Paulo (SP)',
    'Sergipe (SE)',
    'Tocantins (TO)'
  ];
  String? _selectedState;

  var xml_customer = [
    '''<?xml version="1.0" encoding="UTF-8"?>
    <prestashop xmlns:xlink="http://www.w3.org/1999/xlink">
    <customer>
    <id_default_group>3</id_default_group>
    <id_lang>2</id_lang>
    <deleted>0</deleted>
    <passwd>$password</passwd>
    <cpf></cpf>
    <cnpj>$cnpj</cnpj>
    <rg></rg>
    <ie>$ie</ie>
    <lastname>$nome_resp</lastname>
    <firstname>$nome_empresa</firstname>
    <email>$email</email>
    <newsletter>0</newsletter>
    <optin>0</optin>
    <website></website>
    <company></company>
    <siret>$cnpj</siret>
    <ape></ape>
    <outstanding_allow_amount>0</outstanding_allow_amount>
    <show_public_prices>0</show_public_prices>
    <id_risk>0</id_risk>
    <max_payment_days>0</max_payment_days>
    <active>1</active>
    <note>registrado via aplicativo</note>
    <is_guest>0</is_guest>
    <id_shop>1</id_shop>
    <id_shop_group>1</id_shop_group>
    <id_default_payment>0</id_default_payment>
    <date_add></date_add>
    <date_upd></date_upd>
    <reset_password_token></reset_password_token>
    <reset_password_validity></reset_password_validity>
    <associations>
    <groups>
    <group>
    <id>3</id>
    </group>
    </groups>
    </associations>
    </customer>
    </prestashop>'''
  ];

  var xml_address = {
    """<?xml version="1.0" encoding="UTF-8"?>
<prestashop xmlns:xlink="http://www.w3.org/1999/xlink">
    <address>
        <id_customer></id_customer>
        <id_manufacturer></id_manufacturer>
        <id_supplier></id_supplier>
        <id_warehouse></id_warehouse>
        <id_country></id_country>
        <id_state></id_state>
        <numend></numend>
        <alias></alias>
        <company></company>
        <lastname></lastname>
        <firstname></firstname>
        <vat_number></vat_number>
        <address1></address1>
        <address2></address2>
        <postcode></postcode>
        <city></city>
        <other></other>
        <phone></phone>
        <phone_mobile></phone_mobile>
        <dni></dni>
        <deleted></deleted>
        <date_add></date_add>
        <date_upd></date_upd>
    </address>
</prestashop>"""
  };

  var maskFormattertelefone = new MaskTextInputFormatter(
      mask: '(##) # ####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);

  var maskFormatterCnpj = new MaskTextInputFormatter(
      mask: '##.###.###/####-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);

  var maskFormatterIE = new MaskTextInputFormatter(
      mask: '###.###.###.###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);

  var maskFormatterCEP = new MaskTextInputFormatter(
      mask: '#####-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 280, child: Image.asset("images/logo.png")),
              Text("Cadastro destinado a Pessoas Jurídicas(PJ)"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller_empresa,
                      decoration: InputDecoration(
                        labelText: "Razão Social",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_name,
                      decoration: InputDecoration(
                        labelText: "Nome do Contato",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_password,
                      obscureText: _hidden,
                      decoration: InputDecoration(
                          labelText: "Senha",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_hidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _hidden = !_hidden;
                              });
                            },
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: _hidden,
                      decoration: InputDecoration(
                          labelText: "Confirmar Senha",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_hidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _hidden = !_hidden;
                              });
                            },
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_cnpj,
                      inputFormatters: [maskFormatterCnpj],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "CNPJ",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_ie,
                      inputFormatters: [maskFormatterIE],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "IE",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_cep,
                      inputFormatters: [maskFormatterCEP],
                      decoration: InputDecoration(
                        labelText: "CEP",
                        border: OutlineInputBorder(),
                      ),
                      onEditingComplete: () {
                        getAdress(controller_cep.text);
                      },
                      onTapOutside: (event) {
                        getAdress(controller_cep.text);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_rua,
                      decoration: InputDecoration(
                        labelText: "Rua",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_numero,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Opcional",
                        labelText: "Numero",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_bairro,
                      decoration: InputDecoration(
                        labelText: "Bairro",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_complemento,
                      decoration: InputDecoration(
                        hintText: "Opcional",
                        labelText: "Complemento",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_cidade,
                      decoration: InputDecoration(
                        labelText: "Cidade",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Estado",
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedState,
                      items: estados.map((String state) {
                        return DropdownMenuItem<String>(
                          value: state,
                          child: Text(state),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedState = newValue;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller_telefone,
                      inputFormatters: [maskFormattertelefone],
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Telefone",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          password = controller_password.text;
                          cnpj = controller_cnpj.text;
                          ie = controller_ie.text;
                          nome_resp = controller_name.text;
                          nome_empresa = controller_empresa.text;
                          email = controller_email.text;
                        });
                        var url_customer = Uri.parse(
                            "https://b2b.redemachado.com.br/api/customers/");
                        var url_address = Uri.parse(
                            "https://b2b.redemachado.com.br/api/addresses/");
                        var response = await http.post(url_customer,
                            headers: {
                              HttpHeaders.authorizationHeader: "Basic $auth"
                            },
                            body: xml_customer);
                        print(response.statusCode);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        "Criar Conta",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(55),
                          backgroundColor: Color.fromARGB(255, 247, 147, 26),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("OU"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Já tem uma conta?",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 247, 147, 26),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  void getAdress(String cep_busca) async {
    var endereco_cep = Uri.parse("http://viacep.com.br/ws/$cep_busca/xml/");
    var response = await http.get(endereco_cep,
        headers: {HttpHeaders.authorizationHeader: "Basic $auth"});
    final document = xml.XmlDocument.parse(response.body);
    final xmlcep = document.findElements('xmlcep').first;
    final logradouro = xmlcep.findElements("logradouro").first.text;
    final bairro = xmlcep.findElements('bairro').first.text;
    final localidade = xmlcep.findElements('localidade').first.text;

    setState(() {
      controller_rua.text = logradouro;
      controller_bairro.text = bairro;
      controller_cidade.text = localidade;
    });
  }
}
