package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_UnlockLevel;
   import com.goodgamestudios.mafia.constants.enums.FamilyRank;
   import com.goodgamestudios.mafia.controller.commands.clan.InvitePlayerToFamilyCommand;
   import com.goodgamestudios.mafia.controller.commands.clan.ShowClanCommand;
   import com.goodgamestudios.mafia.controller.commands.duel.PrepareDuelFightCommand;
   import com.goodgamestudios.mafia.controller.commands.messages.ShowNewsCommand;
   import com.goodgamestudios.mafia.event.model.MafiaDuelEvent;
   import com.goodgamestudios.mafia.event.model.MafiaPoliceEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.MafiaProfileData;
   import com.goodgamestudios.mafia.view.tooltips.MafiaArrowMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaPushAttributAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.gskinner.motion.GTween;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MafiaOtherProfileScreen extends MafiaProfileScreen
   {
      
      public static const NAME:String = "MafiaOtherProfileScreen";
       
      
      private const DEFENCE_TOOLTIP_OFFSET:int = 50;
      
      public function MafiaOtherProfileScreen(param1:DisplayObject)
      {
         super(param1);
         this.mafiaProfile.btn_mail.toolTipText = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_14");
      }
      
      override public function show() : void
      {
         super.show();
         mafiaBasicProfile.profileValues_compare.visible = false;
         mafiaBasicProfile.profileValues_compare.alpha = 0;
         mafiaBasicProfile.profileStats_compare.visible = true;
         mafiaBasicProfile.profileStats_compare.alpha = 1;
         this.mafiaProfile.btn_attack.enableButton = false;
         this.mafiaProfile.btn_mail.enableButton = false;
         this.mafiaProfile.btn_toFamily.enableButton = false;
         this.mafiaProfile.btn_ignore.enableButton = false;
         this.mafiaProfile.btn_invite.visible = false;
         this.mafiaProfile.btn_toFamily.visible = false;
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_DATA,this.onChangeOtherUserData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA,this.onChangeOtherAvatarData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onChangeUserAvatarData);
         controller.addEventListener(MafiaDuelEvent.CHANGE_DUEL_TIMER,this.onDuelTimer);
         controller.addEventListener(MafiaDuelEvent.CHANGE_DUEL_DATA,this.onDuelData);
         controller.addEventListener(MafiaDuelEvent.CHANGE_DUEL_RESULT,this.onChangeDuelResult);
         controller.addEventListener(MafiaDuelEvent.REMOVE_DUELTIMER,this.onRemoveDuelTimer);
         controller.addEventListener(MafiaDuelEvent.DUEL_REJECTED,this.onDuelRejected);
         controller.addEventListener(MafiaPoliceEvent.POLICE_RETREAT,this.onPoliceRetreat);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_ATTRIBUTE_COSTS_DATA,this.onChangeUserAttributeCostsData);
         if(!MafiaModel.userData.profileData.isDuelUnlocked)
         {
            this.mafiaProfile.btn_attack.toolTipText = MafiaModel.languageData.getTextById("MafiaDuelScreen_title") + " " + MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[Constants_UnlockLevel.UNLOCK_DUEL]);
         }
         else
         {
            this.mafiaProfile.btn_attack.toolTipText = MafiaModel.languageData.getTextById("MafiaDuelScreen_btn_attack");
         }
         this.mafiaProfile.btn_attack.goldInfoVisible = false;
         this.mafiaProfile.txt_comparison.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_compareAttributes");
         this.fillComparisonStats(MafiaModel.userData.profileData);
      }
      
      override public function hide() : void
      {
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_DATA,this.onChangeOtherUserData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA,this.onChangeOtherAvatarData);
         controller.removeEventListener(MafiaDuelEvent.CHANGE_DUEL_RESULT,this.onChangeDuelResult);
         controller.removeEventListener(MafiaDuelEvent.CHANGE_DUEL_TIMER,this.onDuelTimer);
         controller.removeEventListener(MafiaDuelEvent.REMOVE_DUELTIMER,this.onRemoveDuelTimer);
         controller.removeEventListener(MafiaDuelEvent.CHANGE_DUEL_DATA,this.onDuelData);
         controller.removeEventListener(MafiaPoliceEvent.POLICE_RETREAT,this.onPoliceRetreat);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onChangeUserAvatarData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_ATTRIBUTE_COSTS_DATA,this.onChangeUserAttributeCostsData);
         controller.removeEventListener(MafiaDuelEvent.DUEL_REJECTED,this.onDuelRejected);
         super.hide();
      }
      
      private function onChangeUserAttributeCostsData(param1:MafiaUserEvent) : void
      {
         if(layoutManager.tooltipManager.getToolTip(MafiaPushAttributAdvancedTooltip.NAME))
         {
            (layoutManager.tooltipManager.getToolTip(MafiaPushAttributAdvancedTooltip.NAME) as MafiaPushAttributAdvancedTooltip).cost(MafiaModel.userData.attributsCostsData);
         }
         this.fillComparisonStats(MafiaModel.userData.profileData);
      }
      
      private function onChangeUserAvatarData(param1:MafiaUserEvent) : void
      {
         this.fillComparisonStats(MafiaModel.userData.profileData);
      }
      
      protected function onPoliceRetreat(param1:MafiaPoliceEvent) : void
      {
         this.updateButtons();
      }
      
      private function onChangeOtherUserData(param1:MafiaUserEvent) : void
      {
         this.updateButtons();
      }
      
      private function updateButtons() : void
      {
         this.mafiaProfile.btn_attack.enableButton = MafiaModel.userData.profileData.isDuelUnlocked;
         this.mafiaProfile.btn_mail.enableButton = true;
         this.mafiaProfile.btn_toFamily.enableButton = true;
         this.mafiaProfile.btn_ignore.enableButton = true;
         if(MafiaModel.otherUserData.profileData.isInClan)
         {
            this.mafiaProfile.btn_toFamily.visible = true;
            updateAllTextFields();
            this.mafiaProfile.btn_invite.toolTipText = MafiaModel.languageData.getTextById("MafiaAvatarScreen_btn_family");
            this.mafiaProfile.btn_invite.properties = MafiaModel.otherUserData.profileData.clanID;
         }
         else if(!MafiaModel.otherUserData.profileData.isInClan)
         {
            this.mafiaProfile.btn_toFamily.visible = false;
            this.mafiaProfile.btn_invite.visible = MafiaModel.userData.profileData.clanID > 0 && MafiaModel.userData.profileData.rankInClan.index <= FamilyRank.Assistant.index && MafiaModel.userData.profileData.clanID != Constants_Basic.LOOKING_FOR_CLAN_ID;
            updateAllTextFields();
            this.mafiaProfile.btn_invite.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_invite");
            this.mafiaProfile.btn_invite.properties = 0;
         }
         super.fillUserData(MafiaModel.otherUserData);
         this.checkIgnoration();
      }
      
      private function checkIgnoration() : void
      {
         if(MafiaModel.otherUserData.profileData.isIgnored)
         {
            this.mafiaProfile.btn_ignore.toolTipText = MafiaModel.languageData.getTextById("MafiaAvatarScreen_btn_unignore");
            if(this.mafiaProfile.btn_ignore.icon)
            {
               this.mafiaProfile.btn_ignore.icon.gotoAndStop(2);
            }
         }
         else
         {
            this.mafiaProfile.btn_ignore.toolTipText = MafiaModel.languageData.getTextById("MafiaAvatarScreen_btn_ignore");
            if(this.mafiaProfile.btn_ignore.icon)
            {
               this.mafiaProfile.btn_ignore.icon.gotoAndStop(1);
            }
         }
      }
      
      private function onChangeOtherAvatarData(param1:MafiaUserEvent) : void
      {
         super.fillAvatarStats(MafiaModel.otherUserData.profileData);
         this.fillAvatarAssets(MafiaModel.otherUserData.profileData);
         MafiaModel.userData.duelData.pvpData.lastDuelEnemy = MafiaModel.otherUserData.profileData.name;
      }
      
      protected function fillAvatarAssets(param1:MafiaProfileData) : void
      {
         var _loc2_:Sprite = null;
         if(param1.picString.length == 2)
         {
            _loc2_ = AvatarHelper.createOldAvatar(param1.picString);
         }
         else
         {
            _loc2_ = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(param1.picString),0.2);
         }
         _loc2_.mouseEnabled = false;
         _loc2_.mouseChildren = false;
         var _loc3_:Sprite = AvatarHelper.createClassSymbol(param1.characterClass,0.7);
         MovieClipHelper.clearMovieClip(this.mafiaProfile.avatarPicField1.holder);
         this.mafiaProfile.avatarPicField1.holder.addChild(_loc2_);
         this.mafiaProfile.avatarPicField1.mouseChildren = false;
         MovieClipHelper.clearMovieClip(this.mafiaProfile.level_Box.mc_class);
         this.mafiaProfile.level_Box.mc_class.addChild(_loc3_);
      }
      
      private function fillComparisonStats(param1:MafiaProfileData) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = NumberStringHelper.groupString(param1.defense,MafiaModel.languageData.getTextById);
         var _loc4_:String = "";
         var _loc5_:String = "";
         var _loc6_:String = "";
         var _loc7_:String = "";
         var _loc8_:String = "";
         var _loc9_:String = "";
         var _loc10_:String = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_classicon" + param1.characterClass.index);
         mafiaBasicProfile.profileStats_compare.txt_attack.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack");
         mafiaBasicProfile.profileStats_compare.txt_resistance.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough");
         mafiaBasicProfile.profileStats_compare.txt_endurance.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance");
         mafiaBasicProfile.profileStats_compare.txt_luck.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck");
         _loc2_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_defence",[_loc10_,_loc3_]);
         _loc4_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg");
         _loc6_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_attack",[NumberStringHelper.groupString(param1.attack,MafiaModel.languageData.getTextById),NumberStringHelper.groupString(param1.damage,MafiaModel.languageData.getTextById)]);
         _loc5_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_resistance");
         _loc7_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_tough",[NumberStringHelper.groupString(param1.toughness,MafiaModel.languageData.getTextById),MafiaProfileData.maxChanceResistance,param1.resistance]);
         _loc8_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_endurance",[NumberStringHelper.groupString(param1.endurance,MafiaModel.languageData.getTextById),NumberStringHelper.groupString(param1.health,MafiaModel.languageData.getTextById)]);
         _loc9_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_luck",[NumberStringHelper.groupString(param1.luck,MafiaModel.languageData.getTextById),param1.criticalHitChance,MafiaProfileData.maxChanceLuck]);
         this.mafiaProfile.profileValues_compare.txt_attack.text = _loc4_;
         this.mafiaProfile.profileValues_compare.txt_resistance.text = _loc5_;
         this.mafiaProfile.profileValues_compare.txt_endurance.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_health");
         this.mafiaProfile.profileValues_compare.txt_luck.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_crit");
         this.mafiaProfile.profileValues_compare.attackMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc6_),new Point(mafiaBasicProfile.profileValues.attackMath_hoover.x,mafiaBasicProfile.profileValues.attackMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaProfile.profileValues_compare.resistanceMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc7_),new Point(mafiaBasicProfile.profileValues.resistanceMath_hoover.x,mafiaBasicProfile.profileValues.resistanceMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaProfile.profileValues_compare.enduranceMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc8_),new Point(mafiaBasicProfile.profileValues.enduranceMath_hoover.x,mafiaBasicProfile.profileValues.enduranceMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaProfile.profileValues_compare.luckMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc9_),new Point(mafiaBasicProfile.profileValues.luckMath_hoover.x,mafiaBasicProfile.profileValues.luckMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaProfile.profileStats_compare.txt_attack_math.text = NumberStringHelper.groupString(param1.attack,MafiaModel.languageData.getTextById);
         this.mafiaProfile.profileStats_compare.txt_endurance_math.text = NumberStringHelper.groupString(param1.endurance,MafiaModel.languageData.getTextById);
         this.mafiaProfile.profileStats_compare.txt_luck_math.text = NumberStringHelper.groupString(param1.luck,MafiaModel.languageData.getTextById);
         this.mafiaProfile.profileStats_compare.txt_resistance_math.text = NumberStringHelper.groupString(param1.toughness,MafiaModel.languageData.getTextById);
         this.mafiaProfile.profileValues_compare.txt_attack_math.text = NumberStringHelper.groupString(Number(param1.damage),MafiaModel.languageData.getTextById);
         this.mafiaProfile.profileValues_compare.txt_endurance_math.text = NumberStringHelper.groupString(param1.health,MafiaModel.languageData.getTextById);
         this.mafiaProfile.profileValues_compare.txt_luck_math.text = NumberStringHelper.groupString(param1.criticalHitChance,MafiaModel.languageData.getTextById) + "%";
         this.mafiaProfile.profileValues_compare.txt_resistance_math.text = NumberStringHelper.groupString(Number(param1.resistance),MafiaModel.languageData.getTextById) + "%";
         this.mafiaProfile.defense_compare.mouseChildren = false;
         this.mafiaProfile.defense_compare.txt_title.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_defense");
         this.mafiaProfile.defense_compare.txt_value.text = String(param1.defense);
         this.mafiaProfile.defense_compare.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc2_),new Point(mafiaBasicProfile.defense_compare.x,(mafiaBasicProfile.defense_compare.localToGlobal(new Point()).y - this.DEFENCE_TOOLTIP_OFFSET) / layoutManager.scaleFactor));
         this.fillComparisonStatResults(param1);
      }
      
      protected function fillComparisonStatResults(param1:MafiaProfileData) : void
      {
         var _loc2_:String = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_attack",[NumberStringHelper.groupString(param1.attack,MafiaModel.languageData.getTextById),NumberStringHelper.groupString(param1.damage,MafiaModel.languageData.getTextById)]);
         var _loc3_:String = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_tough",[NumberStringHelper.groupString(param1.toughness,MafiaModel.languageData.getTextById),MafiaProfileData.maxChanceResistance,param1.resistance]);
         var _loc4_:String = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_endurance",[NumberStringHelper.groupString(param1.endurance,MafiaModel.languageData.getTextById),NumberStringHelper.groupString(param1.health,MafiaModel.languageData.getTextById)]);
         var _loc5_:String = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_luck",[NumberStringHelper.groupString(param1.luck,MafiaModel.languageData.getTextById),param1.criticalHitChance,MafiaProfileData.maxChanceLuck]);
         this.mafiaProfile.profileValues_compare.attackMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc2_),new Point(mafiaBasicProfile.profileValues_compare.attackMath_hoover.x,mafiaBasicProfile.profileValues_compare.attackMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaProfile.profileValues_compare.resistanceMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc3_),new Point(mafiaBasicProfile.profileValues_compare.resistanceMath_hoover.x,mafiaBasicProfile.profileValues_compare.resistanceMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaProfile.profileValues_compare.enduranceMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc4_),new Point(mafiaBasicProfile.profileValues_compare.enduranceMath_hoover.x,mafiaBasicProfile.profileValues_compare.enduranceMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaProfile.profileValues_compare.luckMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc5_),new Point(mafiaBasicProfile.profileValues_compare.luckMath_hoover.x,mafiaBasicProfile.profileValues_compare.luckMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is MovieClip && !param1.target.enabled)
         {
            return;
         }
         var _loc2_:Array = new Array();
         super.onClick(param1);
         switch(param1.target)
         {
            case this.mafiaProfile.btn_toFamily:
               if(MafiaModel.otherUserData.profileData.clanID > 0 && MafiaModel.otherUserData.profileData.clanID < Constants_Basic.LOOKING_FOR_CLAN_ID)
               {
                  if(MafiaModel.otherUserData.profileData.clanID == MafiaModel.userData.profileData.clanID)
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
                  }
                  else
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_OTHERCLAN;
                  }
                  ShowClanCommand.sendCommand(MafiaModel.otherUserData.profileData.clanID);
               }
               break;
            case this.mafiaProfile.btn_ignore:
               _loc2_ = [MafiaModel.otherUserData.playerID];
               if(MafiaModel.otherUserData.profileData.isIgnored)
               {
                  MafiaModel.otherUserData.profileData.isIgnored = false;
                  _loc2_.push(0);
               }
               else
               {
                  MafiaModel.otherUserData.profileData.isIgnored = true;
                  _loc2_.push(1);
               }
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_IGNORE_PLAYER,_loc2_);
               this.checkIgnoration();
               break;
            case this.mafiaProfile.btn_mail:
               if(MafiaModel.userData.messageData.normalMessages.length == 0)
               {
                  ShowNewsCommand.sendCommand();
               }
               MafiaModel.userData.messageData.readMessagesData.receiver = MafiaModel.otherUserData.profileData.name;
               layoutManager.state = Constants_LayoutStates.STATE_MAILING;
               break;
            case this.mafiaProfile.btn_invite:
               if(this.mafiaProfile.btn_invite.properties == 0)
               {
                  _loc2_.push(MafiaModel.otherUserData.playerID);
                  InvitePlayerToFamilyCommand.sendCommand(MafiaModel.otherUserData.playerID);
                  this.updateButtons();
               }
               else
               {
                  if(this.mafiaProfile.btn_invite.properties == MafiaModel.userData.profileData.clanID)
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
                  }
                  else
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_OTHERCLAN;
                  }
                  ShowClanCommand.sendCommand(this.mafiaProfile.btn_invite.properties);
               }
               break;
            case this.mafiaProfile.btn_attack:
               this.mafiaProfile.btn_attack.enableButton = false;
               PrepareDuelFightCommand.sendCommand(MafiaModel.otherUserData.userName);
         }
      }
      
      override protected function blendToStatValues() : void
      {
         var _loc1_:GTween = null;
         var _loc2_:GTween = null;
         if(mafiaBasicProfile.profileStats.alpha == 1)
         {
            _loc1_ = new GTween(mafiaBasicProfile.profileStats,0.2,{"alpha":0});
            _loc1_.onComplete = this.onProfileStatsTweenComplete;
            _loc2_ = new GTween(mafiaBasicProfile.profileStats_compare,0.2,{"alpha":0});
            mafiaBasicProfile.profileValues.addEventListener(MouseEvent.ROLL_OUT,this.onOutProfileStats);
            mafiaBasicProfile.profileValues_compare.addEventListener(MouseEvent.ROLL_OUT,this.onOutProfileStats);
         }
      }
      
      override protected function onOutProfileStats(param1:MouseEvent) : void
      {
         super.onOutProfileStats(param1);
         mafiaBasicProfile.profileValues_compare.removeEventListener(MouseEvent.ROLL_OUT,this.onOutProfileStats);
         new GTween(mafiaBasicProfile.profileValues_compare,0.2,{"alpha":0});
      }
      
      override protected function onProfileStatsTweenComplete(param1:GTween) : void
      {
         super.onProfileStatsTweenComplete(param1);
         mafiaBasicProfile.profileStats_compare.visible = false;
         mafiaBasicProfile.profileValues_compare.alpha = 0;
         mafiaBasicProfile.profileValues_compare.visible = true;
         new GTween(mafiaBasicProfile.profileValues_compare,0.2,{"alpha":1});
      }
      
      override protected function onProfileValuesTweenComplete(param1:GTween) : void
      {
         super.onProfileValuesTweenComplete(param1);
         mafiaBasicProfile.profileValues_compare.visible = false;
         mafiaBasicProfile.profileStats_compare.alpha = 0;
         mafiaBasicProfile.profileStats_compare.visible = true;
         new GTween(mafiaBasicProfile.profileStats_compare,0.2,{"alpha":1});
      }
      
      private function onChangeDuelResult(param1:MafiaDuelEvent) : void
      {
         layoutManager.state = Constants_LayoutStates.STATE_DUEL_FIGHT;
         this.updateButtons();
      }
      
      private function onDuelTimer(param1:MafiaDuelEvent) : void
      {
         this.mafiaProfile.btn_attack.goldInfoVisible = true;
         this.mafiaProfile.btn_attack.goldInfoTimeText = MafiaModel.languageData.getTextById("tt_MafiaButton_forfree") + " " + param1.params[0];
         this.mafiaProfile.btn_attack.goldInfoGoldText = MafiaModel.goldConstants.cutNextFreeDuelTimePricePerSecond.toString();
      }
      
      private function onRemoveDuelTimer(param1:MafiaDuelEvent) : void
      {
         this.mafiaProfile.btn_attack.goldInfoVisible = false;
      }
      
      private function onDuelData(param1:MafiaDuelEvent) : void
      {
         if(layoutManager.actState == Constants_LayoutStates.STATE_OTHERPROFILE)
         {
            MafiaModel.userData.duelData.pvpData.lastDuelEnemy = MafiaModel.otherUserData.profileData.name;
         }
         this.mafiaProfile.btn_attack.goldInfoVisible = false;
         this.updateButtons();
      }
      
      protected function onDuelRejected(param1:Event) : void
      {
         this.updateButtons();
      }
      
      protected function get mafiaProfile() : MafiaOtherProfile
      {
         return disp as MafiaOtherProfile;
      }
   }
}
