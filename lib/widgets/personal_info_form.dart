import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorbikes_rent/models/address.dart';
import 'package:motorbikes_rent/models/customer.dart';

class PersonalInfoForm extends StatefulWidget {
  final Customer? customer;
  final Function createCustomer;
  const PersonalInfoForm(
      {super.key, this.customer, required this.createCustomer});

  @override
  PersonalInfoFormState createState() => PersonalInfoFormState();
}

class PersonalInfoFormState extends State<PersonalInfoForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _birthDate = '';
  String _address = '';
  String _city = '';
  String _state = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Row(children: [
                Text('Meus Dados',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22))
              ]),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onSaved: (value) {
                  _name = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu primeiro nome';
                  }
                  return null;
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(text: _birthDate),
                      decoration: const InputDecoration(
                        labelText: 'Data de nascimento',
                        helperText: 'DD/MM/YYYY',
                      ),
                      readOnly: true,
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            _birthDate = DateFormat('dd/MM/y').format((picked));
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua data de aniversário';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Endereço',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Address'),
                      onSaved: (value) {
                        _address = value!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua rua';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Bairro'),
                            onSaved: (value) {
                              _city = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu bairro';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration:
                                const InputDecoration(labelText: 'Estado'),
                            items: <String>['State 1', 'State 2', 'State 3']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _state = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu estado';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.createCustomer(Customer(
                          _name,
                          '',
                          DateTime.parse(DateFormat('dd/MM/y')
                              .parse(_birthDate)
                              .toString()),
                          Address(_address, _city, _state)));
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
