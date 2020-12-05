package com.goodgamestudios.mafia.constants
{
   import com.goodgamestudios.basic.constants.BasicConstants;
   
   public class Constants_ForumBoard
   {
      
      private static const GERMAN:int = 1;
      
      private static const ENGLISH:int = 19;
      
      private static const PORTUGUESE:int = 34;
      
      private static const TURKISH:int = 94;
      
      private static const FRENCH:int = 109;
      
      private static const DEFAULT:int = 64;
      
      public static const INTRODUCE_FAMILY:int = 17;
      
      public static const SEARCH_FAMILY:int = 18;
       
      
      public function Constants_ForumBoard()
      {
         super();
      }
      
      public static function boardID(param1:String) : int
      {
         switch(param1)
         {
            case BasicConstants.LANGUAGE_GERMAN:
               return GERMAN;
            case BasicConstants.LANGUAGE_ENGLISH:
               return ENGLISH;
            case BasicConstants.LANGUAGE_PORTUGUESE:
               return PORTUGUESE;
            case BasicConstants.LANGUAGE_TURKISH:
               return TURKISH;
            case BasicConstants.LANGUAGE_FRENCH:
               return FRENCH;
            case BasicConstants.LANGUAGE_CZECH:
            case BasicConstants.LANGUAGE_DANISH:
            case BasicConstants.LANGUAGE_ITALIAN:
            case BasicConstants.LANGUAGE_SWEDISH:
            case BasicConstants.LANGUAGE_CHINESE_SIMPLE:
            case BasicConstants.LANGUAGE_CHINESE_TRADITIONAL:
            case BasicConstants.LANGUAGE_GREECE:
            case BasicConstants.LANGUAGE_ARABIC:
            case BasicConstants.LANGUAGE_SPANISH:
            case BasicConstants.LANGUAGE_FINNISH:
            case BasicConstants.LANGUAGE_HUNGARIAN:
            case BasicConstants.LANGUAGE_JAPANESE:
            case BasicConstants.LANGUAGE_KOREAN:
            case BasicConstants.LANGUAGE_POLISH:
            case BasicConstants.LANGUAGE_RUSSIAN:
            case BasicConstants.LANGUAGE_DUTCH:
               return DEFAULT;
            default:
               return DEFAULT;
         }
      }
   }
}
