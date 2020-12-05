package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.basic.model.components.BasicLanguageData;
   import com.goodgamestudios.mafia.constants.enums.City;
   
   public class MafiaLanguageData extends BasicLanguageData
   {
      
      public static const CATEGORY_ALERTS:String = "alerts";
      
      public static const CATEGORY_COMMONS:String = "commons";
      
      public static const CATEGORY_DIALOGS:String = "dialogs";
      
      public static const CATEGORY_ERROR_CODES:String = "error_codes";
      
      public static const CATEGORY_INGAME_TOOLTIPS:String = "ingame_tooltips";
      
      public static const CATEGORY_PANELS:String = "panels";
      
      public static const CATEGORY_ACHIEVEMENTS:String = "achievement";
      
      public static const CATEGORY_STD_BUTTONS:String = "std_buttons";
      
      public static const CATEGORY_TOOLTIPS:String = "tooltips";
      
      public static const CATEGORY_FEATURE:String = "feature";
      
      public static const CATEGORY_LOGGEDINMSG:String = "loggedin_msg";
      
      public static const CATEGORY_SCREENS:String = "screens";
      
      public static const CATEGORY_ITEMS:String = "items";
      
      public static const CATEGORY_ITEMSTYPES:String = "itemtypes";
      
      public static const CATEGORY_MISSION:String = "quests";
      
      public static const CATEGORY_TUTORIAL:String = "tutorial";
      
      public static const CATEGORY_COLLECTION:String = "collection";
      
      public static const CATEGORY_DAILYTIP:String = "dailytip";
      
      public static const CATEGORY_MISSION_ENEMIES:String = "enemynames";
      
      public static const CATEGORY_INGAMEHELP:String = "ingamehelp";
      
      public static const CATEGORY_TRAVELTARGETS:String = "travelTargets";
      
      public static const CATEGORY_EVENTS:String = "events";
      
      public static const CATEGORY_HOMESCREEN:String = "homescreen";
      
      public static const CATEGORY_GENERIC:String = "generic_flash";
      
      public static const GAME_CATEGORIES:Array = [CATEGORY_TUTORIAL,CATEGORY_MISSION,CATEGORY_SCREENS,CATEGORY_ITEMS,CATEGORY_ITEMSTYPES,CATEGORY_ALERTS,CATEGORY_INGAME_TOOLTIPS,CATEGORY_LOGGEDINMSG,CATEGORY_FEATURE,CATEGORY_ACHIEVEMENTS,CATEGORY_COMMONS,CATEGORY_DIALOGS,CATEGORY_ERROR_CODES,CATEGORY_PANELS,CATEGORY_STD_BUTTONS,CATEGORY_COLLECTION,CATEGORY_TOOLTIPS,CATEGORY_DAILYTIP,CATEGORY_GENERIC,CATEGORY_MISSION_ENEMIES,CATEGORY_INGAMEHELP,CATEGORY_TRAVELTARGETS,CATEGORY_HOMESCREEN,CATEGORY_EVENTS];
       
      
      public function MafiaLanguageData()
      {
         super();
      }
      
      override public function getTextById(param1:String, param2:Object = null) : String
      {
         return super.getTextById(param1,param2).replace(/\r/g,"");
      }
      
      public function getCityName(param1:City) : String
      {
         return this.getTextById("travel_target_" + param1.index);
      }
      
      override protected function set languageXML(param1:XML) : void
      {
         super.languageXML = param1;
         gameLanguageDict = getLanguageDictByStructArray(GAME_CATEGORIES);
      }
      
      public function getLanguageXML() : XML
      {
         return languageXML;
      }
      
      public function destroy() : void
      {
      }
   }
}
