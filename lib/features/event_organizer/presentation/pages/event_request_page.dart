// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';

// class EventRequestForm extends StatefulWidget {
//   const EventRequestForm({Key? key}) : super(key: key);

//   @override
//   _EventRequestFormState createState() => _EventRequestFormState();
// }

// class _EventRequestFormState extends State<EventRequestForm> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   final _eventNameController = TextEditingController();
//   final _eventDateController = TextEditingController();
//   final _eventLocationController = TextEditingController();
//   final _eventDescriptionController = TextEditingController();

//   // Focus nodes untuk navigasi antar field
//   final _eventNameFocus = FocusNode();
//   final _eventDateFocus = FocusNode();
//   final _eventLocationFocus = FocusNode();
//   final _eventDescriptionFocus = FocusNode();

//   // Image picker
//   File? _eventImage;
//   final ImagePicker _picker = ImagePicker();

//   // Event Categories
//   final List<String> _eventCategories = [
//     'Conference',
//     'Workshop',
//     'Seminar',
//     'Networking',
//     'Other'
//   ];
//   String? _selectedCategory;

//   @override
//   void dispose() {
//     // Dispose controllers dan focus nodes
//     _eventNameController.dispose();
//     _eventDateController.dispose();
//     _eventLocationController.dispose();
//     _eventDescriptionController.dispose();

//     _eventNameFocus.dispose();
//     _eventDateFocus.dispose();
//     _eventLocationFocus.dispose();
//     _eventDescriptionFocus.dispose();

//     super.dispose();
//   }

//   // Event Classes
//   List<EventClassField> _eventClasses = [EventClassField()];

//   // Image Picker Method
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 1080,
//       maxHeight: 1080,
//       imageQuality: 80,
//     );

//     if (pickedFile != null) {
//       setState(() {
//         _eventImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       leading: IconButton(
//         icon: const Icon(Iconsax.arrow_left, color: Colors.black),
//         onPressed: () => Navigator.of(context).pop(),
//       ),
//       title: const Text(
//         'Create Event Request',
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       centerTitle: true,
//     );
//   }

