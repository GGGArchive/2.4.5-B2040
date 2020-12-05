package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.event.BasicComboboxEvent;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.RankingListType;
   import com.goodgamestudios.mafia.controller.commands.clan.ShowClanCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.controller.commands.ranking.SearchRankingCommand;
   import com.goodgamestudios.mafia.event.model.MafiaRankingEvent;
   import com.goodgamestudios.mafia.helper.FamilyCrestHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaOtherUserData;
   import com.goodgamestudios.mafia.model.components.user.ranking.MafiaFamilyRankingData;
   import com.goodgamestudios.mafia.model.components.user.ranking.MafiaPlayerRankingData;
   import com.goodgamestudios.mafia.view.MafiaToolTipManager;
   import com.goodgamestudios.mafia.view.screens.ranking.MafiaRankingComboboxComponent;
   import com.goodgamestudios.mafia.view.tooltips.MafiaClanRankingWarStatusAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaClanRankingWarStatusAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.clan.ClanRankingVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class MafiaClanRankingScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaClanRankingScreen";
       
      
      private var searchedClan:String = "";
      
      private var _listType:RankingListType;
      
      private var selectionBox:MafiaRankingComboboxComponent;
      
      public function MafiaClanRankingScreen(param1:DisplayObject)
      {
         super(param1);
         controller.addEventListener(MafiaRankingEvent.CHANGE_CLAN_RANKING_LIST_DATA,this.onFamilyRankingListData);
         controller.addEventListener(MafiaRankingEvent.CHANGE_CLAN_RANKING_TOP_DATA,this.onFamilyRankingTopData);
         this.mafiaRanking.layer_gotoTroop.btn_toTroopRanking.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_btn_familyranking");
         this.mafiaRanking.layer_gotoPlayers.gotoAndStop(2);
         this.mafiaRanking.layer_gotoPlayers.btn_toPlayerRanking.y = -13.25;
         this.mafiaRanking.layer_gotoPlayers.btn_toPlayerRanking.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_btn_playerranking");
         this.mafiaRanking.txt_rang.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_rank");
         this.mafiaRanking.txt_name.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_name");
         this.mafiaRanking.txt_level.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level");
         this.mafiaRanking.txt_leader.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_godfather");
         this.mafiaRanking.txt_glory.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_honor");
         this.mafiaRanking.txt_status.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_status");
         this.mafiaRanking.txt_search.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_copy_1");
         this.mafiaRanking.btn_toOwnPlayer.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_btn_myposition");
         this.mafiaRanking.update.txt_label.text = "-" + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_honordecay",[1]);
         this.selectionBox = new MafiaRankingComboboxComponent(this.mafiaRanking.listSelection);
         this.selectionBox.disp.addEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onChangeList);
         var _loc2_:Object = {
            "label":MafiaModel.languageData.getTextById("MafiaRankingScreen_text_Honor_UpToDate"),
            "data":{
               "id":RankingListType.FamilyDynamic,
               "mainName":MafiaModel.languageData.getTextById("MafiaAvatarScreen_btn_family") + ": "
            }
         };
         this.selectionBox.addItem(_loc2_);
         var _loc3_:Object = {
            "label":MafiaModel.languageData.getTextById("MafiaRankingScreen_text_Honor_HallOfFame"),
            "data":{
               "id":RankingListType.FamilyAlltime,
               "mainName":MafiaModel.languageData.getTextById("MafiaAvatarScreen_btn_family") + ": "
            }
         };
         this.selectionBox.addItem(_loc3_);
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_RANKING;
      }
      
      override public function show() : void
      {
         super.show();
         this.mafiaRanking.update.visible = false;
         this.mafiaRanking.btn_ok.toolTipText = MafiaModel.languageData.getTextById("generic_btn_search");
         controller.addEventListener(MafiaRankingEvent.CHANGE_CLAN_RANKING_TIME,this.onRankingUpdateTime);
         this.selectionBox.selectItemIndex(0);
         this.mafiaRanking.btn_toOwnPlayer.enableButton = MafiaModel.userData.profileData.clanID > 0 && MafiaModel.userData.profileData.clanID < Constants_Basic.LOOKING_FOR_CLAN_ID;
         this.fillRankingList(new Vector.<ClanRankingVO>());
         this.fillRankingTopEntries(new Vector.<ClanRankingVO>());
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(MafiaRankingEvent.CHANGE_CLAN_RANKING_LIST_DATA,this.onFamilyRankingListData);
         controller.removeEventListener(MafiaRankingEvent.CHANGE_CLAN_RANKING_TOP_DATA,this.onFamilyRankingTopData);
         this.selectionBox.disp.removeEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onChangeList);
         super.destroy();
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaRankingEvent.CHANGE_CLAN_RANKING_TIME,this.onRankingUpdateTime);
         super.removeEvents();
      }
      
      private function onFamilyRankingListData(param1:MafiaRankingEvent) : void
      {
         this.fillRanking(MafiaModel.userData.familyRankingData.listClans,MafiaModel.userData.familyRankingData.listType);
      }
      
      private function onFamilyRankingTopData(param1:MafiaRankingEvent) : void
      {
         this.fillRanking(MafiaModel.userData.familyRankingData.topClans,MafiaModel.userData.familyRankingData.listType);
      }
      
      private function fillRanking(param1:Vector.<ClanRankingVO>, param2:RankingListType) : void
      {
         this._listType = param2;
         if(param1.length == MafiaFamilyRankingData.TOP_RANKING_LENGTH)
         {
            this.fillRankingTopEntries(param1);
         }
         else if(param1.length > MafiaFamilyRankingData.TOP_RANKING_LENGTH)
         {
            this.fillRankingList(param1);
         }
      }
      
      private function fillRankingTopEntries(param1:Vector.<ClanRankingVO>) : void
      {
         var _loc2_:ClanRankingVO = null;
         var _loc3_:TopThreeClanEntry = null;
         var _loc5_:Sprite = null;
         var _loc4_:uint = 0;
         while(_loc4_ < MafiaFamilyRankingData.TOP_RANKING_LENGTH)
         {
            _loc3_ = this.mafiaRanking["top_" + _loc4_] as TopThreeClanEntry;
            if(_loc4_ >= param1.length)
            {
               _loc3_.visible = false;
            }
            else
            {
               _loc2_ = param1[_loc4_];
               _loc3_.visible = true;
               _loc3_.gotoAndStop(_loc2_.rank);
               _loc3_.btn_gotoFamily.properties = _loc2_;
               _loc3_.txt_name.embedFonts = true;
               _loc3_.txt_name.text = _loc2_.name;
               if(_loc3_.txt_name.textWidth == 0)
               {
                  _loc3_.txt_name.embedFonts = false;
                  _loc3_.txt_name.text = _loc2_.name;
               }
               _loc3_.txt_level.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " " + _loc2_.level;
               _loc3_.txt_glory.text = NumberStringHelper.groupString(_loc2_.glory,MafiaModel.languageData.getTextById);
               MovieClipHelper.clearMovieClip(_loc3_.crestContainer);
               if(_loc2_.crest != null)
               {
                  _loc5_ = FamilyCrestHelper.createFamilyCrest(_loc2_.crest,_loc2_.name,true);
                  _loc5_.mouseEnabled = false;
                  _loc5_.scaleX = _loc5_.scaleY = 0.7;
                  _loc5_.y = 13;
                  _loc3_.crestContainer.addChild(_loc5_);
               }
            }
            _loc4_++;
         }
      }
      
      private function fillRankingList(param1:Vector.<ClanRankingVO>) : void
      {
         var _loc2_:ClanRankingVO = null;
         var _loc3_:ClanRankingVO = null;
         var _loc4_:ClanRankingLine = null;
         var _loc6_:Boolean = false;
         var _loc7_:DefendRegister = null;
         var _loc8_:AttackRegister = null;
         var _loc5_:uint = 0;
         while(_loc5_ < MafiaFamilyRankingData.RANKING_LIST_LENGTH)
         {
            _loc2_ = param1.length > _loc5_?param1[_loc5_]:null;
            _loc4_ = this.mafiaRanking["rankingLine_" + _loc5_] as ClanRankingLine;
            if(_loc2_ && _loc3_ && _loc2_.clanID == _loc3_.clanID)
            {
               _loc2_ = null;
            }
            else
            {
               _loc3_ = _loc2_;
            }
            _loc4_.visible = _loc2_ != null;
            _loc4_.properties = _loc2_;
            if(_loc2_ != null)
            {
               _loc4_.txt_name.embedFonts = true;
               _loc4_.txt_name.text = _loc2_.name;
               if(_loc4_.txt_name.textWidth == 0)
               {
                  _loc4_.txt_name.embedFonts = false;
                  _loc4_.txt_name.text = _loc2_.name;
               }
               _loc4_.txt_level.text = String(_loc2_.level);
               _loc4_.txt_glory.text = NumberStringHelper.groupString(_loc2_.glory,MafiaModel.languageData.getTextById);
               _loc4_.txt_rang.text = NumberStringHelper.groupString(_loc2_.rank,MafiaModel.languageData.getTextById);
               _loc4_.txt_leader.text = _loc2_.leader;
               _loc4_.txt_leader.embedFonts = true;
               if(_loc4_.txt_leader.textWidth == 0)
               {
                  _loc4_.txt_leader.embedFonts = false;
                  _loc4_.txt_leader.text = _loc2_.leader;
               }
               _loc4_.txt_member.text = String(_loc2_.member);
               _loc4_.btn_layer_name.alpha = 0.05;
               _loc4_.btn_layer_name.width = _loc4_.txt_leader.textWidth + 20;
               _loc4_.btn_layer_name.buttonMode = true;
               _loc4_.btn_layer_leader.alpha = 0.05;
               _loc4_.btn_layer_leader.width = _loc4_.txt_name.textWidth + 20;
               _loc4_.btn_layer_leader.buttonMode = true;
               MovieClipHelper.clearMovieClip(_loc4_.status_attack);
               MovieClipHelper.clearMovieClip(_loc4_.status_defend);
               if(_loc2_.attackingClanName != null)
               {
                  _loc7_ = new DefendRegister();
                  _loc4_.status_defend.addChild(_loc7_);
               }
               if(_loc2_.defendingClanName != null)
               {
                  _loc8_ = new AttackRegister();
                  _loc4_.status_attack.addChild(_loc8_);
               }
               if(_loc2_.defendingClanName != null || _loc2_.attackingClanName != null)
               {
                  _loc4_.war.toolTipVO = new TooltipVO(MafiaClanRankingWarStatusAdvancedTooltip.NAME,new MafiaClanRankingWarStatusAdvancedTooltipProperties(_loc2_.attackClanWarTime,_loc2_.attackingClanName,_loc2_.defendClanWarTime,_loc2_.defendingClanName),null,MafiaToolTipManager.TOPDISPMOUSEPOS,1);
               }
               else
               {
                  _loc4_.war.toolTipVO = null;
               }
               _loc6_ = false;
               if(_loc2_.name.toLowerCase() == this.searchedClan.toLowerCase())
               {
                  _loc6_ = true;
               }
               else if(_loc2_.name.toLowerCase() == MafiaModel.userData.userClan.lastViewedClan.toLowerCase())
               {
                  _loc6_ = true;
               }
               else if(String(_loc2_.rank) == this.searchedClan)
               {
                  _loc6_ = true;
               }
               else if(_loc2_.clanID == MafiaModel.userData.profileData.clanID)
               {
                  _loc6_ = true;
               }
               _loc4_.rankingLineBG.gotoAndStop(!!_loc6_?2:1);
               _loc4_.mc_change.visible = false;
            }
            _loc5_++;
         }
         this.searchedClan = "";
         this.mafiaRanking.btn_up.enableButton = !!param1.length?param1[0].rank > 1:false;
         this.mafiaRanking.btn_down.enableButton = param1.length >= 8;
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
      
      private function onChangeList(param1:BasicComboboxEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:Object = this.selectionBox.selectedData;
         if(MafiaModel.userData.profileData.clanID > 0 && MafiaModel.userData.profileData.clanID < Constants_Basic.LOOKING_FOR_CLAN_ID)
         {
            switch(_loc2_.id)
            {
               case RankingListType.FamilyDynamic:
               case RankingListType.FamilyAlltime:
                  _loc3_ = MafiaModel.userData.profileData.clanName;
            }
         }
         else
         {
            _loc3_ = String(1);
         }
         SearchRankingCommand.sendCommand(_loc2_.id,"1",MafiaFamilyRankingData.TOP_RANKING_LENGTH);
         SearchRankingCommand.sendCommand(_loc2_.id,_loc3_,MafiaFamilyRankingData.RANKING_LIST_LENGTH);
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.enterSearch();
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         super.onClick(param1);
         if(param1.target is RankingMouseOverClanLayer)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = _loc2_.parent as ClanRankingLine;
            if(!_loc3_.properties || _loc3_.properties.clanID == 0)
            {
               return;
            }
            if(_loc3_.properties.clanID != MafiaModel.userData.profileData.clanID)
            {
               ShowClanCommand.sendCommand(_loc3_.properties.clanID);
               layoutManager.state = Constants_LayoutStates.STATE_OTHERCLAN;
            }
            else
            {
               ShowClanCommand.sendCommand();
               layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
            }
         }
         if(param1.target is RankingMouseOverNameLayer)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = _loc2_.parent as ClanRankingLine;
            if(!_loc3_.properties)
            {
               return;
            }
            if(_loc3_.properties.founderID != MafiaModel.userData.playerID)
            {
               MafiaModel.otherUserData = new MafiaOtherUserData();
               layoutManager.state = Constants_LayoutStates.STATE_OTHERPROFILE;
            }
            else
            {
               layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
            }
            PlayerProfileCommand.sendCommand(_loc3_.properties.founderID,false);
         }
         switch(param1.target)
         {
            case this.mafiaRanking.top_0.btn_gotoFamily:
            case this.mafiaRanking.top_1.btn_gotoFamily:
            case this.mafiaRanking.top_2.btn_gotoFamily:
               _loc2_ = param1.target as MovieClip;
               if(!_loc2_.properties || _loc2_.properties.clanID == 0)
               {
                  return;
               }
               if(_loc2_.properties.clanID != MafiaModel.userData.profileData.clanID)
               {
                  ShowClanCommand.sendCommand(_loc2_.properties.clanID);
                  layoutManager.state = Constants_LayoutStates.STATE_OTHERCLAN;
               }
               else
               {
                  ShowClanCommand.sendCommand();
                  layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
               }
               break;
            case this.mafiaRanking.btn_ok:
               this.enterSearch();
               break;
            case this.mafiaRanking.btn_up:
               if(!this.mafiaRanking.btn_up.enabled)
               {
                  return;
               }
               this.mafiaRanking.btn_up.enableButton = false;
               SearchRankingCommand.sendCommand(this._listType,String(Number(MafiaModel.userData.familyRankingData.listClans[0].rank) - 1),MafiaFamilyRankingData.RANKING_LIST_LENGTH);
               break;
            case this.mafiaRanking.btn_down:
               if(!this.mafiaRanking.btn_down.enabled)
               {
                  return;
               }
               this.mafiaRanking.btn_down.enableButton = false;
               SearchRankingCommand.sendCommand(this._listType,String(Number(MafiaModel.userData.familyRankingData.listClans[MafiaModel.userData.familyRankingData.listClans.length - 1].rank)),MafiaFamilyRankingData.RANKING_LIST_LENGTH);
               break;
            case this.mafiaRanking.btn_toOwnPlayer:
               if(MafiaModel.userData.profileData.clanID == 0 || MafiaModel.userData.profileData.clanID == Constants_Basic.LOOKING_FOR_CLAN_ID)
               {
                  _loc4_ = String(1);
               }
               else
               {
                  _loc4_ = MafiaModel.userData.profileData.clanName;
               }
               SearchRankingCommand.sendCommand(this._listType,_loc4_,MafiaFamilyRankingData.RANKING_LIST_LENGTH);
               break;
            case this.mafiaRanking.layer_gotoPlayers.btn_toPlayerRanking:
               SearchRankingCommand.sendCommand(RankingListType.PlayerDynamic,"1",MafiaPlayerRankingData.TOP_RANKING_LENGTH);
               SearchRankingCommand.sendCommand(RankingListType.PlayerDynamic,MafiaModel.userData.profileData.name,MafiaPlayerRankingData.RANKING_LIST_LENGTH);
               break;
            case this.mafiaRanking.txt_search:
               this.mafiaRanking.txt_search.text = "";
         }
      }
      
      private function enterSearch() : void
      {
         if(TextValide.isSmartFoxValide(this.mafiaRanking.txt_search.text))
         {
            this.searchedClan = this.mafiaRanking.txt_search.text;
            SearchRankingCommand.sendCommand(this._listType,this.mafiaRanking.txt_search.text,MafiaFamilyRankingData.RANKING_LIST_LENGTH);
            this.mafiaRanking.txt_search.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_copy_1");
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
      
      public function get mafiaRanking() : MafiaClanRanking
      {
         return disp as MafiaClanRanking;
      }
   }
}
