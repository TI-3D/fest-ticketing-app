import 'dart:io';
import 'package:fest_ticketing/common/enitites/event_class.dart';
import 'package:fest_ticketing/features/event_organizer/domain/usecase/create_event.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/bloc/event_creation/event_creation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadEventScreen extends StatefulWidget {
  const UploadEventScreen({Key? key}) : super(key: key);

  @override
  _UploadEventScreenState createState() => _UploadEventScreenState();
}

class _UploadEventScreenState extends State<UploadEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _eventDescriptionController = TextEditingController();
  XFile? _eventImage;
  final ImagePicker _picker = ImagePicker();
  String? _selectedCategory;
  List<EventClassField> _eventClasses = [EventClassField()];

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDateController.dispose();
    _eventLocationController.dispose();
    _eventDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _eventImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event Request'),
        centerTitle: true,
      ),
      body: BlocListener<EventCreationBloc, EventCreationState>(
        listener: (context, state) {
          if (state is EventCreationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Event created successfully!')),
            );
            _resetForm();
          } else if (state is EventCreationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to create event: ${state.message}')),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageUploadSection(),
                const SizedBox(height: 16),
                _buildTextField(_eventNameController, 'Event Name'),
                const SizedBox(height: 16),
                _buildDateField(),
                const SizedBox(height: 16),
                _buildTextField(_eventLocationController, 'Event Location'),
                const SizedBox(height: 16),
                _buildCategoryDropdown(),
                const SizedBox(height: 16),
                _buildTextField(
                    _eventDescriptionController, 'Event Description',
                    maxLines: 4),
                const SizedBox(height: 16),
                _buildEventClassesSection(),
                const SizedBox(height: 24),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: _eventImage == null
            ? _buildImagePlaceholder()
            : _buildImagePreview(),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Center(
      child: Text('Upload Event Image',
          style: TextStyle(color: Colors.grey.shade600)),
    );
  }

  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        File(_eventImage!.path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      maxLines: maxLines,
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _eventDateController,
      decoration: InputDecoration(
        labelText: 'Event Date',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: true,
      onTap: _selectDate,
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select event date' : null,
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Event Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      value: _selectedCategory,
      items: ['Category 1', 'Category 2', 'Category 3'].map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
      validator: (value) =>
          value == null ? 'Please select event category' : null,
    );
  }

  Widget _buildEventClassesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Event Classes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ..._eventClasses.map((classField) => Column(
              children: [
                classField,
                const Divider(color: Colors.grey, thickness: 1, height: 20),
              ],
            )),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _eventClasses.add(EventClassField());
            });
          },
          child: const Text('Add Event Class'),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitEventRequest,
      child: const Text('Submit'),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _eventDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _submitEventRequest() {
    if (_formKey.currentState!.validate()) {
      if (_eventImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload an event image')),
        );
        return;
      }

      // Create event request parameters
      final params = CreateEventRequestParams(
        name: _eventNameController.text,
        description: _eventDescriptionController.text,
        location: _eventLocationController.text,
        date: _eventDateController.text,
        categories: [_selectedCategory!],
        eventClasses: _eventClasses.map((classField) {
          return EventClassEntity(
            eventClassId: 'event_class_id',
            eventId: 'event_id',
            className: classField.classNameController.text,
            basePrice: double.parse(classField.basePriceController.text),
            count: int.parse(classField.countController.text),
            description: '',
          );
        }).toList(),
        eventImage: _eventImage,
      );

      // Dispatch event creation
      context.read<EventCreationBloc>().add(EventCreationSubmit(params));
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _eventImage = null;
      _selectedCategory = null;
      _eventNameController.clear();
      _eventDateController.clear();
      _eventLocationController.clear();
      _eventDescriptionController.clear();
      _eventClasses = [EventClassField()];
    });
  }
}

class EventClassField extends StatelessWidget {
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController basePriceController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final bool canDelete;
  final VoidCallback? onDelete;

  EventClassField({Key? key, this.canDelete = false, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: classNameController,
          decoration: InputDecoration(
            labelText: 'Class Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter class name';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: basePriceController,
          decoration: InputDecoration(
            labelText: 'Base Price',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter base price';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: countController,
          decoration: InputDecoration(
            labelText: 'Count Tickets',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter count';
            }
            return null;
          },
        ),
        if (canDelete)
          TextButton(
            onPressed: onDelete,
            child:
                const Text('Remove Class', style: TextStyle(color: Colors.red)),
          ),
      ],
    );
  }
}
