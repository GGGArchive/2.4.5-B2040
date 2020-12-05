package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.tooltips.BasicAdvancedToolTip;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import flash.display.DisplayObject;
   
   public class MafiaAdvancedTooltip extends BasicAdvancedToolTip
   {
       
      
      public function MafiaAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            if(this.env.hasNetworkBuddies)
            {
               disp.scaleY = disp.scaleX = disp.stage.stageWidth / Constants_Basic.GAME_WIDTH;
            }
            else
            {
               disp.scaleX = disp.scaleY = disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT;
            }
         }
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      protected function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
