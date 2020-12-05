package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.event.BasicComboboxEvent;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.RankingListType;
   import com.goodgamestudios.mafia.controller.commands.clan.ShowClanCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.controller.commands.ranking.SearchRankingCommand;
   import com.goodgamestudios.mafia.event.model.MafiaRankingEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaOtherUserData;
   import com.goodgamestudios.mafia.model.components.user.MafiaProfileData;
   import com.goodgamestudios.mafia.model.components.user.ranking.MafiaPlayerRankingData;
   import com.goodgamestudios.mafia.view.panels.MafiaActionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaReviewTutorialPanel;
   import com.goodgamestudios.mafia.view.screens.ranking.MafiaRankingComboboxComponent;
   import com.goodgamestudios.mafia.vo.PlayerRankingVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class MafiaPlayerRankingScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaPlayerRankingScreen";
       
      
      private var searchedPlayer:String = "";
      
      private var _listType:RankingListType;
      
      private var selectionBox:MafiaRankingComboboxComponent;
      
      public function MafiaPlayerRankingScreen(param1:DisplayObject)
      {
         super(param1);
         controller.addEventListener(MafiaRankingEvent.CHANGE_PLAYERRANKINGDATA,this.onPlayerRankingData);
         this.mafiaRanking.layer_gotoPlayers.btn_toPlayerRanking.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_btn_playerranking");
         this.mafiaRanking.layer_gotoTroop.gotoAndStop(2);
         this.mafiaRanking.layer_gotoTroop.btn_toTroopRanking.y = -13.25;
         this.mafiaRanking.layer_gotoTroop.btn_toTroopRanking.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_btn_familyranking");
         this.mafiaRanking.txt_rang.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_rank");
         this.mafiaRanking.txt_name.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_name");
         this.mafiaRanking.txt_level.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level");
         this.mafiaRanking.txt_guild.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_family");
         this.mafiaRanking.txt_glory.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_honor");
         this.mafiaRanking.txt_search.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_copy_1");
         this.mafiaRanking.btn_toOwnPlayer.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_btn_myposition");
         this.mafiaRanking.update.txt_label.text = "-" + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_honordecay",[1]);
         if(MafiaModel.userData.profileData.gloryDynamic == 0 && MafiaModel.userData.profileData.level < 5)
         {
            layoutManager.showSpecificPanel(MafiaReviewTutorialPanel.NAME,new BasicStandardOkDialogProperties("",MafiaModel.languageData.getTextById("MafiaHelpTutDialog_ranking")));
         }
         this.selectionBox = new MafiaRankingComboboxComponent(this.mafiaRanking.listSelection);
         var _loc2_:Object = {
            "label":MafiaModel.languageData.getTextById("MafiaRankingScreen_text_Honor_UpToDate"),
            "data":{
               "id":RankingListType.PlayerDynamic,
               "mainName":MafiaModel.languageData.getTextById("MafiaRankingScreen_text_player") + ": "
            }
         };
         this.selectionBox.addItem(_loc2_);
         var _loc3_:Object = {
            "label":MafiaModel.languageData.getTextById("MafiaRankingScreen_text_Honor_HallOfFame"),
            "data":{
               "id":RankingListType.PlayerAlltime,
               "mainName":MafiaModel.languageData.getTextById("MafiaRankingScreen_text_player") + ": "
            }
         };
         this.selectionBox.addItem(_loc3_);
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_RANKING;
      }
      
      private function onPlayerRankingData(param1:MafiaRankingEvent) : void
      {
         this.fillRanking(MafiaModel.userData.playerRankingData.players,MafiaModel.userData.playerRankingData.listType);
      }
      
      override public function show() : void
      {
         super.show();
         if(MafiaModel.userData.playerRankingData.listType == RankingListType.PlayerDynamic)
         {
            this.selectionBox.selectItemIndex(0);
         }
         else if(MafiaModel.userData.playerRankingData.listType == RankingListType.PlayerAlltime)
         {
            this.selectionBox.selectItemIndex(1);
         }
         else
         {
            this.selectionBox.selectItemIndex(0);
         }
         this.selectionBox.disp.addEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onChangeList);
         this.mafiaRanking.btn_ok.toolTipText = MafiaModel.languageData.getTextById("generic_btn_search");
         this.mafiaRanking.rank1.btn_gotoPlayer.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_memberdetail");
         this.mafiaRanking.rank2.btn_gotoPlayer.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_memberdetail");
         this.mafiaRanking.rank3.btn_gotoPlayer.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_memberdetail");
         this.mafiaRanking.update.visible = false;
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA,this.onTopPlayerData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onTopPlayerData);
         controller.addEventListener(MafiaRankingEvent.CHANGE_PLAYER_RANKING_TIME,this.onRankingUpdateTime);
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(MafiaRankingEvent.CHANGE_PLAYERRANKINGDATA,this.onPlayerRankingData);
         super.destroy();
      }
      
      override protected function removeEvents() : void
      {
         this.selectionBox.disp.removeEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onChangeList);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA,this.onTopPlayerData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onTopPlayerData);
         controller.removeEventListener(MafiaRankingEvent.CHANGE_PLAYER_RANKING_TIME,this.onRankingUpdateTime);
         super.removeEvents();
      }
      
      private function fillRanking(param1:Vector.<PlayerRankingVO>, param2:RankingListType) : void
      {
         this._listType = param2;
         if(param1.length != MafiaPlayerRankingData.TOP_RANKING_LENGTH)
         {
            this.fillRankingList(param1);
         }
      }
      
      private function fillRankingList(param1:Vector.<PlayerRankingVO>) : void
      {
         var _loc2_:PlayerRankingVO = null;
         var _loc3_:RankingLine = null;
         var _loc5_:Sprite = null;
         var _loc6_:Boolean = false;
         var _loc4_:uint = 0;
         while(_loc4_ < MafiaPlayerRankingData.RANKING_LIST_LENGTH)
         {
            _loc2_ = param1.length > _loc4_?param1[_loc4_]:null;
            _loc3_ = this.mafiaRanking["rankingLine_" + _loc4_] as RankingLine;
            _loc3_.visible = _loc2_ != null;
            _loc3_.properties = _loc2_;
            if(_loc2_ != null)
            {
               _loc3_.txt_name.text = _loc2_.name;
               _loc3_.txt_name.embedFonts = true;
               if(_loc3_.txt_name.textWidth == 0)
               {
                  _loc3_.txt_name.embedFonts = false;
                  _loc3_.txt_name.text = _loc2_.name;
               }
               _loc3_.txt_glory.text = NumberStringHelper.groupString(_loc2_.glory,MafiaModel.languageData.getTextById);
               _loc3_.txt_rang.text = NumberStringHelper.groupString(_loc2_.rank,MafiaModel.languageData.getTextById);
               _loc3_.txt_level.text = String(_loc2_.level);
               _loc3_.btn_layer_name.alpha = 0.05;
               _loc3_.btn_layer_name.width = _loc3_.txt_name.textWidth + 20;
               _loc3_.btn_layer_name.buttonMode = true;
               _loc3_.txt_guild.embedFonts = true;
               if(_loc2_.clanID == Constants_Basic.LOOKING_FOR_CLAN_ID)
               {
                  _loc3_.txt_guild.textColor = 10027161;
                  _loc3_.txt_guild.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_searching");
               }
               else
               {
                  _loc3_.txt_guild.textColor = 5196099;
                  if(_loc2_.clanID > 0)
                  {
                     _loc3_.txt_guild.text = _loc2_.clanName;
                     if(_loc3_.txt_guild.textWidth == 0)
                     {
                        _loc3_.txt_guild.embedFonts = false;
                        _loc3_.txt_guild.text = _loc2_.clanName;
                     }
                  }
                  else
                  {
                     _loc3_.txt_guild.text = "-";
                  }
               }
               _loc3_.btn_layer_leader.visible = _loc2_.clanID != 0;
               _loc3_.btn_layer_leader.alpha = 0.05;
               _loc3_.btn_layer_leader.width = _loc3_.txt_guild.textWidth + 20;
               _loc3_.btn_layer_leader.buttonMode = true;
               MovieClipHelper.clearMovieClip(_loc3_.mc_class);
               _loc5_ = AvatarHelper.createClassSymbol(_loc2_.characterClass,0.5);
               _loc3_.mc_class.addChildAt(_loc5_,0);
               _loc6_ = false;
               if(_loc2_.name.toLowerCase() == this.searchedPlayer.toLowerCase())
               {
                  _loc6_ = true;
               }
               else if(_loc2_.name.toLowerCase() == MafiaModel.userData.duelData.pvpData.lastDuelEnemy.toLowerCase())
               {
                  _loc6_ = true;
               }
               else if(String(_loc2_.rank) == this.searchedPlayer)
               {
                  _loc6_ = true;
               }
               else if(_loc2_.playerID == MafiaModel.userData.playerID)
               {
                  _loc6_ = true;
               }
               _loc3_.rankingLineBG.gotoAndStop(!!_loc6_?2:1);
               _loc3_.mc_change.visible = false;
            }
            _loc4_++;
         }
         this.searchedPlayer = "";
         this.mafiaRanking.btn_up.enableButton = param1[0].rank > 1;
         this.mafiaRanking.btn_down.enableButton = true;
      }
      
      private function onTopPlayerData(param1:MafiaUserEvent) : void
      {
         var _loc2_:MafiaProfileData = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Sprite = null;
         var _loc7_:Sprite = null;
         _loc2_ = MafiaModel.otherUserData.profileData;
         if(param1.type == MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA)
         {
            _loc2_ = MafiaModel.userData.profileData;
         }
         switch(this._listType)
         {
            case RankingListType.PlayerDynamic:
               _loc3_ = _loc2_.rankInHighScoreDynamic;
               _loc4_ = _loc2_.gloryDynamic;
               break;
            case RankingListType.PlayerAlltime:
               _loc3_ = _loc2_.rankInHighScoreAlltime;
               _loc4_ = _loc2_.gloryAlltime;
         }
         var _loc5_:TopThreePlayerEntry = this.mafiaRanking["rank" + _loc3_] as TopThreePlayerEntry;
         if(_loc5_)
         {
            MovieClipHelper.clearMovieClip(_loc5_.avatarPicField1.holder);
            MovieClipHelper.clearMovieClip(_loc5_.classHolder);
            if(_loc2_.picString.length == 2)
            {
               _loc6_ = AvatarHelper.createOldAvatar(_loc2_.picString);
            }
            else
            {
               _loc6_ = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(_loc2_.picString),0.3,false);
            }
            _loc6_.mouseEnabled = false;
            _loc6_.mouseChildren = false;
            _loc7_ = AvatarHelper.createClassSymbol(_loc2_.characterClass,0.5);
            _loc5_.mouseChildren = true;
            _loc5_.avatarPicField1.holder.addChild(_loc6_);
            _loc5_.classHolder.addChild(_loc7_);
            _loc5_.txt_name.text = _loc2_.name;
            _loc5_.txt_family.text = _loc2_.clanName;
            _loc5_.txt_level.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " " + _loc2_.level.toString();
            _loc5_.bg.gotoAndStop(_loc3_);
            _loc5_.rank.gotoAndStop(_loc3_);
            _loc5_.rank.txt_honor.text = NumberStringHelper.groupString(_loc4_,MafiaModel.languageData.getTextById);
            _loc5_.properties = MafiaModel.otherUserData.profileData.playerID;
         }
      }
      
      private function onChangeList(param1:BasicComboboxEvent) : void
      {
         SearchRankingCommand.sendCommand(this.selectionBox.selectedData.id,"1",MafiaPlayerRankingData.TOP_RANKING_LENGTH);
         SearchRankingCommand.sendCommand(this.selectionBox.selectedData.id,MafiaModel.userData.profileData.name,MafiaPlayerRankingData.RANKING_LIST_LENGTH);
      }
      
      private function onRankingUpdateTime(param1:MafiaRankingEvent) : void
      {
         if(param1.params.length > 0)
         {
            this.mafiaRanking.update.visible = true;
            this.mafiaRanking.update.txt_update.text = param1.params[0];
         }
         else
         {
            this.mafiaRanking.update.visible = false;
         }
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.enterSearch();
         }
      }
      
      private function enterSearch() : void
      {
         if(TextValide.isSmartFoxValide(this.mafiaRanking.txt_search.text))
         {
            this.searchedPlayer = this.mafiaRanking.txt_search.text;
            this.mafiaRanking.txt_search.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_copy_1");
            SearchRankingCommand.sendCommand(this._listType,this.searchedPlayer,MafiaPlayerRankingData.RANKING_LIST_LENGTH);
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:RankingLine = null;
         var _loc4_:int = 0;
         super.onClick(param1);
         if(param1.target is RankingMouseOverNameLayer)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = _loc2_.parent as RankingLine;
            if(_loc3_.properties.playerID != MafiaModel.userData.playerID)
            {
               MafiaModel.otherUserData = new MafiaOtherUserData();
               layoutManager.state = Constants_LayoutStates.STATE_OTHERPROFILE;
            }
            else
            {
               layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
            }
            PlayerProfileCommand.sendCommand(_loc3_.properties.playerID,false);
         }
         if(param1.target is RankingMouseOverClanLayer)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = _loc2_.parent as RankingLine;
            if(_loc3_.properties.clanID == 0)
            {
               return;
            }
            if(_loc3_.properties.playerID != MafiaModel.userData.playerID)
            {
               if(_loc3_.properties.clanID == Constants_Basic.LOOKING_FOR_CLAN_ID)
               {
                  MafiaModel.otherUserData = new MafiaOtherUserData();
                  layoutManager.state = Constants_LayoutStates.STATE_OTHERPROFILE;
                  PlayerProfileCommand.sendCommand(_loc3_.properties.playerID,false);
               }
               else
               {
                  ShowClanCommand.sendCommand(_loc3_.properties.clanID);
                  layoutManager.state = Constants_LayoutStates.STATE_OTHERCLAN;
               }
            }
            else if(_loc3_.properties.clanID == Constants_Basic.LOOKING_FOR_CLAN_ID)
            {
               layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
            }
            else
            {
               ShowClanCommand.sendCommand();
               layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
            }
         }
         switch(param1.target)
         {
            case this.mafiaRanking.btn_ok:
               if(this.mafiaRanking.txt_search.text == "cc#activ")
               {
                  ((layoutManager.getPanel(MafiaActionPanel.NAME) as MafiaActionPanel).disp as ActionPanel).sheepBox.visible = true;
                  this.mafiaRanking.txt_search.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_copy_1");
                  return;
               }
               this.enterSearch();
               break;
            case this.mafiaRanking.rank1.btn_gotoPlayer:
            case this.mafiaRanking.rank2.btn_gotoPlayer:
            case this.mafiaRanking.rank3.btn_gotoPlayer:
               _loc2_ = param1.target as MovieClip;
               _loc4_ = (_loc2_.parent as MovieClip).properties;
               if(_loc4_ == MafiaModel.userData.playerID)
               {
                  layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               }
               else
               {
                  layoutManager.state = Constants_LayoutStates.STATE_OTHERPROFILE;
               }
               PlayerProfileCommand.sendCommand(_loc4_,false);
               break;
            case this.mafiaRanking.btn_up:
               if(!this.mafiaRanking.btn_up.enabled)
               {
                  return;
               }
               this.mafiaRanking.btn_up.enableButton = false;
               this.mafiaRanking.btn_down.enableButton = false;
               SearchRankingCommand.sendCommand(this._listType,String(Number(MafiaModel.userData.playerRankingData.players[0].rank) - 1),MafiaPlayerRankingData.RANKING_LIST_LENGTH);
               break;
            case this.mafiaRanking.btn_down:
               if(!this.mafiaRanking.btn_down.enabled)
               {
                  return;
               }
               this.mafiaRanking.btn_down.enableButton = false;
               this.mafiaRanking.btn_up.enableButton = false;
               SearchRankingCommand.sendCommand(this._listType,String(Number(MafiaModel.userData.playerRankingData.players[MafiaModel.userData.playerRankingData.players.length - 1].rank)),MafiaPlayerRankingData.RANKING_LIST_LENGTH);
               break;
            case this.mafiaRanking.btn_toOwnPlayer:
               SearchRankingCommand.sendCommand(this._listType,MafiaModel.userData.profileData.name,MafiaPlayerRankingData.RANKING_LIST_LENGTH);
               break;
            case this.mafiaRanking.layer_gotoTroop.btn_toTroopRanking:
               layoutManager.state = Constants_LayoutStates.STATE_CLANRANKING;
               break;
            case this.mafiaRanking.txt_search:
               this.mafiaRanking.txt_search.text = "";
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is RankingMouseOverNameLayer || param1.target is RankingMouseOverClanLayer)
         {
            (param1.target as MovieClip).alpha = 1;
            super.onMouseOver(param1);
            return;
         }
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is RankingMouseOverNameLayer || param1.target is RankingMouseOverClanLayer)
         {
            (param1.target as MovieClip).alpha = 0.05;
            super.onMouseOut(param1);
            return;
         }
         super.onMouseOut(param1);
      }
      
      public function get mafiaRanking() : MafiaPlayerRanking
      {
         return disp as MafiaPlayerRanking;
      }
      
      override public function hide() : void
      {
         super.hide();
      }
   }
}
