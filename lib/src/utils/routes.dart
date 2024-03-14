class RouteNames {
  static const SPLASH_SCREEN = "splash";
  static const WELCOME_SCREEN = "welcome";
  static const PROGRAME_REGISTRATION_SCREEN = "program-registration";
  static const EVENTS_CALENDAR = "my-calendar";
  static const LANDING_SCREEN = "landing-page";
  static const LOGIN_SCREEN = "login";
  static const REGISTER_SCREEN = "register";
  static const RESET_PASSWORD_SCREEN = "reset-password";
  static const ROOT = "root";
  static const CHANGE_PASSWORD = "change-password";
  static const VERIFY_ACCOUNT = "verify";
  static const UNLOCK_SCREEN = "unlock";
  static const BMI_CALCULATOR = "bmi-calculator";
  static const PRIVACY_SETTINGS = "privacy";
  static const PROFILE_SETTINGS = "profile";
  static const PROFILE_EDIT_FORM = "profile-edit";
  static const HIV_PROGRAM = "hiv";
  static const HIV_DRUG_ORDERS = "drug-orders";
  static const HIV_ART_SITES = "art-sites";
  static const DASHBOARD = "dashboard";
  static const APPOINTMENTS = "appointments";
  static const TREATMENT_SUPPORT = "treatment-support";
  static const HIV_REGIMEN = "regimen-history";
  static const HIV_ART_GROUPS = "hiv-art-groups";
  static const HIV_ART_GROUP_DETAIL = "hiv-art-groups-detail";
  static const HIV_ART_GROUP_FORM = "hiv-art-groups-form";
  static const HIV_ART_EVENTS = "hiv-art-events";
  static const HIV_ART_EVENT_FORM = "hiv-art-event-form";
  static const HIV_ART_EVENT_DETAILS = "hiv-art-event-details";
  static const HIV_ART_APPOINTMENT_DETAILS = "hiv-art-appointment-details";
  static const HIV_ART_DELIVERY_REQUEST_FORM = "hiv-art-delivery-request-form";
  static const FACILITY_VISITS = "facility-visits";
  static const FACILITY_VISIT_DETAIL = "facility-visit-detail";
  static const VERIFY_PROGRAM_OTP = "verify-program-otp";


  static const LAB_RESULTS = "lab-results";
  static const MY_CLINIC_CARD = "clinic-card";
  static const CHAT_HCW = "chat-bot";
  static const SETTINGS = "settings";

  static const ART_DIRECTORY= "art-directory";
}

class MenuItemNames {
  static const MY_CALENDAR = "My calendar";
  static const DASHBOARD = "Dashboard";
  static const APPOINTMENTS = "Appointments";
  static const TREATMENT_SUPPORT = "Treatment Supporters";
  static const MENSTRUAL_CIRCLE = "Menstrual Circle";
  static const BMI_CALCULATOR = "BMI Calculator";
  static const HIV_PROGRAM_MENU = "ART Program";
  static const TB_PROGRAM_MENU = "TB Program";
  static const ASTHMA_PROGRAM_MENU = "Asthma";
  static const DIABETES_PROGRAM_MENU = "Diabetes";
  static const CANCER_PROGRAM_MENU = "Cancer";
  static const HYPERTENSION_PROGRAM_MENU = "Hypertension";
  static const FACILITY_VISITS = "Visits";
  static const LAB_RESULTS = "Lab Results";
  static const MY_CLINIC_CARD = "My Clinic Card";
  static const CHAT_HCW = "Nishauri Bot";
  static const ART_DIRECTORY= "Art Directory";
}

class ProgramCodeNameIds {
  static const HIV = "1";
  static const TB = "2";
  static const ASTHMA = "3";
  static const DIABETES = "4";
  static const CANCER = "5";
  static const HYPERTENSION = "6";

  static const SUPPOTED_PROGRAM_CODES = [
    HIV,
    TB,
    ASTHMA,
    DIABETES,
    CANCER,
    HYPERTENSION
  ];

  static String? getProgramNameByCode(String code) {
    final map = {
      HIV: "ART Program",
      TB: "Tuberculosis Program",
      HYPERTENSION: "Hypertension Program",
      CANCER: "Cancer Program",
      DIABETES: "Diabetes Program",
      ASTHMA: "Asthma Program",
    };
    return map[code];
  }
}
