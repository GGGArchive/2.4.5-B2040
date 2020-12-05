package com.goodgamestudios.mafia.view.screens.firstVisit
{
   import com.goodgamestudios.mafia.vo.avatar.AvatarVO;
   
   public class MafiaDataHolder
   {
      
      private static var _instance:MafiaDataHolder;
       
      
      public var savedAvatarVO:AvatarVO;
      
      public var firstVisitCreationUsed:Boolean = false;
      
      public var layoutmanagerStarted:Boolean;
      
      public function MafiaDataHolder()
      {
         super();
      }
      
      public static function get instance() : MafiaDataHolder
      {
         if(MafiaDataHolder._instance == null)
         {
            MafiaDataHolder._instance = new MafiaDataHolder();
         }
         return MafiaDataHolder._instance;
      }
      
      public function destroy() : void
      {
         this.firstVisitCreationUsed = false;
         this.savedAvatarVO = null;
      }
   }
}
