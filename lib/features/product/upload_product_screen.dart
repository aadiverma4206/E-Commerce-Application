import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/product_model.dart';
import 'product_viewmodel.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode descFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode imageFocus = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    imageController.dispose();
    nameFocus.dispose();
    descFocus.dispose();
    priceFocus.dispose();
    imageFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Upload Product",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFF00C9A7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _field(
                            controller: nameController,
                            hint: "Product Name",
                            focusNode: nameFocus,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => descFocus.requestFocus(),
                          ),
                          const SizedBox(height: 12),
                          _field(
                            controller: descController,
                            hint: "Description",
                            focusNode: descFocus,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => priceFocus.requestFocus(),
                          ),
                          const SizedBox(height: 12),
                          _field(
                            controller: priceController,
                            hint: "Price",
                            focusNode: priceFocus,
                            isNumber: true,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => imageFocus.requestFocus(),
                          ),
                          const SizedBox(height: 12),
                          _field(
                            controller: imageController,
                            hint: "Image URL",
                            focusNode: imageFocus,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _handleUpload(),
                          ),
                          const SizedBox(height: 20),
                          vm.isLoading
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _handleUpload,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    child: const Text(
                                      "Upload Product",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleUpload() async {
    final vm = context.read<ProductViewModel>();

    final name = nameController.text.trim();
    final desc = descController.text.trim();
    final price = double.tryParse(priceController.text.trim());
    final image = imageController.text.trim();

    if (name.isEmpty || desc.isEmpty || price == null || image.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    final product = ProductModel(
      id: "",
      name: name,
      description: desc,
      price: price,
      imageUrl: image,
    );

    await vm.upload(product);

    if (!mounted) return;

    if (vm.error == null) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(vm.error!)));
    }
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required FocusNode focusNode,
    required TextInputAction textInputAction,
    required Function(String) onSubmitted,
    bool isNumber = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
