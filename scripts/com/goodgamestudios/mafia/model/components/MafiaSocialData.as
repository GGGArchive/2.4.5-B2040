package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.components.BasicSocialData;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   
   public class MafiaSocialData extends BasicSocialData
   {
      
      public static const EXTERNAL_SHARE_LEVELUP:String = "postLevelUpFeed";
      
      public static const EXTERNAL_SHARE_ACHIEVEMENT:String = "postAchievementFeed";
      
      public static const EXTERNAL_SHARE_JOIN_CLAN:String = "postFamilyJoined";
      
      public static const EXTERNAL_SHARE_CREATE_CLAN:String = "postFamilyCreated";
      
      public static const EXTERNAL_SHARE_LEVELUP_CLAN:String = "postFamilyLevelUp";
       
      
      public function MafiaSocialData(param1:EventDispatcher)
      {
         super();
      }
      
      public function postFeed(param1:String, param2:Array = null) : void
      {
         this.externalInterface(param1,param2);
      }
      
      public function callJS(param1:String, param2:Array = null) : void
      {
         this.externalInterface(param1,param2);
      }
      
      override protected function externalInterface(param1:String, param2:Array = null) : void
      {
         var type:String = param1;
         var params:Array = param2;
         if(!ExternalInterface.available)
         {
            return;
         }
         super.externalInterface(type,params);
         try
         {
            switch(type)
            {
               case EXTERNAL_SHARE_LEVELUP:
               case EXTERNAL_SHARE_LEVELUP_CLAN:
                  ExternalInterface.call(type,params[0],params[1]);
                  break;
               case EXTERNAL_SHARE_ACHIEVEMENT:
               case EXTERNAL_SHARE_JOIN_CLAN:
               case EXTERNAL_SHARE_CREATE_CLAN:
                  ExternalInterface.call(type,params[0]);
            }
            return;
         }
         catch(error:Error)
         {
            trace("external interface value is not valid " + type);
            return;
         }
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
