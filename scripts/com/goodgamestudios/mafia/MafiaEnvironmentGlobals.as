package com.goodgamestudios.mafia
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.constants.BasicConstants;
   import com.goodgamestudios.mafia.version.MafiaGameVersion;
   import com.goodgamestudios.mafia.version.MafiaItemLib1Version;
   import com.goodgamestudios.mafia.version.MafiaItemLib2Version;
   import com.goodgamestudios.mafia.version.MafiaItemsXMLVersion;
   import com.goodgamestudios.mafia.version.MafiaLanguageVersion;
   
   public class MafiaEnvironmentGlobals extends BasicEnvironmentGlobals implements IEnvironmentGlobals
   {
      
      private static var _useAvatarCreationNumber:int;
       
      
      public function MafiaEnvironmentGlobals()
      {
         super();
      }
      
      override public function get networkId() : int
      {
         return super.networkId;
      }
      
      override public function get gameId() : int
      {
         return 4;
      }
      
      override public function get gameTitle() : String
      {
         return "Mafia";
      }
      
      override public function get availableLanguages() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = [];
         for each(_loc2_ in DictionaryUtil.getKeys(langVersionDict))
         {
            if(!this.isBeta && _loc2_ != BasicConstants.LANGUAGE_CHINESE_SIMPLE && _loc2_ != BasicConstants.LANGUAGE_CHINESE_TRADITIONAL && _loc2_ != BasicConstants.LANGUAGE_KOREAN)
            {
               _loc1_.push(_loc2_);
            }
            else if(this.isBeta)
            {
               if(_loc2_ == BasicConstants.LANGUAGE_GERMAN || _loc2_ == BasicConstants.LANGUAGE_ENGLISH)
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         return _loc1_;
      }
      
      override public function get cdnSubDomain() : String
      {
         return "data";
      }
      
      override public function get cookieName() : String
      {
         var _loc1_:* = "Goodgame" + this.gameTitle + "_" + this.networkId;
         if(this.isBeta)
         {
            _loc1_ = _loc1_ + "_beta";
         }
         return _loc1_;
      }
      
      override public function get buildNumberGame() : String
      {
         return MafiaGameVersion.BUILD_NUMBER.toString();
      }
      
      override public function get versionNumberGame() : String
      {
         return MafiaGameVersion.VERSION.toString();
      }
      
      public function get versionNumberLanguage() : String
      {
         return MafiaLanguageVersion.BUILD_NUMBER.toString();
      }
      
      override public function get versionDateGame() : String
      {
         return MafiaGameVersion.DATE;
      }
      
      override public function get versionNumberItemLib1() : String
      {
         return MafiaItemLib1Version.BUILD_NUMBER.toString();
      }
      
      public function get versionNumberItemLib2() : String
      {
         return MafiaItemLib2Version.BUILD_NUMBER.toString();
      }
      
      override public function get numOfItemLibs() : int
      {
         return 2;
      }
      
      override public function get versionNumberItemsXML() : String
      {
         return MafiaItemsXMLVersion.BUILD_NUMBER.toString();
      }
      
      public function get itemXMLUrl() : String
      {
         return baseURL + "/config/" + this.gameTitle + "Items_v" + this.versionNumberItemsXML + ".xml";
      }
      
      override public function get analyticsTrackingPath() : String
      {
         return "/goodgameMafia";
      }
      
      public function getAvatarSwfUrlByWodId(param1:int) : String
      {
         return baseURL + "/AvatarParts/" + "AvaPart_" + param1 + ".swf";
      }
      
      public function getFamilyCrestPartSwfUrl(param1:int, param2:int, param3:int) : String
      {
         var _loc4_:String = param2.toString();
         while(_loc4_.length < 2)
         {
            _loc4_ = "0" + _loc4_;
         }
         var _loc5_:String = param3.toString();
         while(_loc5_.length < 2)
         {
            _loc5_ = "0" + _loc5_;
         }
         return baseURL + "/familyCrestParts/" + "FamilyCrestPart_" + param1 + "_" + _loc4_ + "_" + _loc5_ + ".swf";
      }
      
      public function get useAvatarCreationNumber() : int
      {
         return _useAvatarCreationNumber;
      }
      
      public function set useAvatarCreationNumber(param1:int) : void
      {
         _useAvatarCreationNumber = param1;
      }
      
      override public function get useItemXML() : Boolean
      {
         return false;
      }
      
      override public function get useAutoLogin() : Boolean
      {
         return true;
      }
      
      override public function get isBeta() : Boolean
      {
         return false;
      }
      
      override public function get useAwsTestTracking() : Boolean
      {
         return false;
      }
      
      override public function get useVersionedFontSWF() : Boolean
      {
         return false;
      }
   }
}
