package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaTournamentResultData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaTournamentFightScreen extends MafiaBasicFightScreen
   {
      
      public static const NAME:String = "MafiaTournamentFightScreen";
       
      
      private var darkLayer:Sprite;
      
      public function MafiaTournamentFightScreen(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_FIGHT;
      }
      
      override public function show() : void
      {
         super.show();
         MafiaDialogHandler.getInstance().blockDialogs = true;
         layoutManager.hideAllDialogs();
         this.fillFight(MafiaModel.specialEvent.tournamentEvent.fightResultData);
      }
      
      private function fillFight(param1:MafiaTournamentResultData) : void
      {
         super.fillFighterData(fighterLeft,param1.fighterLeft);
         super.fillFighterData(fighterRight,param1.fighterRight);
      }
      
      override public function hide() : void
      {
         super.hide();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override protected function clearFight() : void
      {
         if(this.darkLayer)
         {
            fightScreen.removeChild(this.darkLayer);
            this.darkLayer = null;
         }
         super.clearFight();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case resultPanel.btn_close:
               layoutManager.state = layoutManager.previousState;
               this.clearFight();
               break;
            case fightScreen.tournamentSpectatorResultTooltip.btn_close:
               layoutManager.state = Constants_LayoutStates.STATE_TOURNAMENT;
               this.clearFight();
         }
         super.onClick(param1);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
      }
      
      override protected function policeEncounter() : void
      {
      }
      
      override protected function showFightResult(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(MafiaModel.specialEvent.tournamentEvent.fightResultData.isSpectator)
         {
            if(this.darkLayer == null)
            {
               this.darkLayer = new Sprite();
               this.darkLayer.graphics.beginFill(0,0.3);
               this.darkLayer.graphics.drawRect(0,0,fightScreen.width,fightScreen.height);
               this.darkLayer.graphics.endFill();
               _loc2_ = fightScreen.getChildIndex(fightScreen.tournamentSpectatorResultTooltip);
               fightScreen.addChildAt(this.darkLayer,_loc2_);
            }
            fightScreen.tournamentSpectatorResultTooltip.visible = true;
            fightScreen.tournamentSpectatorResultTooltip.btn_close.label = MafiaModel.languageData.getTextById("generic_btn_goback");
         }
         super.showFightResult(param1);
         fightScreen.btn_skip.visible = false;
      }
      
      override protected function fillResult() : void
      {
         if(!MafiaModel.specialEvent.tournamentEvent.fightResultData.isSpectator)
         {
            super.fillResult();
         }
      }
   }
}
