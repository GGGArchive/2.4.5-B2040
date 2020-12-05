package com.goodgamestudios.mafia.helper
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_ForumBoard;
   import com.goodgamestudios.utils.ForumUtils;
   import flash.external.ExternalInterface;
   
   public class MafiaGroupForumsHelper
   {
       
      
      public function MafiaGroupForumsHelper()
      {
         super();
      }
      
      public static function goNews() : void
      {
         if(env.networkNewsByJS)
         {
            goGroup();
         }
         else if(env.useexternallinks)
         {
            goForum();
         }
      }
      
      private static function goForum(param1:Boolean = true) : void
      {
         ForumUtils.navigateToForum(BasicController.getInstance().cryptedForumHash + (env.isTest || env.isLocal || env.isDevTest?"/1":"/0"));
      }
      
      private static function goGroup() : void
      {
         if(!ExternalInterface.available)
         {
            return;
         }
         try
         {
            ExternalInterface.call("requestGroup");
            return;
         }
         catch(error:SecurityError)
         {
            return;
         }
      }
      
      private static function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
      
      public static function goIntroduceClan() : void
      {
         ForumUtils.navigateToSubForumID(BasicController.getInstance().cryptedForumHash + (env.isTest || env.isLocal || env.isDevTest?"/1":"/0"),Constants_ForumBoard.INTRODUCE_FAMILY);
      }
      
      public static function goSearchClan() : void
      {
         ForumUtils.navigateToSubForumID(BasicController.getInstance().cryptedForumHash + (env.isTest || env.isLocal || env.isDevTest?"/1":"/0"),Constants_ForumBoard.SEARCH_FAMILY);
      }
   }
}
