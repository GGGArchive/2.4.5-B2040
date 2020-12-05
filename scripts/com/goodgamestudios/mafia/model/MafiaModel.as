package com.goodgamestudios.mafia.model
{
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicUserData;
   import com.goodgamestudios.mafia.model.components.MafiaBuddyList;
   import com.goodgamestudios.mafia.model.components.MafiaGoldConstantsData;
   import com.goodgamestudios.mafia.model.components.MafiaLanguageData;
   import com.goodgamestudios.mafia.model.components.MafiaOtherUserData;
   import com.goodgamestudios.mafia.model.components.MafiaOwnUserData;
   import com.goodgamestudios.mafia.model.components.MafiaSharedObject;
   import com.goodgamestudios.mafia.model.components.MafiaSmartfoxClient;
   import com.goodgamestudios.mafia.model.components.MafiaSocialData;
   import com.goodgamestudios.mafia.model.components.MafiaSpecialEventData;
   import com.goodgamestudios.mafia.model.components.MafiaTipData;
   import com.goodgamestudios.mafia.model.components.MafiaWodData;
   
   public class MafiaModel extends BasicModel
   {
      
      public static var wodData:MafiaWodData;
      
      public static var buddyList:MafiaBuddyList;
      
      public static var tipData:MafiaTipData;
      
      public static var specialEvent:MafiaSpecialEventData;
      
      public static var goldConstants:MafiaGoldConstantsData;
      
      protected static var _otherData:BasicUserData;
       
      
      public function MafiaModel()
      {
         super();
      }
      
      public static function get smartfoxClient() : MafiaSmartfoxClient
      {
         return _smartfoxClient as MafiaSmartfoxClient;
      }
      
      public static function set smartfoxClient(param1:MafiaSmartfoxClient) : void
      {
         _smartfoxClient = param1;
      }
      
      public static function get userData() : MafiaOwnUserData
      {
         return _userData as MafiaOwnUserData;
      }
      
      public static function set userData(param1:MafiaOwnUserData) : void
      {
         _userData = param1;
      }
      
      public static function get otherUserData() : MafiaOtherUserData
      {
         return _otherData as MafiaOtherUserData;
      }
      
      public static function set otherUserData(param1:MafiaOtherUserData) : void
      {
         _otherData = param1;
      }
      
      public static function get socialData() : MafiaSocialData
      {
         return _socialData as MafiaSocialData;
      }
      
      public static function set socialData(param1:MafiaSocialData) : void
      {
         _socialData = param1;
      }
      
      public static function get languageData() : MafiaLanguageData
      {
         return _languageData as MafiaLanguageData;
      }
      
      public static function set languageData(param1:MafiaLanguageData) : void
      {
         _languageData = param1;
      }
      
      public static function get localData() : MafiaSharedObject
      {
         return _localData as MafiaSharedObject;
      }
      
      public static function set localData(param1:MafiaSharedObject) : void
      {
         _localData = param1;
      }
   }
}
