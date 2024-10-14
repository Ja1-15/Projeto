import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _hidden = true;

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Razão Social",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Nome do Contato",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Opcional",
                        labelText: "Empresa",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Opcional",
                        labelText: "Número de Identificação",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
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
                      decoration: InputDecoration(
                        labelText: "CNPJ",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "IE",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "CEP",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Endereço",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                      decoration: InputDecoration(
                        labelText: "Bairro",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                      decoration: InputDecoration(
                        labelText: "Telefone",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
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
}
