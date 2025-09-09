import 'package:flutter/material.dart';
import 'package:flutter_templat/ui/views/ai_boots/ai_boots_without_rasa/chat_serv.dart';
import 'package:flutter_templat/ui/views/ai_boots/ai_boots_without_rasa/inv_card.dart';

class PartyPlannerScreen extends StatefulWidget {
  @override
  _PartyPlannerScreenState createState() => _PartyPlannerScreenState();
}

class _PartyPlannerScreenState extends State<PartyPlannerScreen> {
  final List<String> partyTypes = ['عيد ميلاد', 'تخرج', 'خطوبة'];
  final List<String> foodOptions = ['عربية', 'غربية', 'نباتية', 'بحرية'];

  final _formKey = GlobalKey<FormState>();
  String? _partyType;
  final _guestController = TextEditingController();
  final _budgetController = TextEditingController();
  List<String> _foodPreferences = [];
  final _placeController = TextEditingController();

  bool _isLoading = false;
  String? _responseText;

  // دالة الارسال موجودة هنا داخل ال State
  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _responseText = null;
    });

    final prompt = '''
أريد خطة لحفل $_partyType لـ ${_guestController.text} ضيف
مع ميزانية ${_budgetController.text} دولار.
تفضيلات الطعام: ${_foodPreferences.join(', ')}.
المكان: ${_placeController.text}.
من فضلك قدم لي خطة مفصلة مع اقتراحات للديكور، الطعام، والفعاليات.
''';

    try {
      String result = await GeminiService().getGeminiResponse([
        {'text': prompt, 'isMe': true},
      ]);

      setState(() {
        _responseText = result;
      });

      final createInvite = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('إنشاء بطاقة دعوة'),
          content: Text('هل ترغب في إنشاء بطاقة دعوة ومشاركتها؟'),
          actions: [
            TextButton(
              child: Text('لا'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: Text('نعم'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );

      if (createInvite == true) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => InvitationCardScreen()));
      }
    } catch (e) {
      setState(() {
        _responseText = "حدث خطأ: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _guestController.dispose();
    _budgetController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تخطيط الحفلة التفاعلي')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'نوع الحفل'),
                      items: partyTypes
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _partyType = val;
                        });
                      },
                      validator: (val) =>
                          val == null ? 'يرجى اختيار نوع الحفل' : null,
                    ),
                    TextFormField(
                      controller: _guestController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'عدد الضيوف'),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'يرجى إدخال عدد الضيوف';
                        }
                        if (int.tryParse(val) == null) {
                          return 'يرجى إدخال رقم صحيح';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _budgetController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'الميزانية (بالدولار)',
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'يرجى إدخال الميزانية';
                        }
                        if (double.tryParse(val) == null) {
                          return 'يرجى إدخال رقم صحيح';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text('تفضيلات الطعام', style: TextStyle(fontSize: 16)),
                    ...foodOptions.map((option) {
                      final selected = _foodPreferences.contains(option);
                      return CheckboxListTile(
                        title: Text(option),
                        value: selected,
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              _foodPreferences.add(option);
                            } else {
                              _foodPreferences.remove(option);
                            }
                          });
                        },
                      );
                    }).toList(),
                    TextFormField(
                      controller: _placeController,
                      decoration: InputDecoration(labelText: 'مكان الحفل'),
                      validator: (val) => val == null || val.isEmpty
                          ? 'يرجى إدخال مكان الحفل'
                          : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      child: Text('توليد خطة الحفل'),
                    ),
                    SizedBox(height: 20),
                    if (_isLoading) Center(child: CircularProgressIndicator()),
                    if (_responseText != null)
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: BoxConstraints(maxHeight: 300),
                        child: SingleChildScrollView(
                          child: Text(_responseText!),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
