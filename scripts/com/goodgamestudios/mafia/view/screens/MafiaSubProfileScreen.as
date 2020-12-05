package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.RankingListType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.ranking.SearchRankingCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.MafiaArmamentData;
   import com.goodgamestudios.mafia.model.components.user.MafiaProfileData;
   import com.goodgamestudios.mafia.model.components.user.booster.MafiaBoosterData;
   import com.goodgamestudios.mafia.model.components.user.gang.MafiaGangData;
   import com.goodgamestudios.mafia.model.components.user.ranking.MafiaPlayerRankingData;
   import com.goodgamestudios.mafia.view.MafiaToolTipManager;
   import com.goodgamestudios.mafia.view.NewBasicStandartButton;
   import com.goodgamestudios.mafia.view.components.MafiaArmamentGrid;
   import com.goodgamestudios.mafia.view.tooltips.MafiaAchievementAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaFoodAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaGangMemberAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaAchievementAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaFoodAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaGangMemberAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.AchievementVO;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.items.FoodVO;
   import com.goodgamestudios.mafia.vo.items.GearVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class MafiaSubProfileScreen extends MafiaScreen
   {
       
      
      private var tabs:Vector.<MovieClip>;
      
      private var tabButtons:Vector.<NewBasicStandartButton>;
      
      protected var armamentGrid:MafiaArmamentGrid;
      
      public function MafiaSubProfileScreen(param1:DisplayObject)
      {
         super(param1);
         this.armamentGrid = new MafiaArmamentGrid(this.tabEquipment.grid);
         this.tabEquipment.txt_gear_title.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_equipment");
         this.tabEquipment.txt_armament_title.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_armament");
         this.tabAdditional.txt_gang.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_gang");
         this.tabAdditional.txt_booster.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_booster");
         this.tabAdditional.txt_duel_honor.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_honor");
         this.tabAdditional.txt_achievements.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_achievements");
         this.tabs = new Vector.<MovieClip>();
         this.tabs.push(this.tabEquipment);
         this.tabs.push(this.tabAdditional);
         this.tabButtons = new Vector.<NewBasicStandartButton>();
         this.tabButtons.push(this.mafiaSubProfile.tabs.tab_equipment);
         this.tabButtons.push(this.mafiaSubProfile.tabs.tab_gang_booster);
      }
      
      override public function show() : void
      {
         super.show();
         this.mafiaSubProfile.tabs.tab_equipment.label = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_equipment");
         this.mafiaSubProfile.tabs.tab_gang_booster.label = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_misc");
         this.switchToTab(this.tabEquipment);
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_PROFILE;
      }
      
      private function switchToTab(param1:MovieClip) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:NewBasicStandartButton = null;
         var _loc5_:* = false;
         var _loc2_:uint = 0;
         while(_loc2_ < this.tabs.length)
         {
            _loc3_ = this.tabs[_loc2_];
            _loc4_ = this.tabButtons[_loc2_];
            _loc5_ = _loc3_ == param1;
            _loc3_.visible = _loc4_.isFixed = _loc5_;
            _loc2_++;
         }
      }
      
      public function fillGear(param1:Vector.<GearVO>) : void
      {
         var _loc2_:String = null;
         var _loc3_:Class = null;
         var _loc4_:MovieClip = null;
         var _loc6_:ItemsInUse = null;
         var _loc7_:GearVO = null;
         var _loc8_:int = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = this.tabEquipment["itemsInUse" + (_loc5_ + 1)] as ItemsInUse;
            _loc6_.mouseEnabled = true;
            _loc6_.useHandCursor = false;
            _loc6_.buttonMode = false;
            while(_loc6_.item.numChildren > 0)
            {
               _loc6_.item.removeChildAt(0);
            }
            _loc7_ = param1[_loc5_];
            if(_loc7_ != null)
            {
               _loc4_ = MafiaItemData.getInstance().generateItemIcon(param1[_loc5_]);
               _loc6_.item.addChildAt(_loc4_,0);
               _loc6_.mouseChildren = false;
               _loc8_ = layoutManager.actState == Constants_LayoutStates.STATE_OTHERPROFILE?int(BasicCustomCursor.CURSOR_ARROW):int(BasicCustomCursor.CURSOR_HAND);
               _loc6_.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc4_.properties,TooltipDispPosition.Center,null,_loc8_);
            }
            else
            {
               _loc2_ = MafiaItemData.getInstance().generateItemPicClassname(ItemType.Gear,_loc5_ + 1,0,0);
               _loc3_ = getDefinitionByName(_loc2_) as Class;
               _loc4_ = new _loc3_();
               _loc6_.item.addChildAt(_loc4_,0);
               _loc6_.mouseChildren = false;
               _loc6_.toolTipVO = null;
               _loc4_.mouseEnabled = false;
               _loc4_.mouseChildren = false;
            }
            _loc5_++;
         }
      }
      
      public function fillArmament(param1:MafiaArmamentData) : void
      {
         this.armamentGrid.fill(param1);
      }
      
      public function fillFood(param1:Vector.<FoodVO>) : void
      {
         var _loc2_:String = null;
         var _loc3_:Class = null;
         var _loc4_:MovieClip = null;
         var _loc6_:Food = null;
         var _loc7_:FoodVO = null;
         var _loc8_:int = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = this.tabEquipment["food" + _loc5_] as Food;
            _loc6_.toolTipVO = null;
            _loc6_.mouseEnabled = true;
            while(_loc6_.item.numChildren > 0)
            {
               _loc6_.item.removeChildAt(0);
            }
            _loc7_ = param1[_loc5_];
            if(_loc7_ != null)
            {
               _loc4_ = MafiaItemData.getInstance().generateItemIcon(_loc7_);
               _loc4_.scaleX = _loc4_.scaleY = Constants_ViewScales.SCALE_FOOD_IN_PROFILE;
               _loc4_.mouseEnabled = false;
               _loc6_.item.addChildAt(_loc4_,0);
               _loc6_.mouseChildren = false;
               _loc8_ = layoutManager.actState == Constants_LayoutStates.STATE_OTHERPROFILE?int(BasicCustomCursor.CURSOR_ARROW):int(BasicCustomCursor.CURSOR_CLICK);
               _loc6_.toolTipVO = new TooltipVO(MafiaFoodAdvancedTooltip.NAME,new MafiaFoodAdvancedTooltipProperties(_loc4_.properties),new Point(_loc6_.x + _loc6_.parent.x + 130 - layoutManager.gameNullPoint,_loc6_.y + _loc6_.parent.y),MafiaToolTipManager.CENTERDISPSTATICPOS,_loc8_);
            }
            else
            {
               _loc2_ = MafiaItemData.getInstance().generateItemPicClassname(ItemType.Food,0,0,0);
               _loc3_ = getDefinitionByName(_loc2_) as Class;
               _loc4_ = new _loc3_();
               _loc6_.item.addChildAt(_loc4_,0);
               _loc6_.mouseChildren = false;
               _loc6_.toolTipVO = null;
               _loc6_.buttonMode = false;
               _loc6_.useHandCursor = false;
               _loc4_.mouseEnabled = false;
               _loc4_.mouseChildren = false;
            }
            _loc5_++;
         }
      }
      
      public function fillAvatarStats(param1:MafiaProfileData) : void
      {
         this.tabAdditional.fame.txt_title.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_honor");
         this.tabAdditional.fame.txt_glory.text = NumberStringHelper.groupString(param1.gloryDynamic,MafiaModel.languageData.getTextById);
         this.tabAdditional.fame.properties = param1.rankInHighScoreDynamic;
         var _loc2_:Array = [NumberStringHelper.groupString(param1.wonDuells,MafiaModel.languageData.getTextById),NumberStringHelper.groupString(param1.wonDuells + param1.lostDuells,MafiaModel.languageData.getTextById)];
         this.tabAdditional.txt_fights.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_duelstats",_loc2_);
         this.tabAdditional.txt_fights.height = this.tabAdditional.txt_fights.textHeight + 4;
         this.tabAdditional.txt_fights.mouseEnabled = false;
         updateAllTextFields();
      }
      
      public function fillAchievements(param1:Vector.<AchievementVO>) : void
      {
         var _loc3_:Achievements = null;
         var _loc4_:MovieClip = null;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = this.mafiaSubProfile.tab_additional["achievement" + _loc2_] as Achievements;
            _loc3_.mouseEnabled = true;
            if(_loc3_.numChildren == 2)
            {
               _loc3_.removeChildAt(1);
            }
            if(!(!env.invitefriends && _loc2_ == 7))
            {
               if(param1[_loc2_].achievementLevel == 0)
               {
                  _loc4_ = MafiaModel.userData.achievementsData.generateItem(param1[_loc2_]);
               }
               else
               {
                  _loc4_ = MafiaModel.userData.achievementsData.generateItem(param1[_loc2_]);
               }
               _loc3_.addChild(_loc4_);
               _loc4_.scaleX = _loc4_.scaleY = 0.8;
               _loc3_.toolTipVO = new TooltipVO(MafiaAchievementAdvancedTooltip.NAME,new MafiaAchievementAdvancedTooltipProperties(_loc4_.properties.achievementId,_loc4_.properties.achievementLevel,_loc4_.properties.achievementValue,_loc4_.properties.achievementNextValue),null,MafiaToolTipManager.OVERDISPSTATICPOS);
            }
            _loc2_++;
         }
      }
      
      public function fillBooster(param1:MafiaBoosterData) : void
      {
         this.mafiaSubProfile.tab_additional.boosterPicField.txt_noBooster.text = "";
         this.mafiaSubProfile.tab_additional.boosterPicField.txt_booster.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_questduration");
         this.mafiaSubProfile.tab_additional.boosterPicField.txt_traveltime.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_questduration");
         this.mafiaSubProfile.tab_additional.boosterPicField.txt_boostduration.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_boosterduration");
         MovieClipHelper.clearMovieClip(this.mafiaSubProfile.tab_additional.boosterPicField.holder);
         var _loc2_:Class = getDefinitionByName("BO" + param1.boosterID) as Class;
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.scaleX = _loc3_.scaleY = 0.6;
         this.mafiaSubProfile.tab_additional.boosterPicField.holder.addChild(_loc3_);
         this.mafiaSubProfile.tab_additional.boosterPicField.mouseChildren = false;
         this.mafiaSubProfile.tab_additional.boosterPicField.toolTipVO = null;
      }
      
      public function fillGang(param1:MafiaGangData) : void
      {
         var _loc4_:GangMemberContainer = null;
         var _loc5_:Sprite = null;
         var _loc2_:int = layoutManager.currentState == Constants_LayoutStates.STATE_OTHERPROFILE?int(BasicCustomCursor.CURSOR_ARROW):int(BasicCustomCursor.CURSOR_CLICK);
         var _loc3_:int = 0;
         while(_loc3_ < MafiaGangData.MAXGANGMEMBERS)
         {
            _loc4_ = this.tabAdditional.gang.getChildByName("member" + _loc3_) as GangMemberContainer;
            _loc4_.visible = true;
            _loc4_.toolTipVO = null;
            if(param1.playerGang.length > _loc3_)
            {
               if(param1.playerGang[_loc3_] != null)
               {
                  _loc4_.gotoAndStop(1);
                  MovieClipHelper.clearMovieClip(_loc4_.holder);
                  _loc4_.properties = param1.playerGang[_loc3_];
                  _loc5_ = param1.generateGangMemberPic(param1.playerGang[_loc3_].picID);
                  _loc4_.holder.addChild(_loc5_);
                  _loc5_.scaleX = _loc5_.scaleY = 0.15;
                  _loc4_.toolTipVO = new TooltipVO(MafiaGangMemberAdvancedTooltip.NAME,new MafiaGangMemberAdvancedTooltipProperties(_loc4_.properties,false),null,"",_loc2_);
               }
               else
               {
                  _loc4_.gotoAndStop(2);
                  if(layoutManager.currentState != Constants_LayoutStates.STATE_OTHERPROFILE)
                  {
                     _loc4_.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("MafiaGangScreen_copy_10")),null,"",_loc2_);
                  }
               }
            }
            else
            {
               _loc4_.gotoAndStop(3);
               if(layoutManager.currentState != Constants_LayoutStates.STATE_OTHERPROFILE)
               {
                  _loc4_.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("MafiaGangScreen_copy_11")),null,"",_loc2_);
               }
            }
            _loc4_.mouseChildren = false;
            _loc3_++;
         }
      }
      
      override public function destroy() : void
      {
         var _loc4_:ItemsInUse = null;
         var _loc5_:Food = null;
         var _loc6_:Achievements = null;
         var _loc1_:uint = 1;
         while(_loc1_ < 8)
         {
            _loc4_ = this.tabEquipment["itemsInUse" + _loc1_] as ItemsInUse;
            if(_loc4_.numChildren == 2)
            {
               _loc4_.removeChildAt(1);
            }
            _loc1_++;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < 3)
         {
            _loc5_ = this.tabEquipment["food" + _loc2_] as Food;
            if(_loc5_.numChildren == 2)
            {
               _loc5_.removeChildAt(1);
            }
            _loc2_++;
         }
         this.armamentGrid.clear();
         var _loc3_:uint = 0;
         while(_loc3_ < 10)
         {
            _loc6_ = this.mafiaSubProfile.tab_additional["achievement" + _loc3_] as Achievements;
            if(_loc6_.numChildren == 2)
            {
               _loc6_.removeChildAt(1);
            }
            _loc3_++;
         }
         super.destroy();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         if(param1.target is TextField)
         {
            return;
         }
         if(!param1.target.enabled)
         {
            return;
         }
         super.onClick(param1);
         var _loc3_:* = this.mafiaSubProfile.tabs;
         switch(param1.target)
         {
            case this.mafiaSubProfile.tabs.tab_equipment:
               this.switchToTab(this.tabEquipment);
               break;
            case this.mafiaSubProfile.tabs.tab_gang_booster:
               this.switchToTab(this.tabAdditional);
               break;
            case this.tabAdditional.fame:
               SearchRankingCommand.sendCommand(RankingListType.PlayerDynamic,"1",MafiaPlayerRankingData.TOP_RANKING_LENGTH);
               SearchRankingCommand.sendCommand(RankingListType.PlayerDynamic,this.tabAdditional.fame.properties,MafiaPlayerRankingData.RANKING_LIST_LENGTH);
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         super.onMouseOver(param1);
         switch(param1.target)
         {
            case this.mafiaSubProfile.tabs.tab_equipment:
            case this.mafiaSubProfile.tabs.tab_gang_booster:
               if(!(param1.target as NewBasicStandartButton).isFixed)
               {
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
               }
               break;
            case this.mafiaSubProfile.fame:
               super.onMouseOver(param1);
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         super.onMouseOut(param1);
         switch(param1.target)
         {
            case this.mafiaSubProfile.fame:
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      protected function get tabEquipment() : MafiaSubProfileEquipment
      {
         return this.mafiaSubProfile.tab_equipment;
      }
      
      protected function get tabAdditional() : MafiaSubProfileAdditional
      {
         return this.mafiaSubProfile.tab_additional;
      }
      
      protected function get mafiaSubProfile() : MafiaSubProfile
      {
         return disp as MafiaSubProfile;
      }
   }
}
