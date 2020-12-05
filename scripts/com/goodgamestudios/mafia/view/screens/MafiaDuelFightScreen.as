package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCombatLogDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaCombatLogDialogProperties;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaDuelFightScreen extends MafiaBasicFightScreen
   {
      
      public static const NAME:String = "MafiaDuelFightScreen";
       
      
      public function MafiaDuelFightScreen(param1:DisplayObject)
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
         this.fillFight(MafiaModel.userData.duelData.pvpData.duelResultData);
      }
      
      private function fillFight(param1:MafiaFightResultData) : void
      {
         super.fillFighterData(fighterLeft,param1.fighterLeft);
         super.fillFighterData(fighterRight,param1.fighterRight);
      }
      
      override protected function noPoliceEncounter() : void
      {
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[0]);
         layoutManager.state = layoutManager.stateBeforeFight;
         super.noPoliceEncounter();
      }
      
      override protected function policeEncounter() : void
      {
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case resultPanel.btn_close:
               PlayerProfileCommand.sendCommand(MafiaModel.userData.playerID,true);
               clearFight();
               break;
            case resultPanel.btn_log:
               layoutManager.showDialog(MafiaCombatLogDialog.NAME,new MafiaCombatLogDialogProperties(MafiaModel.userData.duelData.pvpData.duelResultLogData));
               break;
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
