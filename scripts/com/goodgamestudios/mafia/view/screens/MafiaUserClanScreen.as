package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.constants.GoodgamePartners;
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.graphics.utils.ColorUtils;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.ChangeClanMemberType;
   import com.goodgamestudios.mafia.constants.enums.FamilyBoosterQuality;
   import com.goodgamestudios.mafia.constants.enums.FamilyRank;
   import com.goodgamestudios.mafia.constants.enums.RankingListType;
   import com.goodgamestudios.mafia.controller.commands.clan.DonateFamilyCommand;
   import com.goodgamestudios.mafia.controller.commands.clan.FamilyGetBulletinBoardCommand;
   import com.goodgamestudios.mafia.controller.commands.clan.GetAvailableFamilyCrestPartsCommand;
   import com.goodgamestudios.mafia.controller.commands.clan.ParticipateClanWarCommand;
   import com.goodgamestudios.mafia.controller.commands.clan.UpdateClanBonusCommand;
   import com.goodgamestudios.mafia.controller.commands.ranking.SearchRankingCommand;
   import com.goodgamestudios.mafia.event.model.MafiaClanEvent;
   import com.goodgamestudios.mafia.event.model.MafiaEvent;
   import com.goodgamestudios.mafia.helper.MafiaGroupForumsHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.MafiaClanData;
   import com.goodgamestudios.mafia.model.components.user.ranking.MafiaFamilyRankingData;
   import com.goodgamestudios.mafia.model.components.user.ranking.MafiaPlayerRankingData;
   import com.goodgamestudios.mafia.view.MafiaToolTipManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaClanPinboardEditDialog;
   import com.goodgamestudios.mafia.view.helper.OnlineClanMembersHelper;
   import com.goodgamestudios.mafia.view.helper.StatusChatHelper;
   import com.goodgamestudios.mafia.view.helper.TableChatHelper;
   import com.goodgamestudios.mafia.view.tooltips.MafiaClanBoosterAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaUserClanMemberAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaClanBoosterAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaUserClanMemberAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.clan.ClanChatVO;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   
   public class MafiaUserClanScreen extends MafiaClanScreen
   {
      
      public static const NAME:String = "MafiaUserClanScreen";
       
      
      private var chatHelper:TableChatHelper;
      
      private var statusHelper:StatusChatHelper;
      
      private var onlineMemberHelper:OnlineClanMembersHelper;
      
      private var _currentBankInfo:int = 0;
      
      public function MafiaUserClanScreen(param1:DisplayObject)
      {
         var _loc3_:ClanBankLine = null;
         super(param1);
         controller.addEventListener(MafiaClanEvent.CHANGE_USERCLAN,this.onClanData);
         controller.addEventListener(MafiaClanEvent.CHANGE_CLANMEMBER,this.onClanMemberChange);
         controller.addEventListener(MafiaClanEvent.CHANGE_FAMILY_MESSAGE,this.onFamilyMessage);
         controller.addEventListener(MafiaClanEvent.CHANGE_FAMILY_ACCOUNT,this.onFamilyAccount);
         controller.addEventListener(MafiaClanEvent.CHANGE_FAMILY_NOTIFICATION,this.onFamilyNotification);
         clan.basicInfo.btn_forum.visible = env.useexternallinks || env.networkNewsByJS;
         clan.basicInfo.btn_forum.visible = !GoodgamePartners.isSpilNetwork(env.networkId);
         clan.basicInfo.btn_forum.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_familyForumPost");
         clan.basicInfo.btn_details.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_details");
         clan.bonusInfo.txt_bonus.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_2");
         clan.bonusInfo.btn_bonus.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_2");
         clan.donate.txt_troopBank.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_3");
         clan.donate.btn_bank.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_3");
         clan.donate.txt_donate.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_11");
         clan.donate.btn_donate.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_donate");
         clan.basicInfo.txt_familyCashBonusTitle.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_16");
         clan.basicInfo.txt_familyXPBonusTitle.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_17");
         clan.basicInfo.bonus.visible = true;
         clan.basicInfo.btn_editCrest.visible = true;
         clan.basicInfo.btn_editCrest.enableButton = false;
         clan.basicInfo.btn_editCrest.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_editFamilyCrest",[]);
         this.fillBonusBarColor(clan.basicInfo.bonus.cashBonusBar,0);
         this.fillBonusBarColor(clan.basicInfo.bonus.xpBonusBar,0);
         clan.troupchat.txt_clanchat.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_18");
         clan.troupchat.btn_chat.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_18");
         clan.troupchat.txt_online.text = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_online");
         clan.pinboard.btn_pinboard.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_19");
         this.chatHelper = new TableChatHelper(clan.troupchat);
         this.chatHelper.init();
         clan.troupchat.filters = [];
         this.statusHelper = new StatusChatHelper(clan.statuschat);
         this.statusHelper.init();
         this.statusHelper.hide();
         clan.statuschat.filters = [];
         this.onlineMemberHelper = new OnlineClanMembersHelper(clan.troupchat.mc_onlinemember);
         this.onlineMemberHelper.init();
         clan.troopWarInfo.bg_war.gotoAndStop(1);
         clan.troopWarInfo.btn_war.y = 12;
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = clan.donate["line" + _loc2_] as ClanBankLine;
            _loc3_.visible = false;
            _loc2_++;
         }
         this.fillChat(MafiaModel.userData.userClan.chatMessages,MafiaModel.userData.userClan.statusMessages,MafiaModel.userData.userClan.bankMessages);
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaClanEvent.CHANGE_ATTACKCLANWARTIME,this.onChangeAttackClanWar);
         controller.addEventListener(MafiaClanEvent.CHANGE_DEFENDCLANWARTIME,this.onChangeDefendClanWar);
         controller.addEventListener(MafiaClanEvent.CHANGE_TEMPBOOSTERXPTIME,this.onChangeXPBooster);
         controller.addEventListener(MafiaClanEvent.CHANGE_TEMPBOOSTERC1TIME,this.onChangeC1Booster);
         controller.addEventListener(MafiaClanEvent.CHANGE_PINBOARDDATA,this.onChangePinboardData);
         this.fillChat(MafiaModel.userData.userClan.chatMessages,MafiaModel.userData.userClan.statusMessages,MafiaModel.userData.userClan.bankMessages);
         clan.donate.txt_donateInput.restrict = "0-9";
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(MafiaClanEvent.CHANGE_USERCLAN,this.onClanData);
         controller.removeEventListener(MafiaClanEvent.CHANGE_CLANMEMBER,this.onClanMemberChange);
         controller.removeEventListener(MafiaClanEvent.CHANGE_FAMILY_MESSAGE,this.onFamilyMessage);
         controller.removeEventListener(MafiaClanEvent.CHANGE_FAMILY_ACCOUNT,this.onFamilyAccount);
         controller.removeEventListener(MafiaClanEvent.CHANGE_FAMILY_NOTIFICATION,this.onFamilyNotification);
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaClanEvent.CHANGE_ATTACKCLANWARTIME,this.onChangeAttackClanWar);
         controller.removeEventListener(MafiaClanEvent.CHANGE_DEFENDCLANWARTIME,this.onChangeDefendClanWar);
         controller.removeEventListener(MafiaClanEvent.CHANGE_TEMPBOOSTERXPTIME,this.onChangeXPBooster);
         controller.removeEventListener(MafiaClanEvent.CHANGE_TEMPBOOSTERC1TIME,this.onChangeC1Booster);
         controller.removeEventListener(MafiaClanEvent.CHANGE_PINBOARDDATA,this.onChangePinboardData);
         super.removeEvents();
      }
      
      override protected function onClanData(param1:MafiaEvent) : void
      {
         this.fillClan(MafiaModel.userData.userClan);
         this.onlineMemberHelper.fillOnlineList(MafiaModel.userData.userClan);
      }
      
      override protected function fillClan(param1:MafiaClanData) : void
      {
         clan.troopWarInfo.txt_defendTime.text = "";
         clan.troopWarInfo.txt_attackTime.text = "";
         super.fillClan(param1);
         if(param1.user.rankInClan == FamilyRank.Leader)
         {
            clan.basicInfo.btn_editCrest.enableButton = true;
            clan.basicInfo.btn_editCrest.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_editFamilyCrest",[]);
         }
         else
         {
            clan.basicInfo.btn_editCrest.enableButton = false;
            clan.basicInfo.btn_editCrest.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_23",[]);
         }
         clan.basicInfo.txt_userCashBonus.text = param1.cashBoosterAmountForPlayer.toString() + "%";
         clan.basicInfo.txt_userXPBonus.text = param1.xpBoosterAmountForPlayer.toString() + "%";
         clan.donate.txt_donateInput.text = "";
         clan.donate.txt_troopC2.text = NumberStringHelper.groupString(param1.currency2,MafiaModel.languageData.getTextById);
         var _loc2_:* = MafiaModel.userData.profileData.rankInClan.index <= FamilyRank.Assistant.index;
         clan.basicInfo.bonus.pushBigBonusCash.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_18") + "\n" + MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_20")),new Point(clan.basicInfo.bonus.pushBigBonusCash.x + clan.basicInfo.x + 100,clan.basicInfo.bonus.pushBigBonusCash.y - 12 + clan.basicInfo.y - 50),"",BasicCustomCursor.CURSOR_ARROW);
         clan.basicInfo.bonus.btn_pushSmallBonusCash.enableButton = _loc2_ && param1.cashBoosterQuality == FamilyBoosterQuality.None;
         clan.basicInfo.bonus.btn_pushSmallBonusCash.properties = new Array(1,FamilyBoosterQuality.Low);
         clan.basicInfo.bonus.btn_pushSmallBonusCash.toolTipVO = new TooltipVO(MafiaClanBoosterAdvancedTooltip.NAME,new MafiaClanBoosterAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_cash10"),param1.boosterLowQualityGoldCost),new Point(clan.basicInfo.bonus.btn_pushSmallBonusCash.x + clan.basicInfo.x + 100,clan.basicInfo.bonus.btn_pushSmallBonusCash.y - 12 + clan.basicInfo.y - 100),"",BasicCustomCursor.CURSOR_CLICK);
         clan.basicInfo.bonus.btn_pushBigBonusCash.enableButton = _loc2_ && param1.cashBoosterQuality != FamilyBoosterQuality.High;
         clan.basicInfo.bonus.btn_pushBigBonusCash.properties = new Array(1,FamilyBoosterQuality.High);
         clan.basicInfo.bonus.btn_pushBigBonusCash.toolTipVO = new TooltipVO(MafiaClanBoosterAdvancedTooltip.NAME,new MafiaClanBoosterAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_cash25"),param1.boosterHighQualityGoldCost),new Point(clan.basicInfo.bonus.btn_pushBigBonusCash.x + clan.basicInfo.x + 100,clan.basicInfo.bonus.btn_pushBigBonusCash.y - 12 + clan.basicInfo.y - 100),"",BasicCustomCursor.CURSOR_CLICK);
         clan.basicInfo.bonus.pushBigBonusXP.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_19") + "\n" + MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_20")),new Point(clan.basicInfo.bonus.pushBigBonusXP.x + clan.basicInfo.x + 100,clan.basicInfo.bonus.pushBigBonusXP.y - 12 + clan.basicInfo.y - 50),"",BasicCustomCursor.CURSOR_ARROW);
         clan.basicInfo.bonus.btn_pushSmallBonusXP.enableButton = _loc2_ && param1.xpBoosterQuality == FamilyBoosterQuality.None;
         clan.basicInfo.bonus.btn_pushSmallBonusXP.properties = new Array(2,FamilyBoosterQuality.Low);
         clan.basicInfo.bonus.btn_pushSmallBonusXP.toolTipVO = new TooltipVO(MafiaClanBoosterAdvancedTooltip.NAME,new MafiaClanBoosterAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_xp10"),param1.boosterLowQualityGoldCost),new Point(clan.basicInfo.bonus.btn_pushSmallBonusXP.x + clan.basicInfo.x + 100,clan.basicInfo.bonus.btn_pushSmallBonusXP.y - 12 + clan.basicInfo.y - 100),"",BasicCustomCursor.CURSOR_CLICK);
         clan.basicInfo.bonus.btn_pushBigBonusXP.enableButton = _loc2_ && param1.xpBoosterQuality != FamilyBoosterQuality.High;
         clan.basicInfo.bonus.btn_pushBigBonusXP.properties = new Array(2,FamilyBoosterQuality.High);
         clan.basicInfo.bonus.btn_pushBigBonusXP.toolTipVO = new TooltipVO(MafiaClanBoosterAdvancedTooltip.NAME,new MafiaClanBoosterAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_xp25"),param1.boosterHighQualityGoldCost),new Point(clan.basicInfo.bonus.btn_pushBigBonusXP.x + clan.basicInfo.x + 100,clan.basicInfo.bonus.btn_pushBigBonusXP.y - 12 + clan.basicInfo.y - 100),"",BasicCustomCursor.CURSOR_CLICK);
         clan.statuschat.btn_status.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_news");
         clan.troupchat.btn_chat.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_chat");
         clan.troopWarInfo.txt_defendTime.text = "";
         if(param1.defendingAgainstClanID > 0)
         {
            clan.troopWarInfo.btn_defend.enableButton = true;
            if(!param1.user.defendParticipation)
            {
               clan.troopWarInfo.btn_defend.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_joindefence",[TimeStringHelper.getDateToString(new Date().getTime() + (param1.timeUntilDefending - getTimer()),TimeStringHelper.DATE_TIMEOCLOCK_FORMAT_ADVANCED,MafiaModel.languageData.getTextById)]);
            }
            else
            {
               clan.troopWarInfo.btn_defend.enableButton = false;
               clan.troopWarInfo.btn_defend.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_joindefence_1");
            }
         }
         else
         {
            clan.troopWarInfo.btn_defend.enableButton = false;
            clan.troopWarInfo.btn_defend.toolTipText = null;
         }
         clan.troopWarInfo.txt_attackTime.text = "";
         if(param1.attackingAnotherClanID > 0)
         {
            clan.troopWarInfo.btn_attack.enableButton = true;
            if(!param1.user.attackParticipation)
            {
               clan.troopWarInfo.btn_attack.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_joinattack",[TimeStringHelper.getDateToString(new Date().getTime() + (param1.defendClanWarTimeInSecond - getTimer()),TimeStringHelper.DATE_TIMEOCLOCK_FORMAT_ADVANCED,MafiaModel.languageData.getTextById)]);
            }
            else
            {
               clan.troopWarInfo.btn_attack.enableButton = false;
               clan.troopWarInfo.btn_attack.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_joinattack_1");
            }
         }
         else if(param1.user.rankInClan.index <= FamilyRank.Officer.index)
         {
            clan.troopWarInfo.btn_attack.enableButton = true;
            clan.troopWarInfo.btn_attack.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_lookingForEnemy");
         }
         else
         {
            clan.troopWarInfo.btn_attack.enableButton = false;
            clan.troopWarInfo.btn_attack.toolTipText = null;
         }
         this.fillClanMembers(param1);
      }
      
      override protected function fillClanMembers(param1:MafiaClanData) : void
      {
         var _loc2_:ClanMemberLine = null;
         var _loc4_:uint = 0;
         var _loc5_:ClanMemberLine = null;
         super.fillClanMembers(param1);
         entryCount = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < 25)
         {
            _loc2_ = clan.members.list["member" + _loc3_] as ClanMemberLine;
            _loc2_.toolTipVO = null;
            if(param1.members.length - 1 < _loc3_)
            {
               _loc2_.visible = false;
            }
            else
            {
               _loc2_.toolTipVO = new TooltipVO(MafiaUserClanMemberAdvancedTooltip.NAME,new MafiaUserClanMemberAdvancedTooltipProperties(param1.members[_loc3_]),null,MafiaToolTipManager.TOPDISPMOUSEPOS,BasicCustomCursor.CURSOR_CLICK);
               _loc2_.mc_online.visible = true;
               if(param1.members[_loc3_].isOnline)
               {
                  _loc2_.mc_online.gotoAndStop(2);
               }
               else
               {
                  _loc2_.mc_online.gotoAndStop(1);
               }
               entryCount++;
            }
            _loc3_++;
         }
         if(param1.members.length < 25 && MafiaModel.userData.profileData.rankInClan.index <= FamilyRank.Assistant.index)
         {
            _loc4_ = param1.members.length;
            while(_loc4_ < param1.members.length + param1.maxMembers - param1.members.length)
            {
               entryCount++;
               _loc2_ = clan.members.list["member" + _loc4_] as ClanMemberLine;
               _loc2_.visible = true;
               _loc2_.rankingLineBG.gotoAndStop(2);
               _loc2_.rankingLineBG.alpha = 1;
               updateAllTextFields();
               _loc2_.rankingLineBG.btn_invite.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_invite");
               _loc2_.properties = -1;
               _loc2_.mouseChildren = true;
               _loc2_.mc_online.visible = false;
               _loc4_++;
            }
         }
         if(param1.maxMembers < 25 && MafiaModel.userData.profileData.rankInClan.index == FamilyRank.Leader.index)
         {
            entryCount++;
            _loc5_ = clan.members.list["member" + _loc4_] as ClanMemberLine;
            _loc5_.visible = true;
            _loc5_.rankingLineBG.gotoAndStop(3);
            _loc5_.rankingLineBG.alpha = 1;
            _loc5_.rankingLineBG.mc_goldTimer.bg.height = 17.5;
            _loc5_.rankingLineBG.mc_goldTimer.txt_time.text = param1.increaseMaxMemberGoldCosts.toString();
            _loc5_.rankingLineBG.btn_upgrade.toolTiptext = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_memberplusone");
            _loc5_.properties = -2;
            _loc5_.mouseChildren = true;
            _loc5_.mc_online.visible = false;
         }
         if(entryCount > 9 && entryCount <= 18)
         {
            maxEntryScroll = MEMBERLISTMIDDLEPOINT;
         }
         else if(entryCount > 18)
         {
            maxEntryScroll = MEMBERLISTMAXPOINT;
         }
         else
         {
            maxEntryScroll = MEMBERLISTNULLPOINT;
         }
         updateScrollButtons();
      }
      
      private function onChangePinboardData(param1:MafiaClanEvent) : void
      {
         updatePinboard();
      }
      
      private function onClanMemberChange(param1:MafiaClanEvent) : void
      {
         if(param1.params && param1.params[0] == ChangeClanMemberType.kick)
         {
            this.chatHelper.destroy();
            this.statusHelper.destroy();
         }
         this.fillClanMembers(MafiaModel.userData.userClan);
      }
      
      private function onChangeAttackClanWar(param1:MafiaClanEvent) : void
      {
         clan.troopWarInfo.txt_defendTime.text = param1.params[0];
      }
      
      private function onChangeDefendClanWar(param1:MafiaClanEvent) : void
      {
         clan.troopWarInfo.txt_attackTime.text = param1.params[0];
      }
      
      private function onChangeXPBooster(param1:MafiaClanEvent) : void
      {
         this.fillBonusBarColor(clan.basicInfo.bonus.xpBonusBar,param1.params[1]);
         clan.basicInfo.bonus.pushBigBonusXP.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_19") + "\n" + param1.params[0]),new Point(clan.basicInfo.bonus.pushBigBonusXP.x + clan.basicInfo.x + 100,clan.basicInfo.bonus.pushBigBonusXP.y - 12 + clan.basicInfo.y - 50),"",BasicCustomCursor.CURSOR_ARROW);
      }
      
      private function onChangeC1Booster(param1:MafiaClanEvent) : void
      {
         this.fillBonusBarColor(clan.basicInfo.bonus.cashBonusBar,param1.params[1]);
         clan.basicInfo.bonus.pushBigBonusCash.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_18") + "\n" + param1.params[0]),new Point(clan.basicInfo.bonus.pushBigBonusCash.x + clan.basicInfo.x + 100,clan.basicInfo.bonus.pushBigBonusCash.y - 12 + clan.basicInfo.y - 50),"",BasicCustomCursor.CURSOR_ARROW);
      }
      
      private function fillBonusBarColor(param1:MovieClip, param2:Number) : void
      {
         param2 = Math.max(0,Math.min(param2,1));
         param1.scaleX = param2;
         var _loc3_:ColorMatrix = new ColorMatrix();
         if(param2 >= 0.75)
         {
            _loc3_.colorize(ColorUtils.toColor("0x88C015"),1);
         }
         else if(param2 >= 0.5)
         {
            _loc3_.colorize(ColorUtils.toColor("0xD3A40D"),1);
         }
         else if(param2 >= 0.25)
         {
            _loc3_.colorize(ColorUtils.toColor("0xFF781D"),1);
         }
         else
         {
            _loc3_.colorize(ColorUtils.toColor("0xEA5244"),1);
         }
         param1.filters = [_loc3_.filter];
      }
      
      private function onFamilyMessage(param1:MafiaClanEvent) : void
      {
         this.chatHelper.onAddMsg(MafiaModel.userData.userClan.chatMessages);
      }
      
      private function onFamilyAccount(param1:MafiaClanEvent) : void
      {
         this.fillAccountHistory(MafiaModel.userData.userClan.bankMessages,this._currentBankInfo);
      }
      
      private function onFamilyNotification(param1:MafiaClanEvent) : void
      {
         this.statusHelper.onAddMsg(MafiaModel.userData.userClan.statusMessages);
         this.highlightChatTab(MafiaModel.userData.userClan.statusMessages);
      }
      
      private function fillChat(param1:Vector.<ClanChatVO>, param2:Vector.<ClanChatVO>, param3:Vector.<ClanChatVO>) : void
      {
         this.chatHelper.onAddMsg(param1);
         this.statusHelper.onAddMsg(param2);
         this.fillAccountHistory(param3,this._currentBankInfo);
         this.highlightChatTab(param2);
      }
      
      private function highlightChatTab(param1:Vector.<ClanChatVO>) : void
      {
         var _loc2_:int = this.statusHelper.chatkomponent.mc_textholder.numChildren * 0.5;
         if(!this.statusHelper.isInFocus && this.statusHelper.chatkomponent.mc_textholder.numChildren > 0 && param1.length > _loc2_ && _loc2_ != 0)
         {
            this.statusHelper.chatkomponent.newStatus.visible = true;
         }
         else
         {
            this.statusHelper.chatkomponent.newStatus.visible = false;
         }
      }
      
      private function fillAccountHistory(param1:Vector.<ClanChatVO>, param2:int) : void
      {
         var _loc6_:ClanBankLine = null;
         var _loc3_:Vector.<ClanChatVO> = param1.concat();
         _loc3_.reverse();
         var _loc4_:int = param2;
         clan.donate.btn_down.visible = _loc3_.length > 5 && param2 > 0;
         clan.donate.btn_up.visible = _loc3_.length > 5 && _loc3_.length > param2 + 5;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ > _loc3_.length)
         {
            _loc4_ = _loc3_.length;
         }
         var _loc5_:uint = 0;
         while(_loc5_ < 5)
         {
            _loc6_ = clan.donate["line" + _loc5_] as ClanBankLine;
            _loc6_.visible = false;
            if(BasicLanguageFontManager.getInstance().useDefaultFont)
            {
               BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc6_.txt_time);
               BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc6_.txt_copy);
            }
            else
            {
               _loc6_.txt_time.embedFonts = false;
               _loc6_.txt_copy.embedFonts = false;
            }
            if(_loc3_.length > _loc4_)
            {
               _loc6_.txt_time.text = _loc3_[_loc4_].nameText.txt_msg.text;
               _loc6_.txt_copy.text = _loc3_[_loc4_].msgText.txt_msg.text;
               _loc6_.visible = true;
               if(_loc3_[_loc4_].msgText.txt_msg.textColor == MafiaClanData.FONT_COLOR_LOST_WAR)
               {
                  _loc6_.symbol.gotoAndStop(1);
               }
               else
               {
                  _loc6_.symbol.gotoAndStop(2);
               }
               _loc4_++;
            }
            _loc5_++;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         switch(param1.target)
         {
            case clan.basicInfo.btn_editCrest:
               if(param1.target.enabled)
               {
                  GetAvailableFamilyCrestPartsCommand.sendCommand();
               }
               break;
            case clan.basicInfo.bonus.btn_pushBigBonusXP:
            case clan.basicInfo.bonus.btn_pushSmallBonusXP:
            case clan.basicInfo.bonus.btn_pushBigBonusCash:
            case clan.basicInfo.bonus.btn_pushSmallBonusCash:
               if((param1.target as MovieClip).enabled && (param1.target as MovieClip).properties != null)
               {
                  _loc4_ = (param1.target as MovieClip).properties;
                  if(_loc4_[0] == 1)
                  {
                     UpdateClanBonusCommand.sendCommand(_loc4_[1] as FamilyBoosterQuality,FamilyBoosterQuality.None);
                  }
                  else if(_loc4_[0] == 2)
                  {
                     UpdateClanBonusCommand.sendCommand(FamilyBoosterQuality.None,_loc4_[1] as FamilyBoosterQuality);
                  }
               }
               break;
            case clan.members.btn_members:
               setupMainInfoLayers(1);
               break;
            case clan.donate.btn_bank:
               setupMainInfoLayers(2);
               break;
            case clan.pinboard.btn_pinboard:
               setupMainInfoLayers(5);
               FamilyGetBulletinBoardCommand.sendCommand();
               break;
            case clan.pinboard.btn_edit:
               if((param1.target as MovieClip).enabled)
               {
                  layoutManager.showDialog(MafiaClanPinboardEditDialog.NAME);
               }
               break;
            case clan.donate.btn_donate:
               this.onSendDonation();
               break;
            case clan.donate.btn_down:
               if(this._currentBankInfo >= 0)
               {
                  this._currentBankInfo--;
               }
               this.fillAccountHistory(MafiaModel.userData.userClan.bankMessages,this._currentBankInfo);
               break;
            case clan.donate.btn_up:
               if(this._currentBankInfo + 5 < MafiaModel.userData.userClan.bankMessages.length)
               {
                  this._currentBankInfo++;
               }
               this.fillAccountHistory(MafiaModel.userData.userClan.bankMessages,this._currentBankInfo);
               break;
            case clan.troopWarInfo.btn_attack:
               if(!(param1.target as MovieClip).enabled)
               {
                  break;
               }
               if(MafiaModel.userData.userClan.attackingAnotherClanID <= 0 && MafiaModel.userData.userClan.user.rankInClan.index <= 3)
               {
                  SearchRankingCommand.sendCommand(RankingListType.FamilyDynamic,"1",MafiaFamilyRankingData.TOP_RANKING_LENGTH);
                  SearchRankingCommand.sendCommand(RankingListType.FamilyDynamic,MafiaModel.userData.userClan.clanName,MafiaFamilyRankingData.RANKING_LIST_LENGTH);
                  layoutManager.state = Constants_LayoutStates.STATE_CLANRANKING;
               }
               else
               {
                  ParticipateClanWarCommand.sendCommand(true);
               }
               break;
            case clan.troopWarInfo.btn_defend:
               if((param1.target as MovieClip).enabled)
               {
                  ParticipateClanWarCommand.sendCommand(false);
               }
               break;
            case clan.statuschat.btn_chat:
            case clan.troupchat.btn_chat:
               if(!(param1.target as MovieClip).enabled)
               {
                  return;
               }
               setupMainInfoLayers(4);
               if(MafiaModel.userData.userClan.chatMessages)
               {
                  this.chatHelper.onAddMsg(MafiaModel.userData.userClan.chatMessages);
               }
               break;
            case clan.troupchat.btn_status:
            case clan.statuschat.btn_status:
               if(!(param1.target as MovieClip).enabled)
               {
                  return;
               }
               this.statusHelper.show();
               clan.troopWarInfo.bg_war.gotoAndStop(2);
               clan.troopWarInfo.btn_war.y = 16.5;
               clan.setChildIndex(clan.statuschat,clan.numChildren - 1);
               clan.statuschat.filters = [layerFilter];
               clan.troopWarInfo.filters = [];
               clan.troupchat.filters = [];
               break;
            case clan.troopWarInfo.btn_war:
               if(!(param1.target as MovieClip).enabled)
               {
                  return;
               }
               this.statusHelper.hide();
               clan.troopWarInfo.bg_war.gotoAndStop(1);
               clan.troopWarInfo.btn_war.y = 12;
               clan.setChildIndex(clan.troopWarInfo,clan.numChildren - 1);
               clan.troopWarInfo.filters = [layerFilter];
               clan.statuschat.filters = [];
               clan.troupchat.filters = [];
               break;
            case clan.basicInfo.btn_details:
            case clan.bonusInfo.btn_bonus:
               _loc3_ = [MafiaModel.userData.userClan.playerActivityPointsCollectedYesterday.toString(),MafiaModel.userData.userClan.playerActivityPointsCollectedToday.toString()];
               _loc2_ = MafiaModel.languageData.getTextById("MafiaFamilyScreen_details",_loc3_);
               TextFieldHelper.changeTextFromatSizeByTextWidth(12,clan.bonusInfo.txt_copy,_loc2_,14);
               setupMainInfoLayers(3);
               break;
            case clan.basicInfo.btn_forum:
               MafiaGroupForumsHelper.goIntroduceClan();
         }
         if(param1.target is Btn_InviteToClan)
         {
            SearchRankingCommand.sendCommand(RankingListType.PlayerDynamic,"1",MafiaPlayerRankingData.TOP_RANKING_LENGTH);
            SearchRankingCommand.sendCommand(RankingListType.PlayerDynamic,MafiaModel.userData.profileData.name,MafiaPlayerRankingData.RANKING_LIST_LENGTH);
         }
         if(param1.target is Btn_UpgradeClan)
         {
            UpdateClanBonusCommand.sendCommand(FamilyBoosterQuality.None,FamilyBoosterQuality.None,true);
         }
         super.onClick(param1);
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.target == clan.donate.txt_donateInput && param1.keyCode == Keyboard.ENTER)
         {
            this.onSendDonation();
         }
      }
      
      private function onSendDonation() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:uint = uint(clan.donate.txt_donateInput.text);
         if(_loc1_ > 0)
         {
            DonateFamilyCommand.sendCommand(_loc1_);
            clan.donate.txt_donateInput.text = "";
         }
         else
         {
            _loc2_ = MafiaModel.languageData.getTextById("generic_alert_watchout");
            _loc3_ = MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_23");
            layoutManager.showDialog(CommonDialogNames.StandardOkDialog_NAME,new BasicStandardOkDialogProperties(_loc2_,_loc3_));
         }
      }
      
      override protected function get crestVO() : FamilyCrestVO
      {
         return MafiaModel.userData.userClan.familyCrest;
      }
   }
}
