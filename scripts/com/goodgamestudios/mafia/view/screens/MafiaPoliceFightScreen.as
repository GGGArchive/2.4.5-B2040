package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.constants.enums.PoliceType;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.commands.avatar.OUDCommand;
   import com.goodgamestudios.mafia.controller.commands.police.StartPoliceFightCommand;
   import com.goodgamestudios.mafia.event.model.MafiaPoliceEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.MafiaPoliceData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MafiaPoliceFightScreen extends MafiaBasicFightScreen
   {
      
      public static const NAME:String = "MafiaPoliceFightScreen";
       
      
      private var _policeEncounter:MafiaPoliceEncounter;
      
      private var _resultData:MafiaBasicFightScreenProperties;
      
      private var FOOTER_Y:Number;
      
      private var FOOTER_Y_EVENT:Number;
      
      private var BG_HEIGHT:Number;
      
      private var BG_HEIGHT_EVENT:Number;
      
      private var RESULT_BG_HEIGHT:Number;
      
      private var RESULT_BTN_CLOSE_Y:Number;
      
      public function MafiaPoliceFightScreen(param1:DisplayObject)
      {
         super(param1);
         this.RESULT_BG_HEIGHT = fightScreen.blankResultTooltip.bg.height;
         this.RESULT_BTN_CLOSE_Y = fightScreen.blankResultTooltip.btn_close.y;
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_FIGHT;
      }
      
      override public function show() : void
      {
         var _loc1_:Boolean = true;
         controller.addEventListener(MafiaPoliceEvent.POLICE_SHOW_FIGHT,this.onStartFight);
         if(!this._policeEncounter)
         {
            this._policeEncounter = new MafiaPoliceEncounter();
            fightScreen.addChild(this._policeEncounter);
            this._policeEncounter.x = Constants_Basic.GAME_WIDTH / 2;
            this._policeEncounter.y = fighterLeft.y;
            this.FOOTER_Y = this._policeEncounter.footer.y;
            this.FOOTER_Y_EVENT = this.FOOTER_Y - 100;
            this.BG_HEIGHT = this._policeEncounter.bg.height;
            this.BG_HEIGHT_EVENT = this.BG_HEIGHT - 100;
         }
         else
         {
            this._policeEncounter.visible = true;
         }
         this.fillPoliceEncounterPanel(MafiaModel.specialEvent.breakingTheLawEvent.isEventActive);
         fillFighterData(fighterLeft,MafiaModel.userData.fighterVO);
         if(MafiaModel.userData.policeData.resultData.fighterRight)
         {
            fillFighterData(fighterRight,MafiaModel.userData.policeData.resultData.fighterRight);
            if(MafiaModel.userData.policeData.policeType == PoliceType.Police)
            {
               fighterRight.header.txt_name.text = MafiaModel.languageData.getTextById("MafiaPolice_name_police");
            }
            else if(MafiaModel.userData.policeData.policeType == PoliceType.SWAT)
            {
               fighterRight.header.txt_name.text = MafiaModel.languageData.getTextById("MafiaPolice_name_swat");
            }
         }
         super.show();
      }
      
      private function fillPoliceEncounterPanel(param1:Boolean) : void
      {
         if(MafiaModel.userData.policeData.policeType == PoliceType.Police)
         {
            this._policeEncounter.txt_title.text = MafiaModel.languageData.getTextById("MafiaPolice_WarningDialog_title_1");
         }
         else if(MafiaModel.userData.policeData.policeType == PoliceType.SWAT)
         {
            this._policeEncounter.txt_title.text = MafiaModel.languageData.getTextById("MafiaPolice_WarningDialog_title_2");
         }
         if(!param1)
         {
            this._policeEncounter.bg.height = this.BG_HEIGHT;
            this._policeEncounter.footer.y = this.FOOTER_Y;
            this._policeEncounter.txt_info.text = MafiaModel.languageData.getTextById("MafiaPolice_WarningDialog_copy_3");
            this._policeEncounter.winIcon.gotoAndStop("cup");
            this._policeEncounter.txt_reward_headline.text = MafiaModel.languageData.getTextById("MafiaPolice_WarningDialog_copy_1");
            this._policeEncounter.txt_reward.text = MafiaModel.userData.policeData.getEffectDescriptionWithDuration(true,true);
            this._policeEncounter.txt_penalty_headline.text = MafiaModel.languageData.getTextById("MafiaPolice_WarningDialog_copy_2");
            this._policeEncounter.txt_penalty.text = MafiaModel.userData.policeData.getEffectDescriptionWithDuration(true,false);
         }
         else
         {
            this._policeEncounter.bg.height = this.BG_HEIGHT_EVENT;
            this._policeEncounter.footer.y = this.FOOTER_Y_EVENT;
            if(MafiaModel.userData.policeData.policeType == PoliceType.Police)
            {
               this._policeEncounter.txt_info.text = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_9");
            }
            else if(MafiaModel.userData.policeData.policeType == PoliceType.SWAT)
            {
               this._policeEncounter.txt_info.text = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_10",[MafiaModel.specialEvent.breakingTheLawEvent.SWAT_BADGE_REWARD]);
            }
            this._policeEncounter.winIcon.gotoAndStop("policeBadge");
            this._policeEncounter.txt_reward_headline.text = MafiaModel.languageData.getTextById("MafiaPolice_WarningDialog_copy_1");
            this._policeEncounter.txt_reward.text = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_11");
         }
         this._policeEncounter.txt_penalty_headline.visible = !param1;
         this._policeEncounter.txt_penalty.visible = !param1;
         this._policeEncounter.loseIcon.visible = !param1;
         this._policeEncounter.footer.btn_go.label = MafiaModel.languageData.getTextById("MafiaAvatarScreen_btn_attack");
         this._policeEncounter.footer.btn_leave.label = MafiaModel.languageData.getTextById("MafiaPolice_WarningDialog_btn_escape");
         updateAllTextFields();
         this._policeEncounter.footer.btn_go.update();
         this._policeEncounter.footer.btn_leave.update();
      }
      
      override public function hide() : void
      {
         super.hide();
         this._policeEncounter.visible = false;
      }
      
      private function onChooseToFight() : void
      {
         StartPoliceFightCommand.sendCommand(true);
         this._policeEncounter.visible = false;
      }
      
      private function onStartFight(param1:MafiaPoliceEvent) : void
      {
         this._resultData = new MafiaBasicFightScreenProperties(MafiaModel.userData.policeData.resultData);
         var _loc2_:MafiaFightResultData = MafiaModel.userData.policeData.resultData;
         super.fillFighterData(fighterLeft,_loc2_.fighterLeft);
         super.fillFighterData(fighterRight,_loc2_.fighterRight);
         fightScreen.btn_skip.visible = true;
         if(_loc2_.fighterRight.id <= 205)
         {
            fighterRight.header.txt_name.text = MafiaModel.languageData.getTextById("MafiaPolice_name_police");
         }
         else
         {
            fighterRight.header.txt_name.text = MafiaModel.languageData.getTextById("MafiaPolice_name_swat");
         }
      }
      
      protected function onLeave() : void
      {
         super.removeEvents();
         MafiaModel.userData.policeData.clearEncounter();
         switch(MafiaFightController.getInstance().lastFightType)
         {
            case FightType.Duel:
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[0]);
               break;
            case FightType.Wanted:
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
         }
         if(MafiaFightController.getInstance().lastFightType == FightType.Survival)
         {
            layoutManager.state = Constants_LayoutStates.STATE_DUEL;
         }
         else
         {
            layoutManager.state = layoutManager.stateBeforeFight;
         }
         MafiaDialogHandler.getInstance().blockDialogs = false;
         controller.dispatchEvent(new MafiaPoliceEvent(MafiaPoliceEvent.POLICE_RETREAT));
         OUDCommand.sendCommand([MafiaModel.userData.playerID]);
      }
      
      override public function destroy() : void
      {
         if(this._policeEncounter)
         {
            fightScreen.removeChild(this._policeEncounter);
            this._policeEncounter = null;
         }
         super.destroy();
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaPoliceEvent.POLICE_SHOW_FIGHT,this.onStartFight);
         super.removeEvents();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case fightScreen.policeResultTooltip.btn_close:
            case fightScreen.blankResultTooltip.btn_close:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               this.clearFight();
               layoutManager.state = layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               break;
            case this._policeEncounter.footer.btn_leave:
               this.onLeave();
               break;
            case this._policeEncounter.footer.btn_go:
               this.onChooseToFight();
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
      
      override protected function clearFight() : void
      {
         super.clearFight();
         MafiaModel.userData.policeData.clearEncounter();
      }
      
      override protected function showFightResult(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:RewardField = null;
         var _loc5_:MafiaPoliceResultTooltipHoover = null;
         var _loc6_:MafiaPoliceResultTooltipHoover = null;
         var _loc7_:RewardField = null;
         var _loc8_:MafiaPoliceResultTooltipHoover = null;
         var _loc9_:RewardField = null;
         var _loc2_:MafiaPoliceData = MafiaModel.userData.policeData;
         fightScreen.btn_skip.visible = false;
         if(!MafiaModel.specialEvent.breakingTheLawEvent.isEventActive)
         {
            fightScreen.policeResultTooltip.visible = true;
            fightScreen.policeResultTooltip.btn_close.label = MafiaModel.languageData.getTextById("generic_btn_okay");
            if(this.fight.isLeftFighterWinner)
            {
               fightScreen.policeResultTooltip.mc_winLoseIcon.gotoAndStop("cup");
               fightScreen.policeResultTooltip.txt_result.text = _loc2_.getEffectDescriptionWithDuration(true,true);
            }
            else
            {
               fightScreen.policeResultTooltip.mc_winLoseIcon.gotoAndStop("handcuffs");
               fightScreen.policeResultTooltip.txt_result.text = _loc2_.getEffectDescriptionWithDuration(true,false);
            }
            updateAllTextFields();
         }
         else
         {
            MovieClipHelper.clearMovieClip(fightScreen.blankResultTooltip.holder);
            fightScreen.blankResultTooltip.visible = true;
            _loc3_ = 0;
            _loc4_ = new RewardField();
            _loc5_ = new MafiaPoliceResultTooltipHoover();
            _loc6_ = new MafiaPoliceResultTooltipHoover();
            _loc4_.icon.gotoAndStop("cash");
            _loc4_.txt_value.text = NumberStringHelper.groupString(MafiaModel.userData.policeData.reward.cash,MafiaModel.languageData.getTextById);
            _loc4_.y = (_loc3_ + 0.5) * _loc4_.height;
            fightScreen.blankResultTooltip.holder.addChild(_loc4_);
            _loc4_.icon.addChild(_loc5_);
            _loc5_.toolTipText = MafiaModel.languageData.getTextById("MafiaPayment_cash");
            _loc3_++;
            _loc7_ = new RewardField();
            _loc7_.icon.gotoAndStop("xp");
            _loc7_.txt_value.text = NumberStringHelper.groupString(MafiaModel.userData.policeData.reward.xp,MafiaModel.languageData.getTextById);
            _loc7_.y = (_loc3_ + 0.5) * _loc4_.height;
            _loc7_.lineTop.visible = false;
            fightScreen.blankResultTooltip.holder.addChild(_loc7_);
            _loc7_.icon.addChild(_loc6_);
            _loc6_.toolTipText = MafiaModel.languageData.getTextById("generic_xp");
            _loc3_++;
            if(MafiaModel.userData.policeData.reward.policeBadges > 0)
            {
               _loc8_ = new MafiaPoliceResultTooltipHoover();
               _loc9_ = new RewardField();
               _loc9_.icon.gotoAndStop("policeBadge");
               _loc9_.txt_value.text = NumberStringHelper.groupString(MafiaModel.userData.policeData.reward.policeBadges,MafiaModel.languageData.getTextById);
               _loc9_.y = (_loc3_ + 0.5) * _loc4_.height;
               _loc9_.lineTop.visible = false;
               fightScreen.blankResultTooltip.holder.addChild(_loc9_);
               _loc9_.icon.addChild(_loc8_);
               _loc8_.toolTipText = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_5");
               _loc3_++;
            }
            fightScreen.blankResultTooltip.bg.height = this.RESULT_BG_HEIGHT + _loc3_ * _loc4_.height;
            fightScreen.blankResultTooltip.btn_close.y = this.RESULT_BTN_CLOSE_Y + _loc3_ * _loc4_.height;
            fightScreen.blankResultTooltip.btn_close.label = MafiaModel.languageData.getTextById("generic_btn_okay");
         }
         super.showFightResult(param1);
      }
      
      override protected function fillResult() : void
      {
      }
      
      override protected function showWinnerText() : void
      {
         if(!MafiaModel.specialEvent.breakingTheLawEvent.isEventActive)
         {
            fightScreen.policeResultTooltip.result.gotoAndStop(1);
            fightScreen.policeResultTooltip.result.txt_label.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_5");
         }
         else
         {
            fightScreen.blankResultTooltip.result.gotoAndStop(1);
            fightScreen.blankResultTooltip.result.txt_label.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_5");
         }
      }
      
      override protected function showLoserText() : void
      {
         if(!MafiaModel.specialEvent.breakingTheLawEvent.isEventActive)
         {
            fightScreen.policeResultTooltip.result.gotoAndStop(2);
            fightScreen.policeResultTooltip.result.txt_label.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_6");
         }
         else
         {
            fightScreen.blankResultTooltip.result.gotoAndStop(2);
            fightScreen.blankResultTooltip.result.txt_label.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_6");
         }
      }
      
      override protected function get fight() : MafiaFightResultData
      {
         return this._resultData.fightResult;
      }
      
      override protected function get resultPanel() : MovieClip
      {
         return fightScreen.policeResultTooltip;
      }
   }
}
