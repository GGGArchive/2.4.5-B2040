package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.commands.gangwars.SDOCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaGangwarFightScreen extends MafiaBasicFightScreen
   {
      
      public static const NAME:String = "MafiaDungeonFightScreen";
       
      
      public function MafiaGangwarFightScreen(param1:DisplayObject)
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
         if(MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
         {
            this.fillFight(MafiaModel.specialEvent.sicilianEvent.gangwarFightResultData);
         }
         else
         {
            this.fillFight(MafiaModel.userData.gangwarData.gangwarResultData);
         }
      }
      
      private function fillFight(param1:MafiaFightResultData) : void
      {
         super.fillFighterData(fighterLeft,param1.fighterLeft);
         super.fillFighterData(fighterRight,param1.fighterRight);
      }
      
      override protected function policeEncounter() : void
      {
      }
      
      override protected function noPoliceEncounter() : void
      {
         if(reward.xp + MafiaModel.userData.userXP == MafiaModel.userData.userXPForNextLevel)
         {
            PlayerProfileCommand.sendCommand(MafiaModel.userData.playerID,false);
            layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
         }
         else
         {
            if(!MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
            {
               SDOCommand.sendCommand(MafiaModel.userData.gangwarData.currentGangwarID);
            }
            layoutManager.state = Constants_LayoutStates.STATE_GANGWARS;
         }
         super.noPoliceEncounter();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case resultPanel.btn_close:
               clearFight();
               break;
            default:
               super.onClick(param1);
         }
      }
   }
}
