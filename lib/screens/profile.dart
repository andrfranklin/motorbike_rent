import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/utils/app_routes.dart';
import 'package:motorbikes_rent/widgets/custom_app_bar.dart';
import 'package:motorbikes_rent/widgets/drawer/custom_drawer.dart';
import 'package:motorbikes_rent/widgets/layouts/base_layout.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File? _storageImage;

  _getPicture() async {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final ImagePicker picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.gallery, maxWidth: 600);

    if (image == null) return;

    setState(() {
      _storageImage = File(image.path);
    });

    final appDir = await path_provider.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storageImage!.path);
    final savedImage = await _storageImage!.copy('${appDir.path}/$fileName');
    customerProvider.setProfileImage(savedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    final profileImage = customerProvider.customer?.profileImage;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldState: _scaffoldKey,
      ),
      endDrawer: const CustomDrawer(),
      body: BaseLayout(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 100.0)),
            GestureDetector(
              onTap: _getPicture,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImage != null
                        ? FileImage(File(profileImage))
                        : null,
                    backgroundColor: Colors.black12,
                    child: profileImage == null
                        ? const Icon(
                            Icons.person_rounded,
                            size: 80,
                            color: Colors.black54,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _getPicture,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              spreadRadius: 2.0,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              customerProvider.customer!.name.toUpperCase(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Meus Dados'),
                      subtitle: const Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Divider(thickness: 1, color: Colors.black12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onTap: () {
                        // Implementar navegação para tela de Meus Dados
                      },
                    ),
                    ListTile(
                      title: const Text('Meus Aluguéis'),
                      subtitle: const Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Divider(thickness: 1, color: Colors.black12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.RENTAL_LIST);
                      },
                    ),
                    ListTile(
                      title: const Text('Minhas notificações'),
                      subtitle: const Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Divider(thickness: 1, color: Colors.black12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onTap: () {
                        // Implementar navegação para tela de Minhas notificações
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        // Implementar funcionalidade de logoutr
                      },
                      child: const Text('Sair',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
