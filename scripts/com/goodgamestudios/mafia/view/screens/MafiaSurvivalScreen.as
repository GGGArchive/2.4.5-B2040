package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_Status;
   import com.goodgamestudios.mafia.controller.commands.duel.StartSurvivalFightCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSurvivalEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaSurvivalResultData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaFullInventoryDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaFullInventoryDialogProperties;
   import com.goodgamestudios.mafia.view.screens.energy.MafiaEnergyBarComponent;
   import com.goodgamestudios.mafia.view.screens.survival.MafiaSurvivalOverviewComponent;
   import com.goodgamestudios.mafia.view.screens.survival.MafiaSurvivalRewardComponent;
   import com.goodgamestudios.mafia.view.screens.survival.MafiaSurvivalStatisticsComponent;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaSurvivalScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaHellScreen";
       
      
      protected var survivalOverview:MafiaSurvivalOverviewComponent;
      
      protected var survivalReward:MafiaSurvivalRewardComponent;
      
      protected var survivalStatistics:MafiaSurvivalStatisticsComponent;
      
      private var energyBar:MafiaEnergyBarComponent;
      
      public function MafiaSurvivalScreen(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,param2);
         this.survivalOverview = new MafiaSurvivalOverviewComponent(this.survivalScreen.overview);
         this.survivalReward = new MafiaSurvivalRewardComponent(this.survivalScreen.reward);
         this.survivalStatistics = new MafiaSurvivalStatisticsComponent(this.survivalScreen.statistics);
         this.energyBar = new MafiaEnergyBarComponent(this.survivalScreen.energy_Bar);
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_FIGHT;
      }
      
      override public function show() : void
      {
         super.show();
         this.energyBar.show();
         this.survivalOverview.toForeground();
         this.survivalReward.toBackground();
         this.survivalStatistics.toBackground();
         controller.addEventListener(MafiaSurvivalEvent.CHANGE_SURVIVALDATA,this.onSurvivalData);
         controller.addEventListener(MafiaSurvivalEvent.CHANGE_SURVIVALRESETTIMER,this.onSurvivalResetTimer);
         this.survivalScreen.header.txt_copy.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_17");
         this.survivalScreen.header.btn_close.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
      }
      
      override public function hide() : void
      {
         super.hide();
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaSurvivalEvent.CHANGE_SURVIVALDATA,this.onSurvivalData);
         controller.removeEventListener(MafiaSurvivalEvent.CHANGE_SURVIVALRESETTIMER,this.onSurvivalResetTimer);
         this.energyBar.hide();
         super.removeEvents();
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
         this.fillSurvival(MafiaModel.userData.duelData.survivalData);
      }
      
      private function onSurvivalData(param1:MafiaSurvivalEvent) : void
      {
         this.fillSurvival(MafiaModel.userData.duelData.survivalData);
         this.survivalOverview.fillNextOpponentClass(MafiaModel.userData.duelData.survivalData);
      }
      
      private function fillSurvival(param1:MafiaSurvivalResultData) : void
      {
         this.energyBar.visualizeDefault();
         this.energyBar.showDefaultEnergyBar();
         this.survivalOverview.fillSurvivalData(param1);
         this.survivalReward.fillSurvivalData(param1);
         this.survivalStatistics.fillSurvivalData(param1);
         this.survivalScreen.counter.visible = false;
         this.survivalScreen.btn_fight.goldInfoVisible = false;
         if(param1.survivalProgress == 0)
         {
            this.survivalScreen.btn_fight.label = MafiaModel.languageData.getTextById("MafiaDuelScreen_btn_attack");
         }
         else if(param1.survivalProgress < param1.absoluteKilledEnemies)
         {
            this.survivalScreen.btn_fight.label = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_btn_nextTry");
         }
         else
         {
            this.survivalScreen.btn_fight.label = MafiaModel.languageData.getTextById("generic_btn_continue");
         }
         if(param1.neededEnergy > 0)
         {
            this.survivalScreen.btn_fight.goldInfoVisible = true;
            this.survivalScreen.btn_fight.goldInfoTimeText = param1.neededEnergy.toString();
         }
         if(param1.survivalResetTime > 0)
         {
            this.survivalScreen.counter.visible = true;
            this.survivalScreen.counter.txt_resetTime.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_3");
            updateAllTextFields();
         }
         this.survivalScreen.btn_fight.toolTipText = null;
         this.survivalScreen.btn_fight.enableButton = true;
         if(MafiaModel.userData.status > 0)
         {
            switch(MafiaModel.userData.status)
            {
               case Constants_Status.STATUS_ON_A_MISSION:
               case Constants_Status.STATUS_MISSION_FINISHED:
                  this.survivalScreen.btn_fight.enableButton = false;
                  this.survivalScreen.btn_fight.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_blockedQuest");
                  updateAllTextFields();
                  return;
               case Constants_Status.STATUS_WORKING:
               case Constants_Status.STATUS_WORK_FINISHED:
                  this.survivalScreen.btn_fight.enableButton = false;
                  this.survivalScreen.btn_fight.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_blockedProtectionMoney");
                  updateAllTextFields();
                  return;
            }
         }
         if(MafiaModel.userData.userMissionEnergy < param1.neededEnergy * 10)
         {
            this.survivalScreen.btn_fight.goldInfoVisible = false;
            this.survivalScreen.btn_fight.label = MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_barkeeper");
         }
      }
      
      private function onSurvivalResetTimer(param1:MafiaSurvivalEvent) : void
      {
         this.survivalScreen.counter.txt_resetTime.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_3") + "\n" + param1.params[0];
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.survivalScreen.btn_fight:
               if(!this.survivalScreen.btn_fight.enabled)
               {
                  return;
               }
               if(MafiaModel.userData.userMissionEnergy < MafiaModel.userData.duelData.survivalData.neededEnergy * 10)
               {
                  layoutManager.state = Constants_LayoutStates.STATE_MISSION;
                  (layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).showBuyEnergyDialog();
               }
               else if(!MafiaModel.userData.inventory.isInventoryFull)
               {
                  this.onStartSurvivalFight();
               }
               else
               {
                  layoutManager.showDialog(MafiaFullInventoryDialog.NAME,new MafiaFullInventoryDialogProperties(0,MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_title"),MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_copy_1"),this.onStartSurvivalFight,this.gotoShop));
               }
               break;
            case this.survivalScreen.overview:
               this.survivalOverview.toForeground();
               this.survivalReward.toBackground();
               this.survivalStatistics.toBackground();
               break;
            case this.survivalScreen.reward:
               this.survivalOverview.toBackground();
               this.survivalReward.toForeground();
               this.survivalStatistics.toBackground();
               break;
            case this.survivalScreen.statistics:
               this.survivalOverview.toBackground();
               this.survivalReward.toBackground();
               this.survivalStatistics.toForeground();
               break;
            case this.survivalScreen.header.btn_close:
               layoutManager.state = Constants_LayoutStates.STATE_DUEL;
         }
         super.onClick(param1);
         this.survivalScreen.setChildIndex(this.survivalScreen.header,this.survivalScreen.numChildren - 1);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target == this.survivalScreen.btn_fight)
         {
            this.energyBar.fillEnergyBar(MafiaModel.userData.duelData.survivalData.neededEnergy);
         }
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target == this.survivalScreen.btn_fight)
         {
            this.energyBar.onOutEnergyBar();
         }
         super.onMouseOut(param1);
      }
      
      private function onStartSurvivalFight(param1:int = 0) : void
      {
         this.survivalScreen.btn_fight.enableButton = false;
         MafiaDialogHandler.getInstance().blockDialogs = true;
         layoutManager.state = Constants_LayoutStates.STATE_SURVIVAL_FIGHT;
         StartSurvivalFightCommand.sendCommand();
      }
      
      private function gotoShop(param1:Object = null) : void
      {
         layoutManager.state = Constants_LayoutStates.STATE_SHOP;
      }
      
      protected function get survivalScreen() : MafiaSurvival
      {
         return disp as MafiaSurvival;
      }
   }
}
