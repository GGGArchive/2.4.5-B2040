package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_City_Quests;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.CityFightProgress;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.commands.fight.SelectCityFightItemCommand;
   import com.goodgamestudios.mafia.controller.commands.fight.StartCityFightCommand;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBonusQuestScreenProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.utils.getDefinitionByName;
   
   public class MafiaBonusOpponentQuestScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaBonusOpponentQuestScreen";
       
      
      public function MafiaBonusOpponentQuestScreen(param1:Sprite)
      {
         super(param1,false);
      }
      
      override public function show() : void
      {
         super.show();
         this.updateState();
         this.updateProgressbar();
         this.standardScreen.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
         this.standardScreen.btn_close.label = MafiaModel.languageData.getTextById("generic_btn_goback");
         this.standardScreen.backLayer.width = this.standardScreen.btn_close.width + 10;
         this.standardScreen.filters = [new DropShadowFilter(3,45,0,0.3,3,3)];
         controller.addEventListener(MafiaQuestEvent.CHANGE_CITY_FIGHT_ITEMS_DATA,this.updateItemsData);
         controller.addEventListener(MafiaQuestEvent.CHANGE_CITY_FIGHT_DATA,this.updateFightData);
         controller.addEventListener(MafiaQuestEvent.REMOVE_CITY_FIGHT_TIMER,this.onRemoveDuelTimer);
         controller.addEventListener(MafiaQuestEvent.CHANGE_CITY_FIGHT_TIMER,this.onDuelTimer);
      }
      
      override protected function applyProperties() : void
      {
         this.fillInfoText();
      }
      
      override public function hide() : void
      {
         super.hide();
         controller.removeEventListener(MafiaQuestEvent.CHANGE_CITY_FIGHT_ITEMS_DATA,this.updateItemsData);
         controller.removeEventListener(MafiaQuestEvent.CHANGE_CITY_FIGHT_DATA,this.updateFightData);
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaQuestEvent.CHANGE_CITY_FIGHT_ITEMS_DATA,this.updateItemsData);
         controller.removeEventListener(MafiaQuestEvent.CHANGE_CITY_FIGHT_DATA,this.updateFightData);
      }
      
      private function updateItemsData(param1:MafiaQuestEvent) : void
      {
         this.fillOpponent();
         this.updateState();
         this.updateProgressbar();
         this.fillItems();
      }
      
      private function updateFightData(param1:MafiaQuestEvent) : void
      {
         this.fillOpponent();
         this.updateState();
         this.updateProgressbar();
      }
      
      private function fillItems() : void
      {
         var _loc2_:ItemVO = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:QuestRewardItem = null;
         var _loc1_:int = 0;
         while(_loc1_ < MafiaModel.userData.cityQuestFightData.items.length)
         {
            _loc2_ = MafiaModel.userData.cityQuestFightData.items[_loc1_];
            _loc3_ = MafiaItemData.getInstance().generateItemIcon(_loc2_);
            _loc4_ = _loc3_.getChildByName("itemPic") as MovieClip;
            _loc5_ = this.standardScreen["reward" + _loc1_] as QuestRewardItem;
            MovieClipHelper.clearMovieClip(_loc5_);
            _loc4_.scaleX = _loc4_.scaleY = Constants_ViewScales.SCALE_SHOP_ITEMS;
            _loc5_.addChild(_loc3_);
            _loc5_.filters = [new GlowFilter(16777215,0.5,16,16,3)];
            MovieClipHelper.scaleDownToFit(_loc4_,_loc5_.width,_loc5_.height);
            if(_loc2_.amount > 1)
            {
               _loc5_.amount.visible = true;
               _loc5_.amount.txt_amount.text = _loc2_.amount;
            }
            else
            {
               _loc5_.amount.visible = false;
            }
            this.setItemTooltip(_loc5_,_loc2_,0,BasicCustomCursor.CURSOR_CLICK);
            _loc1_++;
         }
      }
      
      protected function setItemTooltip(param1:MovieClip, param2:ItemVO, param3:uint, param4:int) : void
      {
         param1.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(param2,TooltipDispPosition.Over,null,param4);
      }
      
      private function fillInfoText() : void
      {
         this.standardScreen.txt_title.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_5");
         switch(this.standardScreenProperties.gangwar.cityFightProgress)
         {
            case CityFightProgress.FightAvailable:
               this.standardScreen.txt_copy.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_6");
               this.standardScreen.txt_copy1.text = "";
               this.standardScreen.txt_reward.text = MafiaModel.languageData.getTextById("MafiaLevelUpDialog_copy_5");
               break;
            case CityFightProgress.FightWon:
               this.standardScreen.txt_copy.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_8");
               this.standardScreen.txt_copy1.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_9");
               this.standardScreen.txt_reward.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_10");
               break;
            case CityFightProgress.Reward_taken:
               this.standardScreen.txt_copy.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_3") + " " + (this.standardScreenProperties.gangwar.district_id + 1);
               this.standardScreen.txt_copy1.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_8");
               this.standardScreen.txt_reward.text = "";
         }
      }
      
      private function updateState() : void
      {
         switch(this.standardScreenProperties.gangwar.cityFightProgress)
         {
            case CityFightProgress.FightAvailable:
               this.standardScreen.btn_reward0.visible = true;
               this.standardScreen.btn_reward1.visible = true;
               this.standardScreen.btn_reward2.visible = true;
               this.standardScreen.btn_reward0.enableButton = false;
               this.standardScreen.btn_reward1.enableButton = false;
               this.standardScreen.btn_reward2.enableButton = false;
               this.standardScreen.reward0.visible = false;
               this.standardScreen.reward1.visible = false;
               this.standardScreen.reward2.visible = false;
               this.standardScreen.btn_ok.visible = false;
               this.standardScreen.opponentMask.visible = false;
               this.standardScreen.opponent.mask = null;
               this.standardScreen.opponent.shot.visible = false;
               this.standardScreen.opponent.strips.visible = false;
               this.standardScreen.opponent.btn_attack.visible = true;
               this.standardScreen.opponent.level.gotoAndStop(1);
               this.standardScreen.bg.visible = true;
               break;
            case CityFightProgress.FightWon:
               this.standardScreen.btn_reward0.visible = true;
               this.standardScreen.btn_reward1.visible = true;
               this.standardScreen.btn_reward2.visible = true;
               this.standardScreen.btn_reward0.enableButton = true;
               this.standardScreen.btn_reward1.enableButton = true;
               this.standardScreen.btn_reward2.enableButton = true;
               this.standardScreen.reward0.visible = true;
               this.standardScreen.reward1.visible = true;
               this.standardScreen.reward2.visible = true;
               this.standardScreen.btn_ok.visible = true;
               this.standardScreen.btn_ok.enableButton = false;
               this.standardScreen.btn_ok.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_pickReward");
               this.standardScreen.opponent.mask = this.standardScreen.opponentMask;
               this.standardScreen.opponentMask.visible = true;
               this.standardScreen.opponent.shot.visible = true;
               this.standardScreen.opponent.strips.visible = true;
               this.standardScreen.opponent.btn_attack.visible = false;
               this.standardScreen.opponent.level.gotoAndStop(2);
               this.standardScreen.bg.visible = true;
               break;
            case CityFightProgress.Reward_taken:
               this.standardScreen.btn_ok.visible = false;
               this.standardScreen.btn_reward0.visible = false;
               this.standardScreen.btn_reward1.visible = false;
               this.standardScreen.btn_reward2.visible = false;
               this.standardScreen.reward0.visible = false;
               this.standardScreen.reward1.visible = false;
               this.standardScreen.reward2.visible = false;
               this.standardScreen.opponent.mask = this.standardScreen.opponentMask;
               this.standardScreen.opponentMask.visible = true;
               this.standardScreen.opponentMask.cacheAsBitmap = true;
               this.standardScreen.opponent.shot.visible = true;
               this.standardScreen.opponent.strips.visible = true;
               this.standardScreen.opponent.btn_attack.visible = false;
               this.standardScreen.opponent.level.gotoAndStop(2);
               this.standardScreen.bg.visible = false;
         }
      }
      
      private function updateProgressbar() : void
      {
         this.standardScreen.progress.visible = true;
         var _loc1_:QuestBonusBar = this.standardScreen.progress;
         var _loc2_:Number = 0;
         switch(this.standardScreenProperties.gangwar.cityFightProgress)
         {
            case CityFightProgress.FightAvailable:
               _loc1_.txt_description.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_7");
               _loc1_.txt_progress.text = 0 + "/" + 1;
               _loc2_ = 0 / 1;
               _loc1_.bar_progress.bar.scaleX = _loc2_;
               _loc1_.check.visible = false;
               _loc1_.holder.gotoAndStop(9);
               break;
            case CityFightProgress.FightWon:
               _loc1_.txt_description.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_7");
               _loc1_.txt_progress.text = 1 + "/" + 1;
               _loc2_ = 1 / 1;
               _loc1_.bar_progress.bar.scaleX = _loc2_;
               _loc1_.check.visible = true;
               _loc1_.holder.gotoAndStop(9);
               break;
            case CityFightProgress.Reward_taken:
               _loc1_.visible = false;
         }
      }
      
      private function fillOpponent() : void
      {
         var _loc2_:Class = null;
         var _loc3_:Sprite = null;
         TextFieldHelper.changeTextFromatSizeByTextWidth(35,this.standardScreen.opponent.level.txt_level,MafiaModel.userData.cityQuestFightData.level.toString());
         var _loc1_:int = MafiaModel.userData.cityQuestFightData.picId;
         _loc2_ = getDefinitionByName("Enemy" + Constants_City_Quests.ENEMY_PIC_ID_LIST[_loc1_ - 1][1]) as Class;
         _loc3_ = new _loc2_();
         _loc3_.scaleX = _loc3_.scaleY = Constants_ViewScales.SCALE_AVATAR_BONUS_CITY_OPPONENT;
         MovieClipHelper.clearMovieClip(this.standardScreen.opponent.mc_holder);
         this.standardScreen.opponent.mc_holder.addChild(_loc3_);
         var _loc4_:ColorMatrix = new ColorMatrix();
         _loc4_.reset();
         this.standardScreen.opponent.mc_holder.filters = [_loc4_.filter];
         if(this.standardScreenProperties.gangwar.cityFightProgress != CityFightProgress.FightAvailable)
         {
            _loc4_.adjustSaturation(0.1);
            _loc4_.adjustBrightness(-50,-50,-50);
            this.standardScreen.opponent.mc_holder.filters = [_loc4_.filter];
            this.standardScreen.opponent.bg.filters = [_loc4_.filter];
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardScreen.btn_ok:
               if(this.standardScreen.btn_ok.enabled)
               {
                  SelectCityFightItemCommand.sendCommand(this.standardScreenProperties.gangwar.district_id,this.standardScreen.btn_ok.properties);
                  this.hide();
               }
               break;
            case this.standardScreen.btn_close:
               layoutManager.state = Constants_LayoutStates.STATE_GANGWARS;
               this.hide();
               break;
            case this.standardScreen.opponent.btn_attack:
               StartCityFightCommand.sendCommand(this.standardScreenProperties.gangwar.district_id);
               this.hide();
               break;
            case this.standardScreen.btn_reward0:
            case this.standardScreen.reward0:
               this.standardScreen.btn_reward0.isFixed = true;
               this.standardScreen.btn_reward1.isFixed = false;
               this.standardScreen.btn_reward2.isFixed = false;
               this.standardScreen.btn_ok.enableButton = true;
               this.standardScreen.btn_ok.toolTipText = null;
               this.standardScreen.btn_ok.properties = 0;
               break;
            case this.standardScreen.btn_reward1:
            case this.standardScreen.reward1:
               this.standardScreen.btn_reward1.isFixed = true;
               this.standardScreen.btn_reward0.isFixed = false;
               this.standardScreen.btn_reward2.isFixed = false;
               this.standardScreen.btn_ok.enableButton = true;
               this.standardScreen.btn_ok.toolTipText = null;
               this.standardScreen.btn_ok.properties = 1;
               break;
            case this.standardScreen.btn_reward2:
            case this.standardScreen.reward2:
               this.standardScreen.btn_reward2.isFixed = true;
               this.standardScreen.btn_reward0.isFixed = false;
               this.standardScreen.btn_reward1.isFixed = false;
               this.standardScreen.btn_ok.enableButton = true;
               this.standardScreen.btn_ok.toolTipText = null;
               this.standardScreen.btn_ok.properties = 2;
         }
      }
      
      private function onDuelTimer(param1:MafiaQuestEvent) : void
      {
         this.standardScreen.opponent.btn_attack.goldInfoVisible = true;
         this.standardScreen.opponent.btn_attack.goldInfoTimeText = MafiaModel.languageData.getTextById("tt_MafiaButton_forfree") + " " + param1.params[0];
         this.standardScreen.opponent.btn_attack.goldInfoGoldText = MafiaModel.goldConstants.cutNextFreeDuelTimePricePerSecond.toString();
      }
      
      private function onRemoveDuelTimer(param1:MafiaQuestEvent) : void
      {
         this.standardScreen.opponent.btn_attack.goldInfoVisible = false;
      }
      
      protected function get standardScreenProperties() : MafiaBonusQuestScreenProperties
      {
         return properties as MafiaBonusQuestScreenProperties;
      }
      
      protected function get standardScreen() : MafiaBonusOpponentQuest
      {
         return disp as MafiaBonusOpponentQuest;
      }
   }
}
