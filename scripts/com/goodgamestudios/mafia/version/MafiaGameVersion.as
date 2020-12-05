package com.goodgamestudios.mafia.version
{
   public class MafiaGameVersion
   {
      
      public static const BUILD_NUMBER:int = 2040;
      
      public static const VERSION:String = "2.4.5";
      
      public static const DATE:String = "201302121240";
       
      
      public function MafiaGameVersion()
      {
         super();
      }
      
      public static function get versionText() : String
      {
         return "V" + VERSION + " B" + BUILD_NUMBER;
      }
   }
}
