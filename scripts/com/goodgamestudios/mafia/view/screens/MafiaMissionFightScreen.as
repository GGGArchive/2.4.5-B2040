package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaMissionFightScreen extends MafiaBasicFightScreen
   {
      
      public static const NAME:String = "MafiaMissionFightScreen";
       
      
      public function MafiaMissionFightScreen(param1:DisplayObject)
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
         this.fillFight(MafiaModel.userData.missionData.missionResultData);
      }
      
      private function fillFight(param1:MafiaFightResultData) : void
      {
         super.fillFighterData(fighterLeft,param1.fighterLeft);
         super.fillFighterData(fighterRight,param1.fighterRight);
      }
      
      override protected function showFightResult(param1:Boolean) : void
      {
         super.showFightResult(param1);
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_MISSION_FIGHT_PROGRESS:
                  MafiaTutorialController.getInstance().nextStep();
                  resultPanel.btn_close.addChild(MafiaTutorialController.getInstance().tutorialArrow);
            }
         }
      }
      
      override protected function policeEncounter() : void
      {
      }
      
      override protected function noPoliceEncounter() : void
      {
         controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_CURRENCY));
         if(reward.xp + MafiaModel.userData.userXP == MafiaModel.userData.userXPForNextLevel)
         {
            PlayerProfileCommand.sendCommand(MafiaModel.userData.playerID,false);
            layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
         }
         else
         {
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[0]);
            layoutManager.state = Constants_LayoutStates.STATE_MISSION;
         }
         super.noPoliceEncounter();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_MISSION_FIGHT:
                  if(param1.target == resultPanel.btn_close)
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_MISSION;
                     MafiaTutorialController.getInstance().nextStep();
                     clearFight();
                     return;
                  }
                  return;
            }
         }
         switch(param1.target)
         {
            case resultPanel.btn_close:
               if(MafiaModel.specialEvent.sicilianEvent.isEventActive && !MafiaModel.specialEvent.sicilianEvent.isMissionPhaseFinished && fight.isLeftFighterWinner)
               {
               }
               MafiaModel.userData.missionData.currentMissionId = 0;
               clearFight();
               break;
            default:
               super.onClick(param1);
         }
      }
   }
}
