import 'package:get/get.dart';

class AppLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          "update": "يتوفر تحديث جديد",
          "updatecontent": "يرجى تحديث التطبيق للاستمرار في الاستخدام",
          "updatebutton": "تحديث الان",
          // login signup
          'logintitle': 'افضل دليل الكتروني لرحلاتك السياحية',
          'phonenum': 'رقم الهاتف',
          'password': 'كلمة السر',
          'login': 'تسجيل الدخول',
          'forgetpassword': 'هل نسيت كلمة السر؟',
          'donothaveaccount': 'مستخدم جديد؟',
          'signup': 'التسجيل الان',
          'passwordhint': 'يجب ان لا تقل كلمة السر عن 8 احرف',
          'fname': 'الاسم الاول',
          'lname': 'الاسم الاخير',
          'email': 'البريد الالكتروني',
          'confirmpassword': 'تأكيد كلمة السر',
          'register': 'تسجيل الحساب',
          'haveaccount': 'لديك حساب بالفعل؟',
          'confpasswordhint': 'اعد كتابة كلمة السر',
          'registertitle':
              '" الحياة قصيرة والعالم واسع\n   لا تضيع الفرص لاكتشافه "',
          "loading": "جاري التحميل",
          "namevalidation": "يجب ان لا يقل الاسم عن 3 حروف ولا يزيد عن 12",
          "emailvalidation": "يجب ان يكون البريد الالكتروني صحيح",
          "phonevalidation": "يجب ان يكون رقم الهاتف صحيح",
          "passwordvalidation": "كلمة السر غير متطابقة",
          "error": "حدث خطأ ما",
          "emailexist": "هذا الايميل مستخدم بالفعل",
          "phoneexist": "رقم الهاتف مستخدم بالفعل",
          "usernotexist": "رقم الهاتف غير مسجل او كلمة السر خاطئة",
          "success": "تم التسجيل بنجاح\nيمكنك الان تسجيل الدخول",
          "loginsuccess": "تم تسجيل الدخول بنجاح",
          // countries
          "IRAQ": "العراق",
          "TURKEY": "تركيا",
          "EGYPT": "مصر",
          "SAUDI_ARABIA": "السعودية",
          "UNITED_ARAB_EMIRATES": "الإمارات",
          "SYRIA": "سوريا",
          "LEBANON": "لبنان",
          "IRAN": "إيران",
          "TUNISIA": "تونس",
          "OMAN": "عُمان",
          "MALAYSIA": "ماليزيا",
          "INDONESIA": "إندونيسيا",
          "GEORGIA": "جورجيا",
          "AZERBAIJAN": "أذربيجان",
          "SRILANKA": "سريلانكا",
          "ARMENIA": "أرمينيا",
          "THAILAND": "تايلند",
          "choosecountry": "اختر المدينة",
          // categories
          "holyplace": "اماكن مقدسة",
          "stayplace": "اماكن اقامة",
          "restaurant": "مطاعم",
          "mall": "مراكز تسوق",
          "sport": "اماكن رياضية",
          "salons": "صالونات",
          "touristplace": "اماكن سياحية",
          "healthcenter": "مراكز صحية",
          "cafe": "مقاهي",
          "financial": "الخدمات المالية",
          "gasstation": "محطات وقود",
          "entertainment": "اماكن ترفيهية",
          "sweets": "حلويات ومرطبات",
          "western": "وجبات غربية",
          "eastern": "وجبات شرقية",
          "fastfood": "وجبات سريعة",
          "hotel": "فندق",
          "farm": "مزرعة",
          "flat": "شقة",
          "house": "بيت",
          "chalet": "شاليه",
          "resort": "منتجع",
          "malls": "مول",
          "supermarket": "سوبر ماركت",
          "electronic": "اجهزة الكترونية",
          "jewelry": "مجوهرات",
          "Fragrances": "عطور",
          "fragrances": "عطور",
          "makeup": "مستحضرات تجميل",
          "clothesmen": "ملابس رجال",
          "clotheswomen": "ملابس نساء",
          "hospital": "مستشفى",
          "clinic": "عيادة",
          "pharmacy": "صيدلية",
          "vet": "طبيب بيطري",
          "mosque": "جامع",
          "church": "كنيسة",
          "sepulchre": "مرقد",
          "bank": "بنك",
          "exchange": "صرافة",
          "outlet": "منفذ",
          "cityland": "مدينة العاب",
          "park": "منتزه",
          "game_center": "العاب الكترونية",
          "waterslides": "مدينة مائية",
          "stadium": "ملعب",
          "gym": "نادي رياضي",
          "swimming_pool": "مسبح",
          "barber": "حلاق رجالي",
          "salon": "صالون نسائي",
          "beauty_center": "مركز تجميل",
          "all": "الكل",
          "notfounds": "لا يوجد",
          "high": "الأعلى سعراً",
          "low": "الأقل سعراً",
          // home screen
          "showmore": "اظهار الكل",
          "recommed": "ينصح بزيارتها",
          "cities": "المحافضات",
          "showads": "عرض الاعلان",
          "wantads": "ترغب بالاعلان داخل التطبيق",
          "adscontactb": "تواصل مع الدعم",
          "adscontact": "تواصل معنا لاضافة اعلانك الان",
          "notavilable": "لايوجد محتوى الان\nنعمل على اضافته قريبا",
          "latest": "اخر الاضافات",
          "offers": "عروض وخصومات",
          "highrate": "الاعلى تقييما",
          // navbar
          "navsearch": "البحث",
          "navprofile": "حسابي",
          "navhome": "الرئيسية",
          "navlatest": "اخر الاضافات",
          "booking": "حجز رحلة",
          "navsetting": "الإعدادات",
          // filter screen
          "filter": "تخصيص البحث",
          "choosecity": "اختر المدينة",
          "allcitiescheck": "جميع المدن",
          "choosecate": "اختر تصنيف المكان",
          "allcatecheck": "جميع التصنيفات",
          "searchrequired": "للبحث قم بأدخال 3 احرف على الاقل",
          "notfound": "لم يتم العثور على نتائج مطابقة لبحثك",
          // profile screen
          "editprofile": "تعديل الحساب",
          "logout": "تسجيل الخروج",
          "bookmark": "المفضلة",
          "pchangepass": "تغيير كلمة السر",
          "myreview": "اماكن قمت بتقييمها",
          "merchainadtitle": "هل ترغب في إضافة عملك أو الإعلان هنا؟",
          "merchainadtext": "اضغط هنا لتغيير حسابك الى نشاط تجاري",
          "merchainadbutton": "تغيير إلى نشاط تجاري",
          "areyousure": "هل انت متأكد؟",
          "changeprofilepic": "تغيير الصورة الشخصية",
          "savepic": "حفظ الصورة",
          "changepic": "استبدال الصورة",
          "ismerchant": "حساب تجاري",
          "daytoexpire": " يوم باقي على انتهاء الاشتراك",
          "busactive": "نشاطك التجاري",
          "noplaceyet": "لم تقم بأضافة نشاط تجاري بعد",
          "clicktoaddplace": "اضغط هنا لأضافته الان",
          "undo": "الغاء التغييرات",
          "editsuccess": "تم تعديل معلومات الحساب",
          "orginalpasserr": "يرجى كتابة كلمة السر الحالية",
          "newpassword": "كلمة السر الجديدة",
          "orginalpassword": "كلمة السر الحالية",
          "changepasssuccess": "تم تغيير كلمة السر بنجاح",
          "orgpasserr": "كلمة السر الحالية غير صحيحة",
          // place screen
          "review": "التقييمات",
          "noreviewfound": "لا يوجد تقييمات بعد\nمارأيك بالمكان انت؟",
          "addreview": "اضافة تقييم",
          "commentby": "التعليق بأسم",
          "deletecommet": "حذف التعليق",
          "deletecommentinfo": "هل انت متأكد من حذف هذا التعليق؟",
          "reportcomment": "ابلاغ عن التعليق",
          "reportcommentinfo": "هل انت متأكد من الابلاغ عن هذا التعليق؟",
          "yes": "نعم",
          "no": "كلا",
          "reviewerrortitle": "خطأ",
          "reviewerror": "يجب ان لا يقل التعليق عن 8 احرف ولا يزيد عن 400",
          "callnow": "اتصل الان",
          "deletereverror": "حدث خطأ ما اعد المحاولة فيما بعد",
          "reviewresulterror": "قمت بتقييم هذا المكان من قبل",
          "reviewresult": "تم اضافة التعليق بنجاح",
          "deletrevsuccess": "تم حذف التعليق بنجاح",
          "reportrevsuccess": "تم الابلاغ عن التعليق بنجاح",
          "reviewcreatesure": "هل انت متأكد من اضافة هذا التقييم؟",
          "social": "مواقع التواصل",
          "availabe": "متوفر",
          "noreview": "لم تقم بتقييم اي مكان بعد\nمارأيك بالبدء الان؟",
          "notavailabe": "غير متوفر",
          "price": "السعر",
          "share": "مشاركة",
          "description": "المزيد من المعلومات",
          "location": "الموقع على الخريطة",
          // settings screen
          "language": "لغة التطبيق",
          "terms": "الشروط وسياسة الاستخدام",
          "about": "عن التطبيق",
          "support": "للتواصل والحجز",
          "emer": "ارقام الطوارئ",
          "callus": "اتصل بنا",
          "contactus": "تواصل مع الدعم",
