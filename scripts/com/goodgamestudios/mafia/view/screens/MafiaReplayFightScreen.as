package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCombatLogDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaCombatLogDialogProperties;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaReplayFightScreen extends MafiaBasicFightScreen
   {
      
      public static const NAME:String = "MafiaReplayFightScreen";
       
      
      public function MafiaReplayFightScreen(param1:DisplayObject)
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
         this.fillFight(MafiaModel.userData.messageData.replayFightData);
      }
      
      private function fillFight(param1:MafiaFightResultData) : void
      {
         super.fillFighterData(fighterLeft,param1.fighterLeft);
         super.fillFighterData(fighterRight,param1.fighterRight);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case resultPanel.btn_close:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               clearFight();
               layoutManager.state = Constants_LayoutStates.STATE_MAILING;
               break;
            case resultPanel.btn_log:
               layoutManager.showDialog(MafiaCombatLogDialog.NAME,new MafiaCombatLogDialogProperties(MafiaModel.userData.messageData.duelResultLogData));
            default:
               super.onClick(param1);
         }
      }
      
      override protected function get showLogButton() : Boolean
      {
         return true;
      }
   }
}
