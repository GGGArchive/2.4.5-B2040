package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.commands.clan.ShowClanCommand;
   import com.goodgamestudios.mafia.event.model.MafiaEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.helper.FamilyCrestHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.MafiaClanData;
   import com.goodgamestudios.mafia.view.panels.MafiaClanMemberPanel;
   import com.goodgamestudios.mafia.view.panels.properties.MafiaTroopMemberPanelProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaClanExperienceAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaExperienceAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   
   public class MafiaClanScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaClanScreen";
       
      
      protected var entryCount:int;
      
      protected var maxEntryScroll:int;
      
      protected const MAX_MEMBERS:uint = 25;
      
      protected const MEMBERLISTNULLPOINT:Number = 57.35;
      
      protected const MEMBERLISTMIDDLEPOINT:Number = -132;
      
      protected const MEMBERLISTMAXPOINT:Number = -321;
      
      protected var layerFilter:DropShadowFilter;
      
      public function MafiaClanScreen(param1:DisplayObject)
      {
         this.layerFilter = new DropShadowFilter(4.2,45,0,0.5,15,15,1,1);
         super(param1);
         this.clan.txt_version.text = env.versionText;
         this.clan.basicInfo.txt_bonus.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_2");
         this.clan.basicInfo.fame.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_honor");
         this.clan.basicInfo.rank.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_rank");
         this.clan.troopWarInfo.btn_war.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyDialog_title_familywar");
         this.clan.members.txt_name.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_8");
         this.clan.members.txt_level.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_12");
         this.clan.members.txt_rang.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_10");
         this.clan.members.txt_members.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_4");
         this.clan.members.btn_members.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_4");
         this.clan.basicInfo.txt_userXPBonusTitle.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_15");
         this.clan.basicInfo.txt_userCashBonusTitle.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_15");
         this.clan.basicInfo.bonus.visible = false;
         this.clan.basicInfo.btn_editCrest.visible = false;
         this.clan.pinboard.txt_title.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_19");
         this.clan.setChildIndex(this.clan.troopWarInfo,this.clan.numChildren - 1);
         this.clan.troopWarInfo.filters = [this.layerFilter];
         this.setupMainInfoLayers(1);
         this.clan.bonusInfo.mc_helpslider.visible = false;
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_CLAN;
      }
      
      override public function show() : void
      {
         super.show();
         MovieClipHelper.clearMovieClip(this.clan.basicInfo.crestHolder);
         this.clan.members.list.y = this.MEMBERLISTNULLPOINT;
         this.maxEntryScroll = 0;
         this.clan.members.addEventListener(MouseEvent.ROLL_OVER,this.onOverMembers);
         this.clan.members.addEventListener(MouseEvent.ROLL_OUT,this.onOutMembers);
      }
      
      override public function hide() : void
      {
         layoutManager.hidePanel(MafiaClanMemberPanel.NAME);
         super.hide();
      }
      
      override protected function removeEvents() : void
      {
         this.clan.members.removeEventListener(MouseEvent.ROLL_OVER,this.onOverMembers);
         this.clan.members.removeEventListener(MouseEvent.ROLL_OUT,this.onOutMembers);
         super.removeEvents();
      }
      
      private function onOverMembers(param1:MouseEvent) : void
      {
         disp.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      }
      
      private function onOutMembers(param1:MouseEvent) : void
      {
         disp.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         if(param1.delta > 0)
         {
            if(this.clan.members.btn_membersUp.enabled)
            {
               this.onScrollMembersUp();
            }
         }
         else if(param1.delta < 0)
         {
            if(this.clan.members.btn_membersDown.enabled)
            {
               this.onScrollMembersDown();
            }
         }
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            this.clan.members.list.y = this.MEMBERLISTNULLPOINT;
            super.updatePosition();
         }
      }
      
      protected function onClanData(param1:MafiaEvent) : void
      {
      }
      
      protected function updatePinboard() : void
      {
         if(MafiaModel.userData.userClan.pinboard_content)
         {
            this.clan.pinboard.txt_copy.text = MafiaModel.userData.userClan.pinboard_content;
         }
         else
         {
            this.clan.pinboard.txt_copy.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_20");
         }
         if(MafiaModel.userData.userClan.pinboard_lastChangedBy)
         {
            this.clan.pinboard.txt_last_edit.text = MafiaModel.userData.userClan.pinboard_lastChangedBy;
         }
         else
         {
            this.clan.pinboard.txt_last_edit.text = "";
         }
         this.clan.pinboard.btn_edit.enableButton = MafiaModel.userData.userClan.pinboard_writeRights;
         if(this.clan.pinboard.btn_edit.enabled)
         {
            this.clan.pinboard.btn_edit.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_editBulletinBoard");
         }
         else
         {
            this.clan.pinboard.btn_edit.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_23");
         }
      }
      
      protected function fillClan(param1:MafiaClanData) : void
      {
         MovieClipHelper.clearMovieClip(this.clan.basicInfo.crestHolder);
         var _loc2_:Sprite = FamilyCrestHelper.createFamilyCrest(param1.familyCrest,param1.clanName);
         _loc2_.scaleX = _loc2_.scaleY = 0.95;
         this.clan.basicInfo.crestHolder.addChild(_loc2_);
         this.clan.basicInfo.txt_troupname.embedFonts = true;
         this.clan.basicInfo.txt_troupname.text = param1.clanName;
         if(this.clan.basicInfo.txt_troupname.textWidth == 0)
         {
            this.clan.basicInfo.txt_troupname.embedFonts = false;
            this.clan.basicInfo.txt_troupname.text = param1.clanName;
         }
         this.clan.basicInfo.txt_troopCashBonus.text = param1.cashBoosterAmountForFamily.toString() + "%";
         this.clan.basicInfo.txt_troopXPBonus.text = param1.xpBoosterAmountForFamily.toString() + "%";
         this.clan.basicInfo.txt_trooplevel.text = param1.level.toString();
         this.clan.basicInfo.txt_rank.text = NumberStringHelper.groupString(param1.rankDynamic,MafiaModel.languageData.getTextById);
         this.clan.basicInfo.txt_glory.text = NumberStringHelper.groupString(param1.gloryDynamic,MafiaModel.languageData.getTextById);
         this.clan.troopWarInfo.btn_attack.properties = null;
         this.clan.troopWarInfo.btn_defend.properties = null;
         this.clan.troopWarInfo.txt_defendTime.text = "";
         this.clan.troopWarInfo.txt_attackTime.text = "";
         if(param1.defendingAgainstClanID > 0)
         {
            this.clan.troopWarInfo.txt_defendTime.text = param1.defendingAgainstClanName + " " + param1.defendTime;
            this.clan.troopWarInfo.btn_defend.properties = param1.defendingAgainstClanID;
         }
         if(param1.attackingAnotherClanID > 0)
         {
            this.clan.troopWarInfo.txt_attackTime.text = param1.attackingAnotherClanName + " " + param1.attackTime;
            this.clan.troopWarInfo.btn_attack.properties = param1.attackingAnotherClanID;
         }
         this.clan.basicInfo.bar.mouseChildren = false;
         this.clan.basicInfo.xp.mouseChildren = false;
         this.clan.basicInfo.xp.toolTipVO = new TooltipVO(MafiaClanExperienceAdvancedTooltip.NAME,new MafiaExperienceAdvancedTooltipProperties(param1.xp,param1.xpForThisLevel,param1.xpForNextLevel),new Point(364,314),"",BasicCustomCursor.CURSOR_ARROW);
         var _loc3_:Number = (param1.xp - param1.xpForThisLevel) / (param1.xpForNextLevel - param1.xpForThisLevel);
         this.clan.basicInfo.bar.scaleX = Math.min(_loc3_,1);
      }
      
      protected function fillClanMembers(param1:MafiaClanData) : void
      {
         var _loc3_:ClanMemberLine = null;
         var _loc4_:Sprite = null;
         var _loc5_:ClanRank = null;
         var _loc6_:AttackRegister = null;
         var _loc7_:DefendRegister = null;
         this.entryCount = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < 25)
         {
            _loc3_ = this.clan.members.list["member" + _loc2_] as ClanMemberLine;
            this.resetMemberLine(_loc3_);
            if(param1.members.length - 1 < _loc2_)
            {
               _loc3_.visible = false;
            }
            else
            {
               this.entryCount++;
               _loc3_.visible = true;
               _loc3_.properties = 1;
               _loc3_.txt_name.embedFonts = true;
               _loc3_.txt_name.text = param1.members[_loc2_].name;
               if(_loc3_.txt_name.textWidth == 0)
               {
                  _loc3_.txt_name.embedFonts = false;
                  _loc3_.txt_name.text = param1.members[_loc2_].name;
               }
               _loc3_.txt_level.text = param1.members[_loc2_].level.toString();
               _loc3_.txt_rank.text = NumberStringHelper.groupString(param1.members[_loc2_].rankInHighScore,MafiaModel.languageData.getTextById);
               _loc4_ = AvatarHelper.createClassSymbol(param1.members[_loc2_].characterClass,0.5);
               _loc3_.mc_class.addChildAt(_loc4_,0);
               _loc5_ = new ClanRank();
               _loc5_.gotoAndStop(param1.members[_loc2_].rankInClan.index);
               _loc5_.scaleX = _loc5_.scaleY = 0.8;
               _loc3_.mc_rank.addChild(_loc5_);
               if(param1.members[_loc2_].attackParticipation)
               {
                  _loc6_ = new AttackRegister();
                  _loc3_.mc_attack.addChild(_loc6_);
                  _loc6_.scaleX = _loc6_.scaleY = 0.9;
               }
               if(param1.members[_loc2_].defendParticipation)
               {
                  _loc7_ = new DefendRegister();
                  _loc3_.mc_defend.addChild(_loc7_);
                  _loc7_.scaleX = _loc7_.scaleY = 0.9;
               }
               _loc3_.mc_online.visible = false;
               _loc3_.mouseChildren = false;
               _loc3_.properties = [param1.members[_loc2_].playerID,param1.members[_loc2_].clanID,param1.members[_loc2_].rankInClan,param1.members[_loc2_].name];
            }
            _loc2_++;
         }
         if(this.entryCount > 10 && this.entryCount <= 18)
         {
            this.maxEntryScroll = this.MEMBERLISTMIDDLEPOINT;
         }
         else if(this.entryCount > 18)
         {
            this.maxEntryScroll = this.MEMBERLISTMAXPOINT;
         }
         else
         {
            this.maxEntryScroll = this.MEMBERLISTNULLPOINT;
         }
         this.updateScrollButtons();
      }
      
      protected function updateScrollButtons() : void
      {
         if(this.entryCount <= 9)
         {
            this.clan.members.btn_membersDown.enableButton = false;
            this.clan.members.btn_membersUp.enableButton = false;
            return;
         }
         this.clan.members.btn_membersDown.enableButton = true;
         this.clan.members.btn_membersUp.enableButton = true;
         switch(this.clan.members.list.y)
         {
            case this.MEMBERLISTNULLPOINT:
               this.clan.members.btn_membersUp.enableButton = false;
               break;
            case this.MEMBERLISTMIDDLEPOINT:
               if(this.entryCount <= 18)
               {
                  this.clan.members.btn_membersDown.enableButton = false;
               }
               break;
            case this.MEMBERLISTMAXPOINT:
               this.clan.members.btn_membersDown.enableButton = false;
         }
      }
      
      protected function resetMemberLine(param1:ClanMemberLine) : void
      {
         param1.rankingLineBG.gotoAndStop(1);
         param1.rankingLineBG.alpha = 0;
         while(param1.mc_rank.numChildren > 0)
         {
            param1.mc_rank.removeChildAt(0);
         }
         while(param1.mc_attack.numChildren > 0)
         {
            param1.mc_attack.removeChildAt(0);
         }
         while(param1.mc_defend.numChildren > 0)
         {
            param1.mc_defend.removeChildAt(0);
         }
         while(param1.mc_class.numChildren > 0)
         {
            param1.mc_class.removeChildAt(0);
         }
         param1.properties = 0;
         param1.txt_level.text = "";
         param1.txt_rank.text = "";
         param1.txt_name.text = "";
      }
      
      private function onScrollMembersDown() : void
      {
         if(this.clan.members.list.y > this.maxEntryScroll)
         {
            switch(this.clan.members.list.y)
            {
               case this.MEMBERLISTNULLPOINT:
                  this.clan.members.list.y = this.MEMBERLISTMIDDLEPOINT;
                  break;
               case this.MEMBERLISTMIDDLEPOINT:
                  this.clan.members.list.y = this.MEMBERLISTMAXPOINT;
            }
            this.updateScrollButtons();
         }
      }
      
      private function onScrollMembersUp() : void
      {
         if(this.clan.members.list.y < this.MEMBERLISTNULLPOINT)
         {
            switch(this.clan.members.list.y)
            {
               case this.MEMBERLISTMAXPOINT:
                  this.clan.members.list.y = this.MEMBERLISTMIDDLEPOINT;
                  break;
               case this.MEMBERLISTMIDDLEPOINT:
                  this.clan.members.list.y = this.MEMBERLISTNULLPOINT;
            }
            this.updateScrollButtons();
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:ClanMemberLine = null;
         super.onClick(param1);
         if(param1.target is ClanMemberLine)
         {
            _loc2_ = param1.target as ClanMemberLine;
            layoutManager.showSpecificPanel(MafiaClanMemberPanel.NAME,new MafiaTroopMemberPanelProperties(_loc2_));
            return;
         }
         switch(param1.target)
         {
            case this.clan.troopWarInfo.txt_attackTime:
               if(this.clan.troopWarInfo.btn_attack.properties > 0)
               {
                  if(this.clan.troopWarInfo.btn_attack.properties == MafiaModel.userData.profileData.clanID)
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
                  }
                  else
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_OTHERCLAN;
                  }
                  ShowClanCommand.sendCommand(this.clan.troopWarInfo.btn_attack.properties);
               }
               break;
            case this.clan.troopWarInfo.txt_defendTime:
               if(this.clan.troopWarInfo.btn_defend.properties > 0)
               {
                  if(this.clan.troopWarInfo.btn_defend.properties == MafiaModel.userData.profileData.clanID)
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
                  }
                  else
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_OTHERCLAN;
                  }
                  ShowClanCommand.sendCommand(this.clan.troopWarInfo.btn_defend.properties);
               }
               break;
            case this.clan.members.btn_membersDown:
               if(this.clan.members.btn_membersDown.enabled)
               {
                  this.onScrollMembersDown();
                  this.updateScrollButtons();
               }
               break;
            case this.clan.members.btn_membersUp:
               if(this.clan.members.btn_membersUp.enabled)
               {
                  this.onScrollMembersUp();
                  this.updateScrollButtons();
               }
               break;
            case this.clan.basicInfo.fame:
            case this.clan.basicInfo.rank:
               layoutManager.state = Constants_LayoutStates.STATE_CLANRANKING;
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:ClanMemberLine = null;
         if(0)
         {
         }
         if(param1.target is ClanMemberLine)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            _loc2_ = param1.target as ClanMemberLine;
            if(_loc2_.properties == 1)
            {
               _loc2_.rankingLineBG.alpha = 1;
            }
         }
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:ClanMemberLine = null;
         if(0)
         {
         }
         if(param1.target is ClanMemberLine)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            _loc2_ = param1.target as ClanMemberLine;
            if(_loc2_.properties == 1)
            {
               _loc2_.rankingLineBG.alpha = 0;
            }
         }
         super.onMouseOut(param1);
      }
      
      protected function setupMainInfoLayers(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               this.clan.setChildIndex(this.clan.members,this.clan.numChildren - 2);
               this.clan.members.filters = [this.layerFilter];
               this.clan.donate.filters = [];
               this.clan.members.btn_members.y = -18.75;
               this.clan.members.bg_members.gotoAndStop(1);
               this.clan.donate.btn_bank.y = -15.75;
               this.clan.donate.bg_bank.gotoAndStop(2);
               this.clan.bonusInfo.filters = [];
               this.clan.bonusInfo.btn_bonus.y = -15.75;
               this.clan.bonusInfo.bg_bonus.gotoAndStop(2);
               this.clan.troupchat.filters = [];
               this.clan.troupchat.btn_chat.y = -15.75;
               this.clan.troupchat.bg_chat.gotoAndStop(2);
               this.clan.pinboard.btn_pinboard.y = -15.75;
               this.clan.pinboard.bg_pinboard.gotoAndStop(2);
               break;
            case 2:
               this.clan.setChildIndex(this.clan.donate,this.clan.numChildren - 2);
               this.clan.members.filters = [];
               this.clan.donate.filters = [this.layerFilter];
               this.clan.members.btn_members.y = -15.75;
               this.clan.members.bg_members.gotoAndStop(2);
               this.clan.donate.btn_bank.y = -18.75;
               this.clan.donate.bg_bank.gotoAndStop(1);
               this.clan.bonusInfo.filters = [];
               this.clan.bonusInfo.btn_bonus.y = -15.75;
               this.clan.bonusInfo.bg_bonus.gotoAndStop(2);
               this.clan.troupchat.filters = [];
               this.clan.troupchat.btn_chat.y = -15.75;
               this.clan.troupchat.bg_chat.gotoAndStop(2);
               this.clan.pinboard.btn_pinboard.y = -15.75;
               this.clan.pinboard.bg_pinboard.gotoAndStop(2);
               break;
            case 3:
               this.clan.setChildIndex(this.clan.bonusInfo,this.clan.numChildren - 2);
               this.clan.bonusInfo.filters = [this.layerFilter];
               this.clan.members.filters = [];
               this.clan.donate.filters = [];
               this.clan.bonusInfo.btn_bonus.y = -18.75;
               this.clan.bonusInfo.bg_bonus.gotoAndStop(1);
               this.clan.members.btn_members.y = -15.75;
               this.clan.members.bg_members.gotoAndStop(2);
               this.clan.donate.btn_bank.y = -15.75;
               this.clan.donate.bg_bank.gotoAndStop(2);
               this.clan.troupchat.filters = [];
               this.clan.troupchat.btn_chat.y = -15.75;
               this.clan.troupchat.bg_chat.gotoAndStop(2);
               this.clan.pinboard.btn_pinboard.y = -15.75;
               this.clan.pinboard.bg_pinboard.gotoAndStop(2);
               break;
            case 4:
               this.clan.setChildIndex(this.clan.troupchat,this.clan.numChildren - 2);
               this.clan.troupchat.filters = [this.layerFilter];
               this.clan.members.filters = [];
               this.clan.donate.filters = [];
               this.clan.bonusInfo.filters = [];
               this.clan.troupchat.btn_chat.y = -18.75;
               this.clan.troupchat.bg_chat.gotoAndStop(1);
               this.clan.donate.btn_bank.y = -15.75;
               this.clan.donate.bg_bank.gotoAndStop(2);
               this.clan.bonusInfo.btn_bonus.y = -15.75;
               this.clan.bonusInfo.bg_bonus.gotoAndStop(2);
               this.clan.members.btn_members.y = -15.75;
               this.clan.members.bg_members.gotoAndStop(2);
               this.clan.pinboard.btn_pinboard.y = -15.75;
               this.clan.pinboard.bg_pinboard.gotoAndStop(2);
               break;
            case 5:
               this.clan.setChildIndex(this.clan.pinboard,this.clan.numChildren - 2);
               this.clan.pinboard.filters = [this.layerFilter];
               this.clan.troupchat.filters = [];
               this.clan.members.filters = [];
               this.clan.donate.filters = [];
               this.clan.bonusInfo.filters = [];
               this.clan.pinboard.btn_pinboard.y = -18.75;
               this.clan.pinboard.bg_pinboard.gotoAndStop(1);
               this.clan.troupchat.btn_chat.y = -15.75;
               this.clan.troupchat.bg_chat.gotoAndStop(2);
               this.clan.donate.btn_bank.y = -15.75;
               this.clan.donate.bg_bank.gotoAndStop(2);
               this.clan.bonusInfo.btn_bonus.y = -15.75;
               this.clan.bonusInfo.bg_bonus.gotoAndStop(2);
               this.clan.members.btn_members.y = -15.75;
               this.clan.members.bg_members.gotoAndStop(2);
         }
      }
      
      protected function get clan() : MafiaClan
      {
         return disp as MafiaClan;
      }
      
      protected function get crestVO() : FamilyCrestVO
      {
         return null;
      }
   }
}
