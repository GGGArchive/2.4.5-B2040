package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.display.DisplayObject;
   
   public class MafiaWelcomeScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaWelcomeScreen";
       
      
      public function MafiaWelcomeScreen(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_FIGHT;
      }
   }
}
