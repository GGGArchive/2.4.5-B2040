package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.CityFightProgress;
   import com.goodgamestudios.mafia.controller.commands.fight.ShowCityFightItemsCommand;
   import com.goodgamestudios.mafia.controller.commands.gangwars.ShowGangWarsCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBonusQuestScreenProperties;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaCityBonusFightScreen extends MafiaBasicFightScreen
   {
      
      public static const NAME:String = "MafiaCityBonusFightScreen";
       
      
      public function MafiaCityBonusFightScreen(param1:DisplayObject)
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
         this.fillFight(MafiaModel.userData.cityQuestFightData.cityBonusFightResultData);
      }
      
      private function fillFight(param1:MafiaFightResultData) : void
      {
         super.fillFighterData(fighterLeft,param1.fighterLeft);
         super.fillFighterData(fighterRight,param1.fighterRight);
      }
      
      override protected function policeEncounter() : void
      {
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case resultPanel.btn_close:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               clearFight();
               layoutManager.state = Constants_LayoutStates.STATE_GANGWARS;
               ShowGangWarsCommand.sendCommand();
               if(fight.isLeftFighterWinner)
               {
                  MafiaModel.userData.cityQuestFightData.lastGangwarVO.cityFightProgress = CityFightProgress.FightWon;
                  layoutManager.showScreen(MafiaBonusOpponentQuestScreen.NAME,new MafiaBonusQuestScreenProperties(MafiaModel.userData.cityQuestFightData.lastGangwarVO));
                  ShowCityFightItemsCommand.sendCommand(MafiaModel.userData.cityQuestFightData.lastGangwarVO.district_id);
               }
               break;
            default:
               super.onClick(param1);
         }
      }
   }
}
