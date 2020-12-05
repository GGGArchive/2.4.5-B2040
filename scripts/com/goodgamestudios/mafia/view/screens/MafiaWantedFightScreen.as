package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaCalendarEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaEddyFrostEvent;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaWantedResultData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCapoVitoFinishedDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNightOfHorrorFinishedDialog;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaWantedFightScreen extends MafiaBasicFightScreen
   {
      
      public static const NAME:String = "MafiaEpicFightScreen";
       
      
      public function MafiaWantedFightScreen(param1:DisplayObject)
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
         this.fillFight(MafiaModel.userData.duelData.wantedData.wantedResultData);
      }
      
      private function fillFight(param1:MafiaWantedResultData) : void
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
            layoutManager.state = Constants_LayoutStates.STATE_DUEL;
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
         }
         super.noPoliceEncounter();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case resultPanel.btn_close:
               if(MafiaModel.userData.duelData.wantedData.wantedResultData.wantedEnemyPicID == Constants_SpecialEvents.CAPO_VITO_PIC_ID && fight.isLeftFighterWinner)
               {
                  MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_ACTIVE_EVENTS,[Constants_SpecialEvents.ID_CAPO_VITO]);
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaCapoVitoFinishedDialog.NAME,null,true,BasicDialogHandler.PRIORITY_HIGH);
               }
               if(MafiaModel.userData.duelData.wantedData.wantedResultData.wantedEnemyPicID == Constants_SpecialEvents.NIGHT_OF_HORROR_PIC_ID && fight.isLeftFighterWinner)
               {
                  MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_ACTIVE_EVENTS,[Constants_SpecialEvents.ID_NIGHT_OF_HORROR]);
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaNightOfHorrorFinishedDialog.NAME,null,true,BasicDialogHandler.PRIORITY_HIGH);
               }
               if(MafiaModel.userData.duelData.wantedData.wantedResultData.wantedEnemyPicID == MafiaCalendarEvent.BOSS_PIC_ID && fight.isLeftFighterWinner)
               {
                  MafiaModel.specialEvent.calendarEvent.killedBossRightNow = true;
               }
               else if(MafiaModel.userData.duelData.wantedData.wantedResultData.wantedEnemyPicID == MafiaEddyFrostEvent.BOSS_PIC_ID && fight.isLeftFighterWinner)
               {
                  MafiaModel.specialEvent.eddyFrostEvent.killedBossRightNow = true;
               }
               clearFight();
         }
         super.onClick(param1);
      }
   }
}
