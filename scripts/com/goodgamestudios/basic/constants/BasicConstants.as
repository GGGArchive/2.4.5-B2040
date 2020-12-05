package com.goodgamestudios.basic.constants
{
   public class BasicConstants
   {
      
      public static const LOGGEDIN_MESSAGE_TIME_INTERVAL:int = 60000;
      
      public static const POPUP_TIME_INTERVAL:int = 300000;
      
      public static const AUTOMATIC_LOADING_BAR_UPDATE_TIME:int = 2000;
      
      public static var MAX_FILESIZE_REALTIMELOADING:int = 500000;
      
      public static const NUM_RANDOM_LOADINGTEXT_ELEMENTS_AVAILABLE:uint = 20;
      
      public static const NETWORK_PARAMETER:String = "network";
      
      public static const IS_TEST_PARAMETER:String = "IS_TEST";
      
      public static const IS_LOCALE_PARAMETER:String = "IS_LOCALE";
      
      public static const CDN_URL_PARAMETER:String = "CDN_URL";
      
      public static const COUNTRY_PARAMETER:String = "country";
      
      public static const PRE_CLIENT_PARAMETER:String = "PRE_CLIENT";
      
      public static const FORCE_TO_SHOW_TEST_SERVERS:String = "forceToShowTestServers";
      
      public static const CACHE_PARAMETER:String = "cache";
      
      public static const DISTRIBUTOR_ID_PARAMETER:String = "distributorId";
      
      public static const VERSION_DATE_PARAMETER:String = "vD";
      
      public static const GAME_ID_PARAMETER:String = "gameID";
      
      public static const REFERRER_PARAMETER:String = "ref";
      
      public static const NETWORK_ID:String = "networkID";
      
      public static const PARTNER_WEBSITE:String = "w";
      
      public static const BASIC_FRAME_ONE_LOADER:String = "basicFrameOne";
      
      public static const NETWORK_INFO_LOADER:String = "networkInfo";
      
      public static const LANGUAGE_PROP_LOADER:String = "langVersion";
      
      public static const LANGUAGE_RES_LOADER:String = "languageXML";
      
      public static const ITEM_XML_LOADER:String = "itemXML";
      
      public static const ITEM_XML_VERSION:String = "itemXMLVersion";
      
      public static const ACCOUNT_COOKIE_LOADER:String = "accountCookie";
      
      public static const AB_CONFIG_LOADER:String = "AB_CONFIG_LOADER";
      
      public static const GLOBAL_COOKIE_SAVER_LOADER:String = "GLOBAL_COOKIE_SAVER_LOADER";
      
      public static const LANDING_PAGE_COOKIE_SAVER_LOADER:String = "LANDING_PAGE_COOKIE_SAVER_LOADER";
      
      public static const COUNTRY_CONFIG_LOADER:String = "countryConfigLoader";
      
      public static const PRE_ASSETS:String = "PRE_ASSETS";
      
      public static const APP_LOADER:String = "APP_LOADER";
      
      public static const CORE_TEST_FOLDER:String = "-coretest";
      
      public static const CORE_DEV_FOLDER:String = "-coredev";
      
      public static const TEST_FOLDER:String = "-test";
      
      public static const USABILITYTEST_FOLDER:String = "-usability";
      
      public static const PRECLIENT_FOLDER:String = "-preClient";
      
      public static const DEV_TEST_FOLDER:String = "-dev";
      
      public static const PRIVATE_TEST_SERVER_URL:String = "client1.test.ggs-of.net";
      
      public static const LOCALE_URL:String = "file:";
      
      private static const AGB_URL:String = "http://www.goodgamestudios.com/terms_";
      
      public static const GGS_DOMAIN:String = "goodgamestudios.com";
      
      public static const LANGUAGE_GERMAN:String = "de";
      
      public static const LANGUAGE_ENGLISH:String = "en";
      
      public static const LANGUAGE_ARABIC:String = "ar";
      
      public static const LANGUAGE_CZECH:String = "cs";
      
      public static const LANGUAGE_CHINESE_SIMPLE:String = "zh_CN";
      
      public static const LANGUAGE_CHINESE_TRADITIONAL:String = "zh_TW";
      
      public static const LANGUAGE_DANISH:String = "da";
      
      public static const LANGUAGE_DUTCH:String = "nl";
      
      public static const LANGUAGE_FINNISH:String = "fi";
      
      public static const LANGUAGE_FRENCH:String = "fr";
      
      public static const LANGUAGE_GREECE:String = "el";
      
      public static const LANGUAGE_HUNGARIAN:String = "hu";
      
      public static const LANGUAGE_ITALIAN:String = "it";
      
      public static const LANGUAGE_JAPANESE:String = "ja";
      
      public static const LANGUAGE_KOREAN:String = "ko";
      
      public static const LANGUAGE_NORWEGIAN:String = "no";
      
      public static const LANGUAGE_POLISH:String = "pl";
      
      public static const LANGUAGE_PORTUGUESE:String = "pt";
      
      public static const LANGUAGE_RUSSIAN:String = "ru";
      
      public static const LANGUAGE_SPANISH:String = "es";
      
      public static const LANGUAGE_SWEDISH:String = "sv";
      
      public static const LANGUAGE_TURKISH:String = "tr";
      
      public static const LANGUAGE_BULGARIAN:String = "bg";
      
      public static const LANGUAGE_SLOVAKIAN:String = "sk";
      
      public static const LANGUAGE_ROMANIAN:String = "ro";
      
      public static const USERNAME_MIN_LENGTH:int = 3;
      
      public static const USERNAME_MAX_LENGTH:int = 15;
      
      public static const USERNAME_MIN_LENGTH_ASIA:int = 1;
      
      public static const PASSWORD_MIN_LENGTH:int = 4;
      
      public static const EMAIL_MIN_LENGTH:int = 6;
      
      public static const EMAIL_MAX_LENGTH:int = 50;
       
      
      public function BasicConstants()
      {
         super();
      }
      
      public static function isFlashLanguage(param1:String) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         switch(param1)
         {
            case LANGUAGE_GERMAN:
            case LANGUAGE_ENGLISH:
            case LANGUAGE_ARABIC:
            case LANGUAGE_CZECH:
            case LANGUAGE_CHINESE_SIMPLE:
            case LANGUAGE_CHINESE_TRADITIONAL:
            case LANGUAGE_DANISH:
            case LANGUAGE_DUTCH:
            case LANGUAGE_FINNISH:
            case LANGUAGE_FRENCH:
            case LANGUAGE_GREECE:
            case LANGUAGE_HUNGARIAN:
            case LANGUAGE_ITALIAN:
            case LANGUAGE_JAPANESE:
            case LANGUAGE_KOREAN:
            case LANGUAGE_NORWEGIAN:
            case LANGUAGE_POLISH:
            case LANGUAGE_PORTUGUESE:
            case LANGUAGE_RUSSIAN:
            case LANGUAGE_SPANISH:
            case LANGUAGE_SWEDISH:
            case LANGUAGE_TURKISH:
            case LANGUAGE_SLOVAKIAN:
               return true;
            default:
               return false;
         }
      }
      
      public static function uniqueAgbLink(param1:String) : String
      {
         switch(param1)
         {
            case LANGUAGE_CZECH:
            case LANGUAGE_DUTCH:
            case LANGUAGE_GERMAN:
            case LANGUAGE_ENGLISH:
            case LANGUAGE_FRENCH:
            case LANGUAGE_HUNGARIAN:
            case LANGUAGE_ITALIAN:
            case LANGUAGE_POLISH:
            case LANGUAGE_PORTUGUESE:
            case LANGUAGE_SPANISH:
            case LANGUAGE_TURKISH:
            case LANGUAGE_SWEDISH:
            case LANGUAGE_RUSSIAN:
            case LANGUAGE_GREECE:
            case LANGUAGE_FINNISH:
            case LANGUAGE_NORWEGIAN:
            case LANGUAGE_DANISH:
            case LANGUAGE_ROMANIAN:
            case LANGUAGE_BULGARIAN:
            case LANGUAGE_SLOVAKIAN:
            case LANGUAGE_KOREAN:
            case LANGUAGE_JAPANESE:
               return AGB_URL + param1 + ".html";
            default:
               return AGB_URL + LANGUAGE_ENGLISH + ".html";
         }
      }
   }
}
