package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.Constants_UnlockLevel;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.controller.commands.duel.PrepareDuelFightCommand;
   import com.goodgamestudios.mafia.controller.commands.duel.StartWantedFightCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.event.model.MafiaDuelEvent;
   import com.goodgamestudios.mafia.event.model.MafiaPoliceEvent;
   import com.goodgamestudios.mafia.event.model.MafiaSurvivalEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.event.model.MafiaWantedEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaCalendarEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaEddyFrostEvent;
   import com.goodgamestudios.mafia.model.components.user.MafiaProfileData;
   import com.goodgamestudios.mafia.model.components.user.duel.MafiaPvpData;
   import com.goodgamestudios.mafia.model.components.user.duel.MafiaWantedData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaFullInventoryDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaFullInventoryDialogProperties;
   import com.goodgamestudios.mafia.view.panels.MafiaReviewTutorialPanel;
   import com.goodgamestudios.mafia.view.screens.energy.MafiaEnergyBarComponent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import flash.utils.getDefinitionByName;
   
   public class MafiaDuelScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaDuelEpicScreen";
       
      
      private var tutShown:Boolean = false;
      
      private var energyBar:MafiaEnergyBarComponent;
      
      private var searchingForOpponent:Boolean = false;
      
      private var fightingDuel:Boolean = false;
      
      private var fightingWanted:Boolean = false;
      
      private var fightingSurvival:Boolean = false;
      
      private var hasDuelOpponent:Boolean = false;
      
      private var hasWantedOpponent:Boolean = false;
      
      private var lastPlayernameSearchedFor:String = "";
      
      private const PICLIST:Array = [Enemy99,Enemy126,Enemy127,Enemy128,Enemy129,Enemy130,Enemy131,Enemy132,Enemy133,Enemy134,Enemy135,Enemy136,Enemy137,Enemy138,Enemy139,Enemy140,Enemy141,Enemy142,Enemy143,Enemy144,Enemy145,Enemy146,Enemy147,Enemy148,Enemy149,Enemy150];
      
      public function MafiaDuelScreen(param1:DisplayObject)
      {
         super(param1);
         this.mafiaDuel.eddyLayer.visible = false;
         this.energyBar = new MafiaEnergyBarComponent(this.mafiaDuel.energy_Bar);
         controller.addEventListener(MafiaDuelEvent.CHANGE_DUEL_RESULT,this.onChangeDuelResult);
         controller.addEventListener(MafiaDuelEvent.CANCELLED_DUEL_PREPARATION,this.onDuelPreparationCancelled);
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(MafiaDuelEvent.CHANGE_DUEL_RESULT,this.onChangeDuelResult);
         controller.removeEventListener(MafiaDuelEvent.CANCELLED_DUEL_PREPARATION,this.onDuelPreparationCancelled);
         super.destroy();
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_FIGHT;
      }
      
      private function updateButtons() : void
      {
         var _loc1_:Boolean = this.fightingDuel || this.fightingSurvival || this.fightingWanted;
         this.mafiaDuel.btn_quickattack.enableButton = MafiaModel.userData.profileData.isDuelUnlocked && this.hasDuelOpponent && !_loc1_ && !this.searchingForOpponent;
         this.mafiaDuel.btn_newenemy.enableButton = MafiaModel.userData.profileData.isDuelUnlocked && this.hasDuelOpponent && !_loc1_ && !this.searchingForOpponent;
         this.mafiaDuel.btn_gotoPlayer.enableButton = MafiaModel.userData.profileData.isDuelUnlocked && this.hasDuelOpponent && !_loc1_ && !this.searchingForOpponent;
         this.mafiaDuel.btn_search.enableButton = MafiaModel.userData.profileData.isDuelUnlocked && this.hasDuelOpponent && !_loc1_ && !this.searchingForOpponent;
         this.mafiaDuel.btn_waytohell.enableButton = MafiaModel.userData.profileData.isSurvivalUnlocked && !_loc1_;
         this.mafiaDuel.btn_epicattack.enableButton = MafiaModel.userData.profileData.isWantedUnlocked && this.hasWantedOpponent && !_loc1_;
         updateAllTextFields();
         this.mafiaDuel.btn_quickattack.update();
         this.mafiaDuel.btn_newenemy.update();
         this.mafiaDuel.btn_gotoPlayer.update();
         this.mafiaDuel.btn_waytohell.update();
         this.mafiaDuel.btn_epicattack.update();
         this.mafiaDuel.btn_search.update();
      }
      
      override public function show() : void
      {
         super.show();
         this.energyBar.show();
         this.energyBar.showDefaultEnergyBar();
         controller.addEventListener(MafiaDuelEvent.CHANGE_DUEL_DATA,this.onDuelData);
         controller.addEventListener(MafiaDuelEvent.DUEL_REJECTED,this.onDuelRejected);
         controller.addEventListener(MafiaWantedEvent.CHANGE_WANTEDDATA,this.onWantedData);
         controller.addEventListener(MafiaWantedEvent.CHANGE_WANTEDRESULT,this.onChangeWantedResult);
         controller.addEventListener(MafiaWantedEvent.WANTED_REJECTED,this.onWantedRejected);
         controller.addEventListener(MafiaDuelEvent.CHANGE_DUEL_TIMER,this.onDuelTimer);
         controller.addEventListener(MafiaDuelEvent.REMOVE_DUELTIMER,this.onRemoveDuelTimer);
         controller.addEventListener(MafiaWantedEvent.CHANGE_WANTEDTIMER,this.onWantedTimer);
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA,this.onSearchedPlayerData);
         controller.addEventListener(MafiaUserEvent.INVALID_NAME,this.onInvalidPlayerName);
         controller.addEventListener(MafiaSurvivalEvent.CHANGE_SURVIVALCOOLDOWNTIMER,this.onHellCoolDownTimer);
         controller.addEventListener(MafiaSurvivalEvent.CHANGE_SURVIVALDATA,this.onSurvivalData);
         controller.addEventListener(MafiaWantedEvent.UNLOCK_WANTED_BUTTON,this.onUnlockWantedButton);
         controller.addEventListener(MafiaPoliceEvent.POLICE_RETREAT,this.onPoliceRetreat);
         if(BasicLanguageFontManager.getInstance().useDefaultFont)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(this.mafiaDuel.txt_search);
         }
         else
         {
            this.mafiaDuel.txt_search.embedFonts = false;
         }
         this.mafiaDuel.txt_search.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10");
         if(!this.tutShown && MafiaModel.userData.profileData.isDuelUnlocked && !MafiaModel.userData.profileData.isBarkeeperUnlocked && MafiaModel.userData.profileData.gloryDynamic == 0)
         {
            this.tutShown = true;
            layoutManager.showSpecificPanel(MafiaReviewTutorialPanel.NAME,new BasicStandardOkDialogProperties("",MafiaModel.languageData.getTextById("MafiaHelpTutDialog_duel")));
         }
         if(!MafiaModel.userData.profileData.isDuelUnlocked)
         {
            this.mafiaDuel.duelLevelBlock.txt_lock.text = MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[Constants_UnlockLevel.UNLOCK_DUEL]);
         }
         this.mafiaDuel.duelLevelBlock.visible = !MafiaModel.userData.profileData.isDuelUnlocked;
         if(!MafiaModel.userData.profileData.isWantedUnlocked)
         {
            this.mafiaDuel.epicLevelBlock.txt_lock.text = MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[Constants_UnlockLevel.UNLOCK_WANTED]);
         }
         this.mafiaDuel.epicLevelBlock.visible = !MafiaModel.userData.profileData.isWantedUnlocked;
         this.mafiaDuel.txt_duelcopy.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_13");
         this.mafiaDuel.txt_dueltitle.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_title");
         this.mafiaDuel.txt_enemysearch.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_18");
         this.mafiaDuel.btn_search.toolTipText = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_18");
         this.mafiaDuel.btn_newenemy.label = MafiaModel.languageData.getTextById("MafiaDuelScreen_btn_next");
         this.mafiaDuel.btn_quickattack.label = MafiaModel.languageData.getTextById("MafiaDuelScreen_btn_attack");
         this.mafiaDuel.btn_gotoPlayer.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_memberdetail");
         this.mafiaDuel.txt_hellcopy1.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_17");
         this.mafiaDuel.txt_hellcopy2.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_16");
         this.mafiaDuel.btn_waytohell.label = MafiaModel.languageData.getTextById("generic_btn_start");
         this.mafiaDuel.btn_waytohell.goldInfoVisible = false;
         this.mafiaDuel.btn_epicattack.label = MafiaModel.languageData.getTextById("MafiaDuelScreen_btn_attack");
         this.updateButtons();
         if(MafiaModel.userData.duelData.wantedData.wantedEnemyPicID == 0)
         {
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
         }
         if(this.fightingWanted)
         {
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
         }
         if(this.fightingSurvival)
         {
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_SURVIVAL_COOLDOWN,[]);
         }
         updateAllTextFields();
      }
      
      protected function onDuelPreparationCancelled(param1:Event) : void
      {
         this.fightingDuel = false;
         this.hasDuelOpponent = true;
         this.updateButtons();
      }
      
      protected function onDuelRejected(param1:Event) : void
      {
         this.fightingDuel = false;
         this.hasDuelOpponent = true;
         this.updateButtons();
         updateAllTextFields();
      }
      
      protected function onWantedRejected(param1:Event) : void
      {
         this.fightingWanted = false;
         this.hasWantedOpponent = true;
         this.updateButtons();
         updateAllTextFields();
      }
      
      override protected function removeEvents() : void
      {
         this.energyBar.hide();
         controller.removeEventListener(MafiaDuelEvent.CHANGE_DUEL_DATA,this.onDuelData);
         controller.removeEventListener(MafiaDuelEvent.CHANGE_DUEL_TIMER,this.onDuelTimer);
         controller.removeEventListener(MafiaDuelEvent.REMOVE_DUELTIMER,this.onRemoveDuelTimer);
         controller.removeEventListener(MafiaDuelEvent.DUEL_REJECTED,this.onDuelRejected);
         controller.removeEventListener(MafiaWantedEvent.CHANGE_WANTEDDATA,this.onWantedData);
         controller.removeEventListener(MafiaWantedEvent.CHANGE_WANTEDTIMER,this.onWantedTimer);
         controller.removeEventListener(MafiaWantedEvent.CHANGE_WANTEDRESULT,this.onChangeWantedResult);
         controller.removeEventListener(MafiaWantedEvent.WANTED_REJECTED,this.onWantedRejected);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA,this.onSearchedPlayerData);
         controller.removeEventListener(MafiaUserEvent.INVALID_NAME,this.onInvalidPlayerName);
         controller.removeEventListener(MafiaSurvivalEvent.CHANGE_SURVIVALCOOLDOWNTIMER,this.onHellCoolDownTimer);
         controller.removeEventListener(MafiaSurvivalEvent.CHANGE_SURVIVALDATA,this.onSurvivalData);
         controller.removeEventListener(MafiaWantedEvent.UNLOCK_WANTED_BUTTON,this.onUnlockWantedButton);
         controller.removeEventListener(MafiaPoliceEvent.POLICE_RETREAT,this.onPoliceRetreat);
         super.removeEvents();
      }
      
      protected function onUnlockWantedButton(param1:MafiaWantedEvent) : void
      {
         this.fightingWanted = false;
         this.updateButtons();
         updateAllTextFields();
      }
      
      private function onDuelData(param1:MafiaDuelEvent) : void
      {
         this.fillDuel(MafiaModel.userData.duelData.pvpData);
         this.hasDuelOpponent = true;
         this.searchingForOpponent = false;
         this.updateButtons();
         updateAllTextFields();
      }
      
      private function onWantedData(param1:MafiaWantedEvent) : void
      {
         this.fillWanted(MafiaModel.userData.duelData.wantedData);
         this.hasWantedOpponent = true;
         this.updateButtons();
         updateAllTextFields();
      }
      
      private function onSurvivalData(param1:MafiaSurvivalEvent) : void
      {
         this.mafiaDuel.btn_waytohell.label = MafiaModel.languageData.getTextById("generic_btn_start");
         this.mafiaDuel.btn_waytohell.goldInfoVisible = false;
         this.fightingSurvival = false;
         this.updateButtons();
         updateAllTextFields();
      }
      
      protected function onPoliceRetreat(param1:MafiaPoliceEvent) : void
      {
         this.hasWantedOpponent = true;
         this.fightingDuel = this.fightingSurvival = this.fightingWanted = false;
         this.updateButtons();
      }
      
      private function fillDuel(param1:MafiaPvpData) : void
      {
         this.fillBasicDuel();
         var _loc2_:String = param1.duelOpponent.playerName;
         if(param1.duelOpponent.clanName != "")
         {
            _loc2_ = _loc2_ + (" <" + param1.duelOpponent.clanName + "> ");
         }
         this.mafiaDuel.txt_opponentName.text = _loc2_;
         this.mafiaDuel.txt_opponentLevel.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " " + param1.duelOpponent.level.toString();
         this.mafiaDuel.classHolder.addChild(param1.duelOpponent.classPic);
         this.mafiaDuel.avatarPicField.holder.addChild(param1.duelOpponent.typePic);
         this.mafiaDuel.btn_gotoPlayer.properties = param1.duelOpponent.playerID;
      }
      
      private function fillBasicDuel() : void
      {
         MovieClipHelper.clearMovieClip(this.mafiaDuel.classHolder);
         MovieClipHelper.clearMovieClip(this.mafiaDuel.avatarPicField.holder);
         updateAllTextFields();
         this.mafiaDuel.btn_newenemy.goldInfoVisible = false;
         this.mafiaDuel.btn_quickattack.goldInfoVisible = false;
      }
      
      private function fillWanted(param1:MafiaWantedData) : void
      {
         var _loc3_:Class = null;
         var _loc4_:Sprite = null;
         this.mafiaDuel.btn_epicattack.goldInfoVisible = false;
         this.mafiaDuel.txt_epiccopy.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_12");
         var _loc2_:int = param1.wantedEnemyPicID;
         _loc3_ = getDefinitionByName("Enemy" + _loc2_.toString()) as Class;
         _loc4_ = new _loc3_();
         _loc4_.scaleX = _loc4_.scaleY = 1.7;
         MovieClipHelper.clearMovieClip(this.mafiaDuel.enemyAvatarPic);
         MovieClipHelper.clearMovieClip(this.mafiaDuel.eddyLayer.enemyAvatarPic);
         MovieClipHelper.clearMovieClip(this.mafiaDuel.jahLayer.enemyAvatarPic);
         this.mafiaDuel.enemyAvatarPic.addChild(_loc4_);
         this.mafiaDuel.txt_wantedname.text = "";
         this.mafiaDuel.eddyLayer.visible = false;
         this.mafiaDuel.jahLayer.visible = false;
         if(param1.character.index == CharacterClass.Bully.index)
         {
            this.mafiaDuel.charaClass.gotoAndStop(1);
         }
         else if(param1.character.index == CharacterClass.Rogue.index)
         {
            this.mafiaDuel.charaClass.gotoAndStop(2);
         }
         else if(param1.character.index == CharacterClass.Tactician.index)
         {
            this.mafiaDuel.charaClass.gotoAndStop(3);
         }
         if(_loc2_ == Constants_SpecialEvents.CAPO_VITO_PIC_ID)
         {
            this.mafiaDuel.txt_wantedname.text = param1.wantedEnemyName;
            this.mafiaDuel.txt_epiccopy.text = MafiaModel.languageData.getTextById("event_capovito_copy_3");
         }
         if(_loc2_ == Constants_SpecialEvents.NIGHT_OF_HORROR_PIC_ID)
         {
            this.mafiaDuel.txt_wantedname.text = param1.wantedEnemyName;
            this.mafiaDuel.txt_epiccopy.text = MafiaModel.languageData.getTextById("event_capovito_copy_3");
         }
         if(_loc2_ >= MafiaCalendarEvent.START_PIC_ID)
         {
            this.mafiaDuel.eddyLayer.visible = false;
            this.mafiaDuel.jahLayer.visible = false;
            this.mafiaDuel.txt_wantedname.text = "||| " + param1.wantedEnemyName + " |||";
            if(_loc2_ == MafiaCalendarEvent.BOSS_PIC_ID)
            {
               this.mafiaDuel.jahLayer.visible = true;
               this.mafiaDuel.txt_epiccopy.text = MafiaModel.specialEvent.calendarEvent.eventSubtitle;
            }
            else if(_loc2_ == MafiaEddyFrostEvent.BOSS_PIC_ID)
            {
               this.mafiaDuel.eddyLayer.visible = true;
               this.mafiaDuel.txt_epiccopy.text = MafiaModel.specialEvent.eddyFrostEvent.eventSubtitle;
            }
            else if(MafiaModel.specialEvent.calendarEvent.isEventActive)
            {
               this.mafiaDuel.jahLayer.visible = true;
               this.mafiaDuel.txt_epiccopy.text = MafiaModel.languageData.getTextById("event_jahbandulu_copy_8",[MafiaModel.specialEvent.calendarEvent.bossName]);
            }
            else if(MafiaModel.specialEvent.eddyFrostEvent.isEventActive)
            {
               this.mafiaDuel.eddyLayer.visible = true;
               this.mafiaDuel.txt_epiccopy.text = MafiaModel.languageData.getTextById("event_jahbandulu_copy_8",[MafiaModel.specialEvent.eddyFrostEvent.bossName]);
            }
            _loc4_.scaleX = _loc4_.scaleY = 0.5;
            if(MafiaModel.specialEvent.eddyFrostEvent.isEventActive)
            {
               this.mafiaDuel.eddyLayer.enemyAvatarPic.addChild(_loc4_);
            }
            else if(MafiaModel.specialEvent.calendarEvent.isEventActive)
            {
               this.mafiaDuel.jahLayer.enemyAvatarPic.addChild(_loc4_);
            }
         }
      }
      
      private function onDuelTimer(param1:MafiaDuelEvent) : void
      {
         this.mafiaDuel.btn_quickattack.goldInfoVisible = true;
         this.mafiaDuel.btn_quickattack.goldInfoTimeText = MafiaModel.languageData.getTextById("tt_MafiaButton_forfree") + " " + param1.params[0];
         this.mafiaDuel.btn_quickattack.goldInfoGoldText = MafiaModel.goldConstants.cutNextFreeDuelTimePricePerSecond.toString();
         updateAllTextFields(this.mafiaDuel.btn_quickattack);
      }
      
      private function onRemoveDuelTimer(param1:MafiaDuelEvent) : void
      {
         this.mafiaDuel.btn_quickattack.goldInfoVisible = false;
      }
      
      private function onWantedTimer(param1:MafiaWantedEvent) : void
      {
         this.mafiaDuel.btn_epicattack.goldInfoVisible = true;
         this.mafiaDuel.btn_epicattack.goldInfoTimeText = MafiaModel.languageData.getTextById("tt_MafiaButton_forfree") + " " + param1.params[0];
         this.mafiaDuel.btn_epicattack.goldInfoGoldText = MafiaModel.goldConstants.cutNextFreeWantedTimePricePerSecond.toString();
         updateAllTextFields(this.mafiaDuel.btn_epicattack);
      }
      
      private function onHellCoolDownTimer(param1:MafiaSurvivalEvent) : void
      {
         this.mafiaDuel.btn_waytohell.goldInfoVisible = true;
         this.mafiaDuel.btn_waytohell.goldInfoTimeText = MafiaModel.languageData.getTextById("tt_MafiaButton_forfree") + " " + param1.params[0];
         this.mafiaDuel.btn_waytohell.goldInfoGoldText = MafiaModel.goldConstants.cutNextFreeSurviavalTimePricePerSecond.toString();
         updateAllTextFields(this.mafiaDuel.btn_waytohell);
      }
      
      private function onSearchedPlayerData(param1:MafiaUserEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Sprite = null;
         var _loc5_:Sprite = null;
         var _loc2_:MafiaProfileData = MafiaModel.otherUserData.profileData;
         if(_loc2_.name.toLowerCase() == this.lastPlayernameSearchedFor.toLowerCase())
         {
            this.fillBasicDuel();
            _loc3_ = _loc2_.name;
            MafiaModel.userData.duelData.pvpData.duelOpponent.playerName = _loc3_;
            MafiaModel.userData.duelData.pvpData.lastDuelEnemy = _loc3_;
            if(_loc2_.clanName != "")
            {
               _loc3_ = _loc3_ + (" <" + _loc2_.clanName + "> ");
            }
            this.mafiaDuel.txt_opponentName.text = _loc3_;
            this.mafiaDuel.txt_opponentLevel.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " " + _loc2_.level.toString();
            if(_loc2_.picString.length == 2)
            {
               _loc4_ = AvatarHelper.createOldAvatar(_loc2_.picString);
            }
            else
            {
               _loc4_ = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(_loc2_.picString),Constants_ViewScales.SCALE_AVATAR_DUEL_SEARCH,true,Constants_ViewScales.SCALE_AVATARBACKGROUND_DUEL_SEARCH);
            }
            _loc4_.mouseEnabled = false;
            _loc4_.mouseChildren = false;
            _loc5_ = AvatarHelper.createClassSymbol(_loc2_.characterClass);
            this.mafiaDuel.classHolder.addChild(_loc5_);
            this.mafiaDuel.avatarPicField.holder.addChild(_loc4_);
            this.mafiaDuel.btn_gotoPlayer.properties = _loc2_.playerID;
         }
         else if(this.searchingForOpponent)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaDuelScreen_title"),MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_3",[this.lastPlayernameSearchedFor])));
         }
         this.mafiaDuel.txt_search.text = this.defaultSearchInputText;
         this.searchingForOpponent = false;
         this.updateButtons();
      }
      
      private function onInvalidPlayerName(param1:MafiaUserEvent) : void
      {
         var _loc2_:String = param1.params[0];
         layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaDuelScreen_title"),MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_4",[_loc2_])));
         this.mafiaDuel.txt_search.text = this.defaultSearchInputText;
         this.searchingForOpponent = false;
         this.updateButtons();
      }
      
      private function onChangeDuelResult(param1:MafiaDuelEvent) : void
      {
         this.fightingDuel = false;
         this.searchingForOpponent = false;
         this.updateButtons();
         layoutManager.state = Constants_LayoutStates.STATE_DUEL_FIGHT;
      }
      
      private function onChangeWantedResult(param1:MafiaWantedEvent) : void
      {
         this.fightingWanted = false;
         this.updateButtons();
         layoutManager.state = Constants_LayoutStates.STATE_WANTED_FIGHT;
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.mafiaDuel.txt_search:
               if(this.mafiaDuel.txt_search.text == this.defaultSearchInputText)
               {
                  this.mafiaDuel.txt_search.text = "";
               }
         }
         super.onMouseDown(param1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is MovieClip && !(param1.target as MovieClip).enabled)
         {
            return;
         }
         switch(param1.target)
         {
            case this.mafiaDuel.btn_newenemy:
               this.mafiaDuel.txt_search.text = this.defaultSearchInputText;
               this.searchingForOpponent = true;
               this.updateButtons();
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[0]);
               break;
            case this.mafiaDuel.btn_quickattack:
               this.onStartDuel();
               break;
            case this.mafiaDuel.btn_search:
               this.onSearchPlayer();
               break;
            case this.mafiaDuel.btn_epicattack:
               if(!this.mafiaDuel.btn_epicattack.enabled)
               {
                  return;
               }
               if(!MafiaModel.userData.inventory.isInventoryFull)
               {
                  this.onStartWantedFight();
               }
               else
               {
                  layoutManager.showDialog(MafiaFullInventoryDialog.NAME,new MafiaFullInventoryDialogProperties(0,MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_title"),MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_copy_1"),this.onStartWantedFight,this.gotoShop));
               }
               break;
            case this.mafiaDuel.btn_gotoPlayer:
               layoutManager.state = Constants_LayoutStates.STATE_OTHERPROFILE;
               PlayerProfileCommand.sendCommand(this.mafiaDuel.btn_gotoPlayer.properties,false);
               break;
            case this.mafiaDuel.btn_waytohell:
               this.fightingSurvival = true;
               this.updateButtons();
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_START_SURVIVAL,[]);
         }
         super.onClick(param1);
         updateAllTextFields();
      }
      
      private function onStartWantedFight(param1:int = 0) : void
      {
         MafiaDialogHandler.getInstance().blockDialogs = true;
         this.fightingWanted = true;
         this.hasWantedOpponent = false;
         this.updateButtons();
         StartWantedFightCommand.sendCommand();
      }
      
      private function gotoShop(param1:Object = null) : void
      {
         layoutManager.state = Constants_LayoutStates.STATE_SHOP;
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER && this.mafiaDuel.btn_search.enabled)
         {
            this.onSearchPlayer();
         }
      }
      
      private function onStartDuel() : void
      {
         var _loc1_:String = null;
         if(!this.mafiaDuel.btn_quickattack.enabled)
         {
            return;
         }
         if(this.isSearchFieldFilled)
         {
            if(this.isSearchFieldValueValide)
            {
               _loc1_ = this.mafiaDuel.txt_search.text;
            }
            else
            {
               this.showSearchError();
               return;
            }
         }
         else
         {
            _loc1_ = MafiaModel.userData.duelData.pvpData.duelOpponent.playerName;
         }
         MafiaModel.userData.duelData.pvpData.duelOpponent.playerName = _loc1_;
         MafiaModel.userData.duelData.pvpData.lastDuelEnemy = _loc1_;
         this.mafiaDuel.txt_search.text = this.defaultSearchInputText;
         this.fightingDuel = true;
         this.hasDuelOpponent = false;
         this.updateButtons();
         MafiaDialogHandler.getInstance().blockDialogs = true;
         PrepareDuelFightCommand.sendCommand(_loc1_);
      }
      
      private function onSearchPlayer() : void
      {
         if(this.isSearchFieldFilled)
         {
            if(this.isSearchFieldValueValide && this.mafiaDuel.txt_search.text != MafiaModel.userData.profileData.name)
            {
               PlayerProfileCommand.sendCommand(-1,true,this.mafiaDuel.txt_search.text);
               this.searchingForOpponent = true;
               this.lastPlayernameSearchedFor = this.mafiaDuel.txt_search.text;
               this.updateButtons();
            }
            else
            {
               this.showSearchError();
            }
         }
      }
      
      private function get isSearchFieldFilled() : Boolean
      {
         return this.mafiaDuel.txt_search.text != this.defaultSearchInputText && this.mafiaDuel.txt_search.text != "";
      }
      
      private function get isSearchFieldValueValide() : Boolean
      {
         return TextValide.isSmartFoxValide(this.mafiaDuel.txt_search.text) && this.mafiaDuel.txt_search.text.length > 0 && isNaN(Number(this.mafiaDuel.txt_search.text));
      }
      
      private function showSearchError() : void
      {
         layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaDuelScreen_title"),MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_4")));
         this.mafiaDuel.txt_search.text = this.defaultSearchInputText;
      }
      
      private function get defaultSearchInputText() : String
      {
         return MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10");
      }
      
      public function get mafiaDuel() : MafiaDuel
      {
         return disp as MafiaDuel;
      }
   }
}
