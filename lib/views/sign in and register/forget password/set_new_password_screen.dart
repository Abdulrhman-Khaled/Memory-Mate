// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import 'package:memory_mate/views/sign%20in%20and%20register/sign%20in/sign_in_screen.dart';

import '../../../components/buttons.dart';
import '../../../components/text_fields.dart';
import '../../../constants/color_constatnts.dart';
import '../../../networking/dio/api/dio_client.dart';
import '../../../networking/dio/models api/patient_user_api.dart';
import '../../../networking/dio/repositories/patient_user_repsitory.dart';

// ignore: must_be_immutable
class SetNewPasswordScreen extends StatefulWidget {
  String token;
  SetNewPasswordScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  late Dio dio;

  late DioClient dioClient;

  late PatientUserApi userApi;

  late PatientUserRepository patientUserRepository;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmController = TextEditingController();

  final newPasswordFocusNode = FocusNode();
  final newPasswordConfirmFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  String validatText = 'لا يمكن ترك هذا الحقل فارغ';
  String notMatchValidatText = 'كلمة المرور غير متطابقة';

  bool obscured = false;
  bool obscured2 = false;

  SimpleFontelicoProgressDialog? prograssDialog;

  @override
  void initState() {
    super.initState();
    prograssDialog = SimpleFontelicoProgressDialog(context: context);
    obscured = true;
    obscured2 = true;
  }

  Future<void> showPrograssDialog() async {
    prograssDialog!
        .show(message: "جاري التحميل...", indicatorColor: AppColors.mintGreen);
  }

  Future<void> hidePrograssDialog() async {
    prograssDialog!.hide();
  }


  @override
  Widget build(BuildContext context) {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: AppColors.mintGreen,
        ),
        centerTitle: true,
        title: const Text(
          'إنشاء كلمة مرور جديدة',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                  image: AssetImage('assets/images/pictures/sign_up.jpeg')),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                  isMatch: true,
                  isLength: true,
                  isRegex: true,
                  width: 300,
                  hintText: '•••••••••••••••••',
                  labelText: 'كلمة المرور',
                  helperText: 'أدخل كلمة مرور للدخول الي حسابك',
                  textType: TextInputType.visiblePassword,
                  iconLead: Icons.lock_outlined,
                  textFormController: newPasswordController,
                  matchPassword: newPasswordConfirmController.text,
                  thisPasssword: newPasswordController.text,
                  focusNode: newPasswordFocusNode,
                  validatText: validatText,
                  needSuffix: true,
                  isPassword: obscured,
                  iconSuffix: obscured
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  function: () {
                    setState(() {
                      obscured = !obscured;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                  isMatch: true,
                  isLength: true,
                  isRegex: true,
                  width: 300,
                  textFormController: newPasswordConfirmController,
                  focusNode: newPasswordConfirmFocusNode,
                  hintText: '•••••••••••••••••',
                  labelText: 'تأكيد كلمة المرور',
                  helperText: 'أدخل كلمة المرور مرة اخري للتأكيد',
                  iconLead: Icons.lock_outline,
                  textType: TextInputType.visiblePassword,
                  matchPassword: newPasswordController.text,
                  thisPasssword: newPasswordConfirmController.text,
                  validatText: validatText,
                  needSuffix: true,
                  isPassword: obscured2,
                  iconSuffix: obscured2
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  function: () {
                    setState(() {
                      obscured2 = !obscured2;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              filledButton(
                  width: 300,
                  height: 50,
                  buttonText: 'التالي',
                  buttonColor: AppColors.mintGreen,
                  function: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (formKey.currentState!.validate() &&
                        newPasswordController.value.text ==
                            newPasswordConfirmController.value.text) {
                      try {
                        showPrograssDialog();
                        await patientUserRepository.postSetNewPasswordRequest(
                            newPasswordController.value.text, widget.token);

                        hidePrograssDialog();
                        Fluttertoast.showToast(
                            msg:
                                'تم تعيين كلمة مرور جديدة بنجاح قم بتسجيل الدخول الان',
                            backgroundColor: AppColors.mintGreen);

                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const SignIn()),
                            (Route<dynamic> route) => false);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  'حدث خطأ غير متوقع يرجي إعادة المحاولة')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                'هناك خطأ في البيانات يرجي إعادة المحاولة')),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