//   Widget _buildBody() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildImageUploadSection(),
//             const SizedBox(height: 16),
//             _buildEventNameField(),
//             const SizedBox(height: 16),
//             _buildEventDateField(),
//             const SizedBox(height: 16),
//             _buildEventLocationField(),
//             const SizedBox(height: 16),
//             _buildEventCategoryDropdown(),
//             const SizedBox(height: 16),
//             _buildEventDescriptionField(),
//             const SizedBox(height: 16),
//             _buildEventClassesSection(),
//             const SizedBox(height: 24),
//             _buildSubmitButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImageUploadSection() {
//     return GestureDetector(
//       onTap: _pickImage,
//       child: Container(
//         width: double.infinity,
//         height: 200,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: _eventImage == null
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Iconsax.image, size: 50, color: Colors.grey.shade500),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Upload Event Image',
//                     style: TextStyle(color: Colors.grey.shade600),
//                   ),
//                 ],
//               )
//             : ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.file(
//                   _eventImage!,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: 200,
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget _buildEventNameField() {
//     return TextFormField(
//       controller: _eventNameController,
//       focusNode: _eventNameFocus,
//       decoration: _inputDecoration(
//         labelText: 'Event Name',
//         prefixIcon: Iconsax.document_text,
//       ),
//       textInputAction: TextInputAction.next,
//       onFieldSubmitted: (_) {
//         FocusScope.of(context).requestFocus(_eventDateFocus);
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter event name';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildEventDateField() {
//     return TextFormField(
//       controller: _eventDateController,
//       focusNode: _eventDateFocus,
//       decoration: _inputDecoration(
//         labelText: 'Event Date',
//         prefixIcon: Iconsax.calendar,
//       ),
//       readOnly: true,
//       onTap: _selectDate,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please select event date';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildEventLocationField() {
//     return TextFormField(
//       controller: _eventLocationController,
//       focusNode: _eventLocationFocus,
//       decoration: _inputDecoration(
//         labelText: 'Event Location',
//         prefixIcon: Iconsax.location,
//       ),
//       textInputAction: TextInputAction.next,
//       onFieldSubmitted: (_) {
//         FocusScope.of(context).requestFocus(_eventDescriptionFocus);
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter event location';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildEventCategoryDropdown() {
//     return DropdownButtonFormField<String>(
//       decoration: _inputDecoration(
//         labelText: 'Event Category',
//         prefixIcon: Iconsax.category,
//       ),
//       value: _selectedCategory,
//       items: _eventCategories
//           .map((category) => DropdownMenuItem(
//                 value: category,
//                 child: Text(category),
//               ))
//           .toList(),
//       onChanged: (value) {
//         setState(() {
//           _selectedCategory = value;
//         });
//       },
//       validator: (value) {
//         if (value == null) {
//           return 'Please select event category';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildEventDescriptionField() {
//     return TextFormField(
//       controller: _eventDescriptionController,
//       focusNode: _eventDescriptionFocus,
//       decoration: _inputDecoration(
//         labelText: 'Event Description',
//         prefixIcon: Iconsax.document_text,
//       ),
//       maxLines: 4,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter event description';
//         }
//         return null;
//       },
//     );
//   }

//   InputDecoration _inputDecoration({
//     required String labelText,
//     required IconData prefixIcon,
//   }) {
//     return InputDecoration(
//       labelText: labelText,
//       prefixIcon: Icon(prefixIcon, color: Colors.grey),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.red.shade800, width: 2),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Colors.red),
//       ),
//     );
//   }

//   Widget _buildSubmitButton() {
//     return ElevatedButton(
//       onPressed: _submitEventRequest,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.red.shade800,
//         minimumSize: const Size(double.infinity, 56),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Iconsax.send, color: Colors.white),
//           SizedBox(width: 8),
//           Text('Submit', style: TextStyle(color: Colors.white)),
//         ],
//       ),
//     );
//   }

//   Future<void> _selectDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         _eventDateController.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }

//   Widget _buildEventClassesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Event Classes',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 10),
//         ..._eventClasses
//             .asMap()
//             .map((index, classField) => MapEntry(
//                 index,
//                 Column(
//                   children: [
//                     classField,
//                     if (index < _eventClasses.length - 1)
//                       const Divider(
//                         color: Colors.grey,
//                         thickness: 1,
//                         height: 20,
//                       ),
//                   ],
//                 )))
//             .values
//             .toList(),
//         const SizedBox(height: 10),
//         ElevatedButton.icon(
//           onPressed: () {
//             setState(() {
//               _eventClasses.add(EventClassField(
//                 canDelete: true,
//                 onDelete: () {
//                   setState(() {
//                     if (_eventClasses.length > 1) {
//                       _eventClasses.removeLast();
//                     }
//                   });
//                 },
//               ));
//             });
//           },
//           icon: const Icon(Iconsax.add),
//           label: const Text('Add Event Class'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.red.shade50,
//             foregroundColor: Colors.red.shade800,
//           ),
//         ),
//       ],
//     );
//   }

//   void _submitEventRequest() {
//     if (_formKey.currentState!.validate()) {
//       if (_eventImage == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please upload an event image')),
//         );
//         return;
//       }

//       // Validasi event classes
//       bool isEventClassesValid = _eventClasses.every((classField) =>
//           classField.classNameController.text.isNotEmpty &&
//           classField.basePriceController.text.isNotEmpty &&
//           classField.countController.text.isNotEmpty);

//       if (!isEventClassesValid) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text('Please fill in all event class details')),
//         );
//         return;
//       }

//       // Prepare form data
//       Map<String, dynamic> formData = {
//         'name': _eventNameController.text,
//         'description': _eventDescriptionController.text,
//         'location': _eventLocationController.text,
//         'date': _eventDateController.text,
//         'categories': _selectedCategory,
//         'event_image': _eventImage,
//       };

//       // Add event classes to form data
//       _eventClasses.asMap().forEach((index, classField) {
//         formData['event_classes_class_name[$index]'] =
//             classField.classNameController.text;
//         formData['event_classes_base_price[$index]'] =
//             classField.basePriceController.text;
//         formData['event_classes_count[$index]'] =
//             classField.countController.text;
//       });

//       // Kirim data
//       print(formData);

//       // Reset form
//       _resetForm();
//     }
//   }

//   void _resetForm() {
//     _formKey.currentState!.reset();
//     setState(() {
//       _eventImage = null;
//       _selectedCategory = null;
//       _eventNameController.clear();
//       _eventDateController.clear();
//       _eventLocationController.clear();
//       _eventDescriptionController.clear();
//       _eventClasses = [EventClassField(canDelete: false)];
//     });
//   }

//   // Metode lain tetap sama seperti sebelumnya...
// }

// class EventClassField extends StatelessWidget {
//   final TextEditingController classNameController = TextEditingController();
//   final TextEditingController basePriceController = TextEditingController();
//   final TextEditingController countController = TextEditingController();
//   final bool canDelete;
//   final VoidCallback? onDelete;

//   EventClassField({Key? key, this.canDelete = false, this.onDelete})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           controller: classNameController,
//           decoration: InputDecoration(
//             labelText: 'Class Name',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter class name';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 10),
//         TextFormField(
//           controller: basePriceController,
//           decoration: InputDecoration(
//             labelText: 'Base Price',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           keyboardType: TextInputType.number,
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter base price';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 10),
//         TextFormField(
//           controller: countController,
//           decoration: InputDecoration(
//             labelText: 'Count Tickets',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           keyboardType: TextInputType.number,
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter count';
//             }
//             return null;
//           },
//         ),
//         if (canDelete)
//           TextButton(
//             onPressed: onDelete,
//             child:
//                 const Text('Remove Class', style: TextStyle(color: Colors.red)),
//           ),
//       ],
//     );
//   }
// }