//search screen
          "search": "البحث",
          // advice screen
          "highest_rated": "الاعلى تقييما",
          "nearestplaces": "الاماكن القريبة",
          // booking Screen
          "bookingtitle": "احجز رحلتك الان بأفضل الاسعار 😍",
          "bookingcontent":
              "يتيح لك تطبيق ڤيو الحجز المباشر لرحلاتك السياحية\nمع افضل الشركات وبأسعار مناسبة وتنافسية",
          "choosecitybooking":
              "ماذا تنتظر؟ اختر مدينتك واكتشف وجهتك السياحية القادمة.",
          "choscity": "اختر مدينتك",
          "tripdetails": "تفاصيل الرحلة",
          "tripshortdetails": "حول الرحلة",
          "tripsavilable": "الرحلات المتاحة",
          "companyinfo": "معلومات الشركة",
          "companysocialmedia": "مواقع الالكترونية للشركة",
          "bookanddetails": "التفاصيل والحجز",
          // merchant screen
          "pname": "اسم المكان",
          "pdescription": "وصف المكان",
          "plocation": "الموقع على الخريطة",
          "pcontact": "رقم الهاتف",
          "psocialmedia": "مواقع التواصل",
          "psocialmediaex": "استعمل روابط صالحة لمواقع التواصل",
          "pprice": "السعر التقديري",
          "pavilable": "معلومات اتاحة او توفر المكان",
          "pavilableex": "مثال :  متوفر طيلة ايام الاسبوع",
          "pcountry": "الدولة",
          "pcity": "المدينة",
          "pshortlocation": "العنوان المختصر",
          "pshortlocationex": "مثال :  العراق - بغداد - الكرادة",
          "ptype": "نوع المكان",
          "psubtype": "تصنيف المكان",
          "saveplace": "حفظ التغييرات",
          "editinfo": "تعديل المعلومات",
          "editimage": "تعديل الصور",
          "pimagesempty": "لم تقم بأضافة اي صور لنشاطك بعد",
          "paddnew": "اضافة نشاط تجاري",
          "pcheckterms": "لقد قرأت",
          "pcheckterms2": "وسألتزم بها",
          "youmustagree": "يجب الموافقة على الشروط وسياسة الاستخدام",
          "addplacenow": "اضافة نشاطي التجاري",
          "descriptionvalidation": "يجب ان لا يقل الوصف عن 20 حرف",
          "emptyfield": "لا يمكن ترك الحقل فارغ",
          "placenamevalidation": "يجب ان لا يقل اسم النشاط عن 3 حروف",
          "requiredfiled":
              "* ملاحظة: هذا الحقل لا يمكن تعديله بعد اضافة النشاط",
          "setlocationonmap": "تعيين الموقع على الخريطة",
          "placeaddsuc": "تم اضافة نشاطك التجاري بنجاح",
          "placeadderr": "حدث خطأ ما اعد المحاولة فيما بعد",
          "areyousure2": "هل انت متأكد من اضافة هذا النشاط؟",
          "importnote": "!بعض الحقول لا يمكن تعديلها مرة اخرى",
          "addnewpic": "اضافة صورة جديدة",
        },
        'en': {
          "update": "New update available",
          "updatecontent": "Please update the app to continue using it",
          "updatebutton": "Update Now",
          // login signup
          'logintitle': 'The Best Guide For Your Travel',
          'phonenum': 'Phone Number',
          'password': 'Password',
          'login': 'Login',
          'forgetpassword': 'Forget Password?',
          'donothaveaccount': 'Don\'t have an account?',
          'signup': 'Register',
          'passwordhint': 'Password must be at least 8 characters',
          'fname': 'First Name',
          'lname': 'Last Name',
          'email': 'Email',
          "phonevalidation": "Please enter a valid phone number",
          'confirmpassword': 'Confirm Password',
          'register': 'Register',
          'haveaccount': 'Already have an account?',
          'confpasswordhint': 'Enter your password again',
          'registertitle': '" Life Is Short And\n  The World Is Wide "',
          "loading": "Loading...",
          "namevalidation": "The name must be between 3 and 12 characters",
          "emailvalidation": "Please enter a valid email",
          "passvalidation": "Password Not Match",
          "passwordvalidation": "Please enter a valid phone number",
          "phoneexist": "This phone number is already registered",
          "emailexist": "This email is already registered",
          "usernotexist":
              "This phone number is not registered Or Password is wrong",
          "error": "Something went wrong",
          "success": "Registered successfully Go To Login Now",
          "loginsuccess": "Logged in successfully",
          // countries
          "IRAQ": "Iraq",
          "TURKEY": "Turkey",
          "EGYPT": "Egypt",
          "SAUDI_ARABIA": "Saudi Ar",
          "UNITED_ARAB_EMIRATES": "Emirates",
          "SYRIA": "Syria",
          "LEBANON": "Lebanon",
          "IRAN": "Iran",
          "TUNISIA": "Tunisia",
          "OMAN": "Oman",
          "MALAYSIA": "Malaysia",
          "INDONESIA": "Indonesia",
          "GEORGIA": "Georgia",
          "AZERBAIJAN": "Azerbaijan",
          "SRILANKA": "SriLanka",
          "ARMENIA": "Armenia",
          "THAILAND": "Thailand",
          "choosecountry": "Choose City",
          // categories
          "holyplace": "Holy Places",
          "stayplace": "Stay Places",
          "restaurant": "Restaurants",
          "mall": "Shop Places",
          "sport": "Sport Places",
          "salons": "Salons",
          "touristplace": "Tourist Places",
          "healthcenter": "Health Care Centers",
          "cafe": "Coffee Shops",
          "financial": "Financial Service",
          "gasstation": "Gas Station",
          "entertainment": "Entertainment",
          "sweets": "Sweets",
          "western": "Western Food",
          "eastern": "Eastern Food",
          "fastfood": "Fast Food",
          "hotel": "Hotel",
          "farm": "Farm",
          "flat": "Flat",
          "house": "House",
          "chalet": "Chalet",
          "resort": "Resort",
          "malls": "Mall",
          "supermarket": "Supermarket",
          "electronic": "Electronics",
          "jewelry": "Jewelry",
          "Fragrances": "Fragrances",
          "makeup": "Makeup",
          "clothesmen": "Men Clothes",
          "clotheswomen": "Women Clothes",
          "hospital": "Hospital",
          "clinic": "Clinic",
          "pharmacy": "Pharmacy",
          "vet": "Vet",
          "mosque": "Mosque",
          "church": "Church",
          "sepulchre": "Sepulchre",
          "bank": "Bank",
          "exchange": "Exchange",
          "outlet": "Outlet",
          "cityland": "City Land",
          "park": "Park",
          "game_center": "Game Center",
          "waterslides": "Water Slides",
          "stadium": "Stadium",
          "gym": "Gym",
          "swimming_pool": "Swimming Pool",
          "barber": "Barber",
          "salon": "Salon",
          "beauty_center": "Beauty Center",
          "all": "All",
          "notfounds": "Not Found",
          "high": "Price High To Low",
          "low": "Price Low To High",
          // home screen
          "showmore": "Show All",
          "recommed": "Recommended Places",
          "cities": "Cities",
          "showads": "Show Ads",
          "wantads": "Would You Like To Advertise Here",
          "adscontactb": "Contact support",
          "adscontact": "Contact us to add your Ad now",
          "notavilable": "Not Available Yet",
          "latest": "Latest Added",
          "offers": "Offers",
          "highrate": "Highest Rated",
          // navbar
          "navsearch": "Search",
          "navprofile": "Profile",
          "navhome": "Home",
          "navlatest": "Lastest Added",
          "booking": "Booking",
          "navsetting": "Settings",
          // filter screen
          "filter": "Customize Your Search",
          "choosecity": "Choose City",
          "allcitiescheck": "All Cities",
          "choosecate": "Choose Category",
          "allcatecheck": "All Categories",
          "notfound": "No matching results found for your search",
          "searchrequired": "Please enter at least 3 characters",
          // profile screen
          "editprofile": "Edit Profile",
          "logout": "Logout",
          "bookmark": "Bookmark",
          "pchangepass": "Change Password",
          "myreview": "My Reviews",
          "merchainadtitle": "Want To Add Your Business Or Advertise Here?",
          "merchainadtext":
              "Click Here To Change Your Account To Merchant Account",
          "merchainadbutton": "Change To Merchant Account",
          "areyousure": "Are You Sure You Want To Logout?",
          "changeprofilepic": "Change Profile Picture",
          "savepic": "Save Picture",
          "changepic": "Change Picture",
          "ismerchant": "Merchant Account",
          "daytoexpire": " days until subscription ends",
          "busactive": "Your business activity",
          "noplaceyet": "You haven't added any business activity yet",
          "clicktoaddplace": "Click here to add it now",
          "undo": "Undo Changes",
          "editsuccess": "Update Profile Information Successfully",
          "orginalpasserr": "Please Enter The Current Password",
          "orginalpassword": "Current Password",
          "newpassword": "New Password",
          "changepasssuccess": "Password Change Successfully",
          "orgpasserr": "The current password is incorrect",
          // place screen
          "review": "Reviews",
          "noreviewfound": "No Reviews Found\nBe The First To Review",
          "addreview": "Add Review",
          "nearestplaces": "Nearest Places",
          "commentby": "Comment By",
          "deletecommet": "Delete Comment",
          "deletecommentinfo": "Are You Sure You Want To Delete This Comment?",
          "reportcomment": "Report",
          "reportcommentinfo": "Are You Sure You Want To Report This Comment?",
          "yes": "Yes",
          "no": "No",
          "reviewerrortitle": "Error",
          "reviewerror": "You most enter at least 8 characters and maximum 400",
          "callnow": "Call Now",
          "reviewresulterror": "You Already Reviewed This Place",
          "deletereverror": "Something Went Wrong",
          "reviewresult": "Review Added Successfully",
          "deletrevsuccess": "Review Deleted Successfully",
          "reportrevsuccess": "Review Reported Successfully",
          "reviewcreatesure": "Are You Sure You Want To Add This Review?",
          "social": "Social Media",
          "availabe": "Available",
          "notavailabe": "Not Available",
          "noreview": "You Have No Reviews Yet",
          "share": "Share",
          "price": "Price",
          "description": "More Details",
          "location": "Location On Map",
          // settings screen
          "language": "App Language",
          "terms": "Terms & Conditions",
          "about": "About Us",
          "support": "Contact Us",
          "emer": "Emergency Numbers",
          "MilitaryI": "Military Intelligence",
          "FamilyP": "Family Protection",
          "callus": "Call Us",
          "contactus": "Contact Us",
//search screen
          "search": "Search",
          // advice screen
          "highest_rated": "Highest Rated",
          "recommended_places": "Recommended Places",
          // booking Screen
          "bookingtitle": "Book Your Trip Now at the Best Prices 😍",
          "bookingcontent":
              "The View app allows you to directly book\nyour travel journeys with the best companies at affordable and competitive prices",
          "choosecitybooking":
              "Why wait? Choose your city and uncover your next tourist destination",
          "choscity": "Choose Your City",
          "tripdetails": "Trip Details",
          "tripshortdetails": "About The Trip",
          "tripsavilable": "Available Trips",
          "companysocialmedia": "Company Social Media",
          "companyinfo": "About Company",
          "bookanddetails": "Booking & Details",
          // merchant screen

          "pname": "Place Name",
          "pdescription": "Place Description",
          "plocation": "Location on the Map",
          "pcontact": "Phone Number",
          "psocialmedia": "Social Media",
          "psocialmediaex": "Use valid links for social media sites",
          "pprice": "Estimated Price",
          "pavilable": "Availability Information",
          "pavilableex": "Example: Available throughout the week",
          "pcountry": "Country",
          "pcity": "City",
          "pshortlocation": "Short Address",
          "pshortlocationex": "Example: Iraq - Baghdad - Karada",
          "ptype": "Place Type",
          "psubtype": "Place Category",
          "saveplace": "Save Changes",
          "editinfo": "Edit Information",
          "editimage": "Edit Images",
          "pimagesempty": "You haven't added any images yet",
          "paddnew": "Add Business Activity",
          "pcheckterms": "I have read the ",
          "pcheckterms2": "and agree to them",
          "addplacenow": "Save My Business Activity",
          "youmustagree": "You must agree to the terms and conditions",
          "descriptionvalidation":
              "The description must be at least 20 characters",
          "emptyfield": "Field cannot be left empty",
          "placenamevalidation":
              "The Business Activity name must be at least 3 characters",
          "requiredfiled":
              "* Note: This field cannot be change after adding the activity",
          "setlocationonmap": "Set Location On Map",
          "placeaddsuc": "Your Business Activity Added Successfully",
          "placeadderr": "Something Went Wrong",
          "areyousure2": "Are You Sure To Add This Business Activity?",
          "importnote": "Some fields cannot be changed again!",
          "addnewpic": "Add New Picture",
        },
      };
}
