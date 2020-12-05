package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_Status;
   import com.goodgamestudios.mafia.constants.Constants_UnlockLevel;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.constants.enums.QuestAndFightProgress;
   import com.goodgamestudios.mafia.controller.commands.fight.ShowCityFightCommand;
   import com.goodgamestudios.mafia.controller.commands.fight.ShowCityFightItemsCommand;
   import com.goodgamestudios.mafia.controller.commands.gangwars.SDOCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.city.ShowCityEventOpponentCommand;
   import com.goodgamestudios.mafia.event.model.MafiaGangwarEvent;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.event.model.MafiaTravelEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.gangwar.MafiaGangwarsData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaUnlockGangwarDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaStartQuestDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaUnlockGangwarDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.quest.MafiaProgressQuestDialog;
   import com.goodgamestudios.mafia.view.dialogs.quest.MafiaStartQuestDialog;
   import com.goodgamestudios.mafia.view.panels.MafiaChooseTravelPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaReviewTutorialPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaTravelProgressPanel;
   import com.goodgamestudios.mafia.view.screens.dungeon.MafiaDungeonMapPositionSetter;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBonusQuestScreenProperties;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaGangwarTreeScreenProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaCityDistrictTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaCityQuestAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaCityQuestBonusTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaDungeonAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaCityDistrictTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaCityQuestAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaCityQuestBonusTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaDungeonAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.gangwar.GangwarVO;
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   import com.goodgamestudios.math.Random;
   import com.gskinner.motion.GTween;
   import com.gskinner.motion.easing.Bounce;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaGangwarScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaGangwarScreen";
       
      
      private var map:MovieClip;
      
      private var _mapStepX:Number;
      
      private var _mapStepY:Number;
      
      private var _wrongLineTweenDelay:Number;
      
      private var _wrongLineTweenTime:Number = 6;
      
      private var _wrongLineTweenY:Number;
      
      private var _flirrerCount:Number = 0;
      
      private var _bestDungeonToAttack:int;
      
      private var _bestDungeonShown:Boolean = false;
      
      private var _dungeonHelpShown:Boolean = false;
      
      private var _isMapFitToScreen:Boolean = false;
      
      private var _isMapScaleable:Boolean;
      
      public function MafiaGangwarScreen(param1:DisplayObject)
      {
         super(param1,false);
         this.mafiaDungeon.mapswitch.special.btn_special.bg_orange.visible = false;
      }
      
      override public function show() : void
      {
         super.show();
         this.mafiaDungeon.dugeonLevelBlock.txt_lock.text = MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[Constants_UnlockLevel.UNLOCK_DUNGEON1]);
         this.mafiaDungeon.dugeonLevelBlock.visible = !MafiaModel.userData.profileData.isFirstDungeonUnlocked;
         this.mafiaDungeon.mapswitch.special.btn_special.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_travel");
         this.mafiaDungeon.mapswitch.visible = !this._isMapFitToScreen;
         this.mafiaDungeon.mapswitch.special.visible = false;
         this.fillTravelButton(MafiaModel.userData.travelsData.travels.length);
         if(!this._dungeonHelpShown && MafiaModel.userData.profileData.isFirstDungeonUnlocked && MafiaModel.userData.achievementsData.achievements[0].achievementValue == 0 && MafiaModel.userData.gangwarData.nextFreeGangwarFightTime == 0)
         {
            if(!MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
            {
               layoutManager.showSpecificPanel(MafiaReviewTutorialPanel.NAME,new BasicStandardOkDialogProperties("",MafiaModel.languageData.getTextById("MafiaHelpTutDialog_gangwarfare")));
               this._dungeonHelpShown = true;
            }
         }
         controller.addEventListener(MafiaGangwarEvent.CHANGE_GANGWAR_DATA,this.onChangeDungeondata);
         controller.addEventListener(MafiaTravelEvent.CHANGE_TRAVELDATA,this.onChangeTraveldata);
         controller.addEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
         controller.addEventListener(MafiaQuestEvent.CHANGE_CITY_FIGHT_RESULT_DATA,this.onCityFightResult);
         if(MafiaModel.userData.gangwarData.gangwars && MafiaModel.userData.gangwarData.gangwars.length > 0)
         {
            this.fillDungeonMap(MafiaModel.userData.gangwarData);
         }
         this.mafiaDungeon.btn_zoom.visible = true;
      }
      
      override public function hide() : void
      {
         super.hide();
         layoutManager.hidePanel(MafiaChooseTravelPanel.NAME);
         layoutManager.hidePanel(MafiaTravelProgressPanel.NAME);
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaGangwarEvent.CHANGE_GANGWAR_DATA,this.onChangeDungeondata);
         controller.removeEventListener(MafiaTravelEvent.CHANGE_TRAVELDATA,this.onChangeTraveldata);
         controller.removeEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
         controller.removeEventListener(MafiaQuestEvent.CHANGE_CITY_FIGHT_RESULT_DATA,this.onCityFightResult);
         if(this.map)
         {
            this.map.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         }
         super.removeEvents();
      }
      
      private function onCityFightResult(param1:MafiaQuestEvent) : void
      {
         MafiaDialogHandler.getInstance().blockDialogs = true;
         layoutManager.state = Constants_LayoutStates.STATE_CITYQUEST_BONUS_FIGHT;
      }
      
      private function fillMapAsset(param1:City) : void
      {
         MovieClipHelper.clearMovieClip(this.mafiaDungeon.mapHolder);
         while(this.mafiaDungeon.mapswitch.special.numChildren > 2)
         {
            this.mafiaDungeon.mapswitch.special.removeChildAt(2);
         }
         switch(param1)
         {
            case City.NewYork:
               this.map = new MafiaGangwarMap_0();
               this._mapStepX = (1200 - Constants_Basic.GAME_WIDTH) * 0.5;
               this._mapStepY = (900 - Constants_Basic.GAME_HEIGHT) * 0.5;
               this._wrongLineTweenY = 900;
               this.mafiaDungeon.btn_zoom.enableButton = true;
               this.enableNavigation();
               this._isMapScaleable = true;
               this._bestDungeonShown = false;
               break;
            case City.Miami:
               this.map = new MafiaGangwarMap_1();
               this._mapStepX = (800 - Constants_Basic.GAME_WIDTH) * 0.5;
               this._mapStepY = (600 - Constants_Basic.GAME_HEIGHT) * 0.5;
               this._wrongLineTweenY = 600;
               this._isMapScaleable = false;
               this.mafiaDungeon.mapswitch.arrow.visible = false;
               this.disableNavigation();
               this.mafiaDungeon.btn_zoom.enableButton = false;
               break;
            case City.Hongkong:
               this.map = new MafiaGangwarMap_2();
               this._mapStepX = (800 - Constants_Basic.GAME_WIDTH) * 0.5;
               this._mapStepY = (600 - Constants_Basic.GAME_HEIGHT) * 0.5;
               this._wrongLineTweenY = 600;
               this._isMapScaleable = false;
               this.mafiaDungeon.mapswitch.arrow.visible = false;
               this.disableNavigation();
               this.mafiaDungeon.btn_zoom.enableButton = false;
               break;
            case City.Sicily:
               this.map = new MafiaGangwarMap_4();
               this._mapStepX = (800 - Constants_Basic.GAME_WIDTH) * 0.5;
               this._mapStepY = (600 - Constants_Basic.GAME_HEIGHT) * 0.5;
               this._wrongLineTweenY = 600;
               this._isMapScaleable = false;
               this.mafiaDungeon.mapswitch.arrow.visible = false;
               this.disableNavigation();
               this.mafiaDungeon.btn_zoom.enableButton = false;
         }
         this.mafiaDungeon.mapHolder.addChild(this.map);
         this.map.cacheAsBitmap = this.map.grid.wrongLine.cacheAsBitmap = this.map.fineLines.cacheAsBitmap = this.map.flirrer.cacheAsBitmap = this.map.grid.cacheAsBitmap = true;
         this.map.fineLines.mouseEnabled = this.map.flirrer.mouseEnabled = this.map.grid.mouseEnabled = this.map.grid.wrongLine.mouseEnabled = false;
         this.mafiaDungeon.mapswitch.cross.visible = false;
         this.mafiaDungeon.mapswitch.layer.gotoAndStop(param1.index + 1);
         this.initWrongLine();
         this.initFlirrer();
      }
      
      private function onWrongLineInit(param1:GTween) : void
      {
         this.map.grid.wrongLine.visible = true;
      }
      
      private function onWrongLineComplete(param1:GTween) : void
      {
         if(this.mafiaDungeon.visible == true)
         {
            this.initWrongLine();
         }
      }
      
      private function initWrongLine() : void
      {
         this.map.grid.wrongLine.visible = false;
         this._wrongLineTweenDelay = 3;
         this.map.grid.wrongLine.y = 0;
         var _loc1_:GTween = new GTween(this.map.grid.wrongLine,this._wrongLineTweenTime,{"y":this._wrongLineTweenY});
         _loc1_.delay = this._wrongLineTweenDelay;
         _loc1_.onInit = this.onWrongLineInit;
         _loc1_.onComplete = this.onWrongLineComplete;
      }
      
      private function initFlirrer() : void
      {
         this.map.flirrer.visible = false;
         this.map.flirrer.alpha = 0;
         this._flirrerCount = Random.integer(10,15);
         var _loc1_:GTween = new GTween(this.map.flirrer,0.1,{"alpha":0.1});
         _loc1_.delay = Random.float(10,25);
         _loc1_.onInit = this.onFlirrerInit;
         _loc1_.onComplete = this.onFlirrerComplete;
      }
      
      private function onFlirrerInit(param1:GTween) : void
      {
         this.map.flirrer.visible = true;
         this.map.flirrer.alpha = 0;
      }
      
      private function onFlirrerComplete(param1:GTween) : void
      {
         if(!this.mafiaDungeon.visible)
         {
            return;
         }
         this.map.flirrer.alpha = 0;
         this._flirrerCount--;
         var _loc2_:GTween = new GTween(this.map.flirrer,0.1,{"alpha":0.1});
         _loc2_.onComplete = this.onFlirrerComplete;
         if(this._flirrerCount == 0 && this.mafiaDungeon.visible == true)
         {
            this._flirrerCount = Random.integer(10,15);
            _loc2_.delay = Random.float(10,50);
            _loc2_.onInit = this.onFlirrerInit;
         }
      }
      
      private function onChangeStatus(param1:MafiaUserEvent) : void
      {
         this.fillByStatus();
      }
      
      private function fillByStatus() : void
      {
         switch(MafiaModel.userData.status)
         {
            case Constants_Status.STATUS_FREE:
               break;
            case Constants_Status.STATUS_FLYING:
            case Constants_Status.STATUS_FLIGHT_FINISHED:
               if(MafiaModel.userData.gangwarData.wasInitialized)
               {
                  layoutManager.showPanel(MafiaTravelProgressPanel.NAME);
               }
         }
      }
      
      private function onChangeDungeondata(param1:MafiaGangwarEvent) : void
      {
         MafiaLayoutManager.getInstance().tooltipManager.hideAdvancedTooltip();
         MafiaLayoutManager.getInstance().tooltipManager.hide();
         this.fillDungeonMap(MafiaModel.userData.gangwarData);
         this.fillByStatus();
      }
      
      private function onChangeTraveldata(param1:MafiaTravelEvent) : void
      {
         this.fillTravelButton(MafiaModel.userData.travelsData.travels.length);
      }
      
      private function fillDungeonMap(param1:MafiaGangwarsData) : void
      {
         var _loc3_:Pin = null;
         var _loc4_:Btn_CityQuestPin = null;
         var _loc5_:MovieClip = null;
         var _loc7_:Number = NaN;
         var _loc8_:GTween = null;
         var _loc9_:MovieClip = null;
         var _loc10_:String = null;
         var _loc11_:GTween = null;
         var _loc2_:City = param1.city;
         if(MafiaModel.specialEvent.sicilianEvent.isEventActive && MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
         {
            _loc2_ = City.Sicily;
         }
         this.fillMapAsset(_loc2_);
         if(_loc2_.index < City.Sicily.index && MafiaModel.specialEvent.sicilianEvent.isEventActive && MafiaModel.specialEvent.sicilianEvent.isMissionPhaseFinished && MafiaModel.specialEvent.sicilianEvent.gangwarEnemiesKilled == 0)
         {
            this.fitMap(false);
         }
         this.mafiaDungeon.mapswitch.arrow.visible = this._isMapScaleable;
         this._bestDungeonToAttack = 0;
         var _loc6_:int = 0;
         while(_loc6_ < param1.gangwars.length)
         {
            _loc3_ = this.map[String("pin" + int(_loc6_ + 1))] as Pin;
            _loc3_.visible = true;
            _loc3_.alpha = 0;
            _loc3_.properties = null;
            _loc3_.toolTipVO = null;
            _loc3_.cacheAsBitmap = true;
            if(_loc2_.index != City.Sicily.index)
            {
               _loc4_ = this.map[String("quest" + int(_loc6_ + 1))] as Btn_CityQuestPin;
               _loc4_.visible = false;
               _loc4_.alpha = 0;
               _loc4_.properties = null;
               _loc4_.toolTipVO = null;
               _loc4_.cacheAsBitmap = true;
            }
            _loc5_ = this.map[String("area" + int(_loc6_ + 1))] as MovieClip;
            _loc5_.cacheAsBitmap = true;
            _loc5_.mouseChildren = false;
            _loc5_.mouseEnabled = false;
            _loc5_.alpha = 1;
            if(_loc2_.index != City.Sicily.index)
            {
               _loc9_ = this.map[String("area_mask_" + int(_loc6_ + 1))] as MovieClip;
               _loc9_.visible = false;
               _loc9_.mouseEnabled = false;
               _loc9_.mouseChildren = false;
            }
            if(_loc2_.index != City.Sicily.index)
            {
               _loc4_.visible = true;
               _loc4_.properties = param1.gangwars[_loc6_].cityQuest;
               _loc4_.gangwar = param1.gangwars[_loc6_];
               _loc4_.quest_and_fight_progress = param1.gangwars[_loc6_].questAndFightProgress;
               _loc4_.gotoAndStop(param1.gangwars[_loc6_].questAndFightProgress.index);
               switch(param1.gangwars[_loc6_].questAndFightProgress)
               {
                  case QuestAndFightProgress.AvailableQuest:
                  case QuestAndFightProgress.ActiveQuest:
                  case QuestAndFightProgress.PausedQuest:
                     _loc4_.toolTipVO = new TooltipVO(MafiaCityQuestAdvancedTooltip.NAME,new MafiaCityQuestAdvancedTooltipProperties(param1.gangwars[_loc6_].cityQuest,param1.gangwars[_loc6_].district_id),null,"",BasicCustomCursor.CURSOR_CLICK);
                     break;
                  case QuestAndFightProgress.FightAvailable:
                  case QuestAndFightProgress.FightVictory:
                  case QuestAndFightProgress.RewardTaken:
                     _loc4_.toolTipVO = new TooltipVO(MafiaCityQuestBonusTooltip.NAME,new MafiaCityQuestBonusTooltipProperties(param1.gangwars[_loc6_]),null,"",BasicCustomCursor.CURSOR_CLICK);
                     break;
                  default:
                     _loc4_.toolTipVO = null;
               }
            }
            if(param1.gangwars[_loc6_].playerProgress >= 0 && param1.gangwars[_loc6_].playerProgress < 9)
            {
               _loc5_.alpha = 0;
               _loc3_.gotoAndStop(2);
               updateAllTextFields();
               if(MafiaModel.userData.gangwarData.city == City.Sicily)
               {
                  _loc3_.free.txt_done.text = param1.gangwars[_loc6_].playerProgress.toString() + " / 5";
               }
               else
               {
                  _loc3_.toolTipVO = new TooltipVO(MafiaCityDistrictTooltip.NAME,new MafiaCityDistrictTooltipProperties(param1.gangwars[_loc6_]),null,"",BasicCustomCursor.CURSOR_CLICK);
                  _loc3_.free.txt_done.text = param1.gangwars[_loc6_].playerProgress.toString() + " / 9";
               }
               _loc3_.properties = param1.gangwars[_loc6_];
               _loc3_.free.enableButton = true;
            }
            if(param1.gangwars[_loc6_].playerProgress == -1)
            {
               if(_loc2_.index != City.Sicily.index)
               {
                  _loc4_.visible = false;
               }
               _loc5_.gotoAndStop(1);
               if(param1.gangwars[_loc6_].unlockable)
               {
                  _loc3_.gotoAndStop(4);
                  _loc5_.alpha = 0;
                  if(_loc2_.index != City.Sicily.index)
                  {
                     _loc9_.visible = true;
                  }
                  _loc3_.properties = param1.gangwars[_loc6_];
                  _loc3_.unlock.unlockGold.visible = false;
                  _loc3_.unlock.unlockFriends.visible = false;
                  if(env.loginIsKeyBased && env.invitefriends || !env.loginIsKeyBased && MafiaModel.userData.emailVerified && env.invitefriends)
                  {
                     _loc3_.unlock.toolTipVO = new TooltipVO(MafiaDungeonAdvancedTooltip.NAME,new MafiaDungeonAdvancedTooltipProperties(param1.gangwars[_loc6_],MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_noFriends",[param1.gangwars[_loc6_].minRecruitedFriends - MafiaModel.userData.gangwarData.recruitedFriends])),null,"",BasicCustomCursor.CURSOR_CLICK);
                     _loc3_.unlock.unlockFriends.visible = true;
                  }
                  else
                  {
                     _loc3_.unlock.toolTipVO = new TooltipVO(MafiaDungeonAdvancedTooltip.NAME,new MafiaDungeonAdvancedTooltipProperties(param1.gangwars[_loc6_],MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_buyDungeon")),null,"",BasicCustomCursor.CURSOR_CLICK);
                     _loc3_.unlock.unlockGold.visible = true;
                  }
                  _loc3_.unlock.unlockGold.txt_time.text = param1.gangwars[_loc6_].unlockPriceC2.toString();
                  _loc3_.unlock.unlockFriends.txt_gold.text = param1.gangwars[_loc6_].unlockPriceC2.toString();
                  _loc3_.unlock.unlockFriends.txt_friends.text = param1.gangwars[_loc6_].minRecruitedFriends - MafiaModel.userData.gangwarData.recruitedFriends;
               }
               else
               {
                  _loc10_ = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_required");
                  if(param1.gangwars[_loc6_].minLevel > MafiaModel.userData.profileData.level)
                  {
                     _loc10_ = _loc10_ + ("\n" + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " " + param1.gangwars[_loc6_].minLevel);
                  }
                  _loc10_ = _loc10_ + ("\n" + MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_3") + " " + Number(param1.gangwars[_loc6_].district_id).toString());
                  _loc3_.gotoAndStop(5);
                  _loc3_.properties = param1.gangwars[_loc6_];
                  _loc3_.nounlock.toolTipVO = new TooltipVO(MafiaDungeonAdvancedTooltip.NAME,new MafiaDungeonAdvancedTooltipProperties(param1.gangwars[_loc6_],_loc10_),null,"",BasicCustomCursor.CURSOR_ARROW);
               }
            }
            if(param1.gangwars[_loc6_].playerProgress >= 9)
            {
               _loc3_.gotoAndStop(1);
               _loc3_.properties = param1.gangwars[_loc6_];
               _loc3_.clear.toolTipVO = new TooltipVO(MafiaDungeonAdvancedTooltip.NAME,new MafiaDungeonAdvancedTooltipProperties(param1.gangwars[_loc6_],MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_success")),null,"",BasicCustomCursor.CURSOR_CLICK);
               _loc5_.alpha = 0;
            }
            _loc7_ = Math.random() + 0.5;
            _loc8_ = new GTween(_loc3_,Math.random() * 0.5,{"alpha":1});
            _loc8_.delay = _loc7_;
            _loc8_.ease = Bounce.easeIn;
            if(_loc2_.index != City.Sicily.index)
            {
               _loc11_ = new GTween(_loc4_,Math.random() * 0.5,{"alpha":1});
               _loc11_.delay = _loc7_;
               _loc11_.ease = Bounce.easeIn;
            }
            _loc6_++;
         }
         this._bestDungeonToAttack = this.findBestDungeonToAttack(param1.gangwars);
         if(!this._bestDungeonShown && MafiaModel.userData.profileData.isFirstDungeonUnlocked || param1.gangwarFightWon)
         {
            if(param1.gangwars.length < 2)
            {
               return;
            }
            if(!this._isMapFitToScreen)
            {
               MafiaDungeonMapPositionSetter.firstMapPosition(this.map,this._bestDungeonToAttack,this._mapStepX,this._mapStepY);
               this.tweenSubs(this.map);
            }
            this._bestDungeonShown = true;
            MafiaModel.userData.gangwarData.gangwarFightWon = false;
            _loc3_ = this.map[String("pin" + int(this._bestDungeonToAttack))] as Pin;
            this.mafiaDungeon.mapswitch.cross.visible = true;
            this.mafiaDungeon.mapswitch.cross.y = _loc3_.y / (Constants_Basic.GAME_HEIGHT / (this.mafiaDungeon.mapswitch.arrow.height + 2));
            this.mafiaDungeon.mapswitch.cross.x = _loc3_.x / (Constants_Basic.GAME_WIDTH / (this.mafiaDungeon.mapswitch.arrow.width + 1));
         }
      }
      
      private function findBestDungeonToAttack(param1:Vector.<GangwarVO>) : int
      {
         var _loc2_:int = 1;
         var _loc3_:Vector.<GangwarVO> = param1.concat();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_].playerProgress >= 9)
            {
               _loc3_[_loc4_].nextChallengeLevel = _loc3_[_loc3_.length - 1].nextChallengeLevel;
            }
            _loc4_++;
         }
         _loc3_.sort(this.sortDungeons);
         _loc2_ = _loc3_[0].district_id + 1;
         if(_loc2_ > 0)
         {
            MafiaModel.userData.gangwarData.bestDungeonOpponent = param1[_loc2_ - 1].nextChallengeLevel;
         }
         return _loc2_;
      }
      
      private function sortDungeons(param1:GangwarVO, param2:GangwarVO) : Number
      {
         if(param1.nextChallengeLevel < param2.nextChallengeLevel)
         {
            return -1;
         }
         if(param1.nextChallengeLevel > param2.nextChallengeLevel)
         {
            return 1;
         }
         return 0;
      }
      
      private function fillTravelButton(param1:int) : void
      {
         var _loc2_:TutorialArrow = null;
         if(param1 > 0)
         {
            if(MafiaModel.specialEvent.sicilianEvent.isEventActive && !MafiaModel.specialEvent.sicilianEvent.isEventOver && MafiaModel.specialEvent.sicilianEvent.isMissionPhaseFinished && MafiaModel.userData.gangwarData.city.index < City.Sicily.index && this.mafiaDungeon.mapswitch.special.numChildren == 2 && MafiaModel.specialEvent.sicilianEvent.gangwarEnemiesKilled == 0)
            {
               _loc2_ = new TutorialArrow();
               _loc2_.scaleX = -1;
               _loc2_.x = _loc2_.x + _loc2_.width * 0.5;
               _loc2_.y = _loc2_.y + _loc2_.height * 0.5;
               this.mafiaDungeon.mapswitch.special.addChild(_loc2_);
            }
            this.mafiaDungeon.mapswitch.special.btn_special.bg_orange.visible = true;
            this.mafiaDungeon.mapswitch.special.visible = true;
         }
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         if(param1.target == this.map && !this.map.hasEventListener(MouseEvent.MOUSE_MOVE) && !this._isMapFitToScreen && this._isMapScaleable)
         {
            this.map.addEventListener(MouseEvent.MOUSE_MOVE,this.onMoveMap);
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_DRAG);
            this.map.startDrag(false,null);
         }
      }
      
      private function onMoveMap(param1:MouseEvent) : void
      {
         MafiaDungeonMapPositionSetter.moveMap(this.map);
         this.tweenSubs(this.map);
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         if(param1.target == this.map && !this._isMapFitToScreen && this._isMapScaleable)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_HAND);
            this.onStopDrag();
         }
      }
      
      private function onStopDrag() : void
      {
         this.map.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMoveMap);
         this.map.stopDrag();
         MafiaDungeonMapPositionSetter.moveMap(this.map);
         this.tweenSubs(this.map);
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         if(param1.delta > 0 && this._isMapFitToScreen && this._isMapScaleable)
         {
            this.fitMap(false);
         }
         else if(param1.delta < 0 && !this._isMapFitToScreen && this._isMapScaleable)
         {
            this.fitMap(true);
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      private function fitMap(param1:Boolean) : void
      {
         if(param1)
         {
            MafiaDungeonMapPositionSetter.fitMap(this.map);
            this.mafiaDungeon.mapswitch.visible = false;
            this._isMapFitToScreen = true;
         }
         else
         {
            this.map.x = -this._mapStepX;
            this.map.y = -this._mapStepY;
            this.map.scaleX = this.map.scaleY = 1;
            this.map.fineLines.scaleX = this.map.fineLines.scaleY = 1;
            this.mafiaDungeon.mapswitch.visible = true;
            this._isMapFitToScreen = false;
            this.tweenSubs(this.map);
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Pin = null;
         var _loc3_:GTween = null;
         var _loc4_:QuestAndFightProgress = null;
         var _loc5_:QuestVO = null;
         var _loc6_:GangwarVO = null;
         var _loc7_:Btn_ClearGangwar = null;
         var _loc8_:Btn_FreeGangwar = null;
         var _loc9_:MovieClip = null;
         if(param1.target is TextField)
         {
            return;
         }
         super.onClick(param1);
         if(param1.target.parent is Btn_CityQuestPin)
         {
            _loc4_ = param1.target.parent.quest_and_fight_progress;
            _loc5_ = param1.target.parent.properties;
            _loc6_ = param1.target.parent.gangwar;
            switch(_loc4_)
            {
               case QuestAndFightProgress.AvailableQuest:
                  layoutManager.showDialog(MafiaStartQuestDialog.NAME,new MafiaStartQuestDialogProperties(_loc5_,_loc6_.district_id));
                  break;
               case QuestAndFightProgress.ActiveQuest:
               case QuestAndFightProgress.PausedQuest:
                  layoutManager.showDialog(MafiaProgressQuestDialog.NAME,new MafiaStartQuestDialogProperties(_loc5_,_loc6_.district_id));
                  break;
               case QuestAndFightProgress.FightAvailable:
                  if(_loc6_)
                  {
                     this.hideDistricts();
                     MafiaModel.userData.cityQuestFightData.lastGangwarVO = _loc6_;
                     layoutManager.showScreen(MafiaBonusOpponentQuestScreen.NAME,new MafiaBonusQuestScreenProperties(_loc6_));
                     ShowCityFightCommand.sendCommand(_loc6_.district_id);
                  }
                  break;
               case QuestAndFightProgress.FightVictory:
                  if(_loc6_)
                  {
                     this.hideDistricts();
                     layoutManager.showScreen(MafiaBonusOpponentQuestScreen.NAME,new MafiaBonusQuestScreenProperties(_loc6_));
                     ShowCityFightItemsCommand.sendCommand(_loc6_.district_id);
                  }
                  break;
               case QuestAndFightProgress.RewardTaken:
                  if(_loc6_)
                  {
                     this.hideDistricts();
                     layoutManager.showScreen(MafiaBonusOpponentQuestScreen.NAME,new MafiaBonusQuestScreenProperties(_loc6_));
                     ShowCityFightCommand.sendCommand(_loc6_.district_id);
                  }
            }
         }
         if(param1.target is Btn_ClearGangwar)
         {
            _loc7_ = param1.target as Btn_ClearGangwar;
            _loc2_ = _loc7_.parent as Pin;
            if(!_loc2_.properties)
            {
               return;
            }
            if(_loc2_.properties is GangwarVO)
            {
               this.hideDistricts();
               layoutManager.showScreen(MafiaGangwarTreeScreen.NAME,new MafiaGangwarTreeScreenProperties(_loc2_.properties));
               MafiaModel.userData.gangwarData.currentGangwarID = _loc2_.properties.district_id;
               if(MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
               {
                  ShowCityEventOpponentCommand.sendCommand();
               }
               else
               {
                  SDOCommand.sendCommand(_loc2_.properties.district_id);
               }
            }
         }
         if(param1.target is Btn_FreeGangwar)
         {
            _loc8_ = param1.target as Btn_FreeGangwar;
            _loc2_ = _loc8_.parent as Pin;
            if(!_loc2_.properties)
            {
               return;
            }
            if(_loc2_.properties is GangwarVO)
            {
               this.hideDistricts();
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               layoutManager.showScreen(MafiaGangwarTreeScreen.NAME,new MafiaGangwarTreeScreenProperties(_loc2_.properties));
               MafiaModel.userData.gangwarData.currentGangwarID = _loc2_.properties.district_id;
               if(MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
               {
                  ShowCityEventOpponentCommand.sendCommand();
               }
               else
               {
                  SDOCommand.sendCommand(_loc2_.properties.district_id);
               }
            }
         }
         if(param1.target is Btn_UnlockGangwar)
         {
            _loc9_ = param1.target as MovieClip;
            _loc2_ = _loc9_.parent as Pin;
            if((_loc2_.properties as GangwarVO).unlockable)
            {
               layoutManager.showDialog(MafiaUnlockGangwarDialog.NAME,new MafiaUnlockGangwarDialogProperties(_loc2_.properties,this.unlockDungeon));
            }
         }
         if(!(param1.target as MovieClip).enabled)
         {
            return;
         }
         switch(param1.target)
         {
            case this.mafiaDungeon.mapswitch.btn_up:
               if(this.map.y < 0)
               {
                  _loc3_ = new GTween(this.map,0.5,{"y":Math.min(this.map.y + this._mapStepY,0)});
                  _loc3_.onChange = this.onMapChange;
                  _loc3_.onComplete = this.onMapComplete;
                  this.disableNavigation();
               }
               break;
            case this.mafiaDungeon.mapswitch.btn_down:
               if(this.map.y > (this._mapStepY + this._mapStepY) * -1)
               {
                  _loc3_ = new GTween(this.map,0.5,{"y":Math.max(this.map.y - this._mapStepY,-300)});
                  _loc3_.onChange = this.onMapChange;
                  _loc3_.onComplete = this.onMapComplete;
                  this.disableNavigation();
               }
               break;
            case this.mafiaDungeon.mapswitch.btn_left:
               if(this.map.x < 0)
               {
                  _loc3_ = new GTween(this.map,0.5,{"x":Math.min(this.map.x + this._mapStepX,0)});
                  _loc3_.onChange = this.onMapChange;
                  _loc3_.onComplete = this.onMapComplete;
                  this.disableNavigation();
               }
               break;
            case this.mafiaDungeon.mapswitch.btn_right:
               if(Math.round(this.map.x) > (this._mapStepX + this._mapStepX) * -1)
               {
                  _loc3_ = new GTween(this.map,0.5,{"x":Math.max(this.map.x - this._mapStepX,-400)});
                  _loc3_.onChange = this.onMapChange;
                  _loc3_.onComplete = this.onMapComplete;
                  this.disableNavigation();
               }
               break;
            case this.mafiaDungeon.btn_zoom:
               if(!this._isMapFitToScreen)
               {
                  this.fitMap(true);
               }
               else
               {
                  this.fitMap(false);
               }
               break;
            case this.mafiaDungeon.mapswitch.special.btn_special:
               layoutManager.showPanel(MafiaChooseTravelPanel.NAME);
         }
      }
      
      private function onMapChange(param1:GTween) : void
      {
         this.tweenSubs(param1.target as MovieClip);
      }
      
      private function tweenSubs(param1:MovieClip) : void
      {
         this.map.fineLines.x = 0 + param1.x * -1;
         this.map.fineLines.y = 0 + param1.y * -1 + 5;
         this.mafiaDungeon.mapswitch.arrow.x = 0 + param1.x * -1 / (Constants_Basic.GAME_WIDTH / (this.mafiaDungeon.mapswitch.arrow.width + 11.3));
         this.mafiaDungeon.mapswitch.arrow.y = 0 + param1.y * -1 / (Constants_Basic.GAME_HEIGHT / (this.mafiaDungeon.mapswitch.arrow.height + 4));
      }
      
      private function onMapComplete(param1:GTween) : void
      {
         this.enableNavigation();
      }
      
      private function disableNavigation() : void
      {
         this.mafiaDungeon.mapswitch.btn_up.enableButton = false;
         this.mafiaDungeon.mapswitch.btn_down.enableButton = false;
         this.mafiaDungeon.mapswitch.btn_left.enableButton = false;
         this.mafiaDungeon.mapswitch.btn_right.enableButton = false;
      }
      
      private function enableNavigation() : void
      {
         this.mafiaDungeon.mapswitch.btn_up.enableButton = true;
         this.mafiaDungeon.mapswitch.btn_down.enableButton = true;
         this.mafiaDungeon.mapswitch.btn_left.enableButton = true;
         this.mafiaDungeon.mapswitch.btn_right.enableButton = true;
      }
      
      private function hideDistricts() : void
      {
         var _loc2_:Pin = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         this.mafiaDungeon.mapswitch.visible = false;
         this.mafiaDungeon.btn_zoom.visible = false;
         var _loc1_:uint = 0;
         while(_loc1_ < MafiaModel.userData.gangwarData.gangwars.length)
         {
            _loc2_ = this.map[String("pin" + int(_loc1_ + 1))] as Pin;
            _loc2_.visible = false;
            _loc2_.gotoAndStop(1);
            _loc3_ = this.map[String("area" + int(_loc1_ + 1))] as MovieClip;
            _loc3_.alpha = 0;
            _loc4_ = this.map[String("quest" + int(_loc1_ + 1))] as Btn_CityQuestPin;
            if(_loc4_)
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      private function unlockDungeon(param1:Object = null) : void
      {
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_UNLOCK_NEXT_GANGWAR,[]);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc4_:Pin = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         if(param1.target is TextField)
         {
            return;
         }
         super.onMouseOver(param1);
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:MovieClip = _loc2_.parent as MovieClip;
         if(_loc2_.parent is Btn_CityQuestPin)
         {
            layoutManager.tooltipManager.showAdvancedTooltip(_loc3_.toolTipVO,_loc3_ as DisplayObject);
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            return;
         }
         if(_loc2_.parent is Pin)
         {
            this.onStopDrag();
            _loc4_ = _loc2_.parent as Pin;
            if(!_loc4_.properties)
            {
               return;
            }
            if(_loc4_.properties is GangwarVO)
            {
               if((_loc4_.properties as GangwarVO).unlockable || (_loc4_.properties as GangwarVO).playerProgress >= 0)
               {
                  layoutManager.tooltipManager.showAdvancedTooltip(_loc3_.toolTipVO,_loc3_ as DisplayObject);
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
                  _loc5_ = this.map.getChildByName("area" + _loc4_.name.substr(3)) as MovieClip;
                  _loc6_ = this.map.getChildByName("quest" + _loc4_.name.substr(3)) as MovieClip;
                  if(_loc5_)
                  {
                     _loc5_.alpha = 1;
                     _loc5_.gotoAndStop(2);
                     this.map.setChildIndex(_loc5_,this.map.numChildren - 1);
                  }
                  this.map.setChildIndex(_loc4_,this.map.numChildren - 1);
                  if(_loc6_)
                  {
                     this.map.setChildIndex(_loc6_,this.map.numChildren - 1);
                  }
               }
            }
            return;
         }
         if(param1.target == this.map)
         {
            this.map.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            if(!this._isMapFitToScreen && this._isMapScaleable)
            {
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_HAND);
            }
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:Pin = null;
         var _loc3_:MovieClip = null;
         if(param1.target is TextField)
         {
            return;
         }
         if((param1.target as MovieClip).parent is Btn_CityQuestPin)
         {
            layoutManager.tooltipManager.hideAdvancedTooltip();
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            return;
         }
         if((param1.target as MovieClip).parent is Pin)
         {
            _loc2_ = (param1.target as MovieClip).parent as Pin;
            if(!_loc2_.properties)
            {
               return;
            }
            if(_loc2_.properties is GangwarVO)
            {
               if((_loc2_.properties as GangwarVO).unlockable || (_loc2_.properties as GangwarVO).playerProgress >= 0)
               {
                  _loc3_ = this.map.getChildByName("area" + (param1.target as MovieClip).parent.name.substr(3)) as MovieClip;
                  if(_loc3_)
                  {
                     _loc3_.alpha = 0;
                  }
               }
            }
            layoutManager.tooltipManager.hideAdvancedTooltip();
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
         if(param1.target == this.map)
         {
            this.onStopDrag();
            this.map.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
         super.onMouseOut(param1);
      }
      
      public function get mafiaDungeon() : MafiaGangwar
      {
         return disp as MafiaGangwar;
      }
   }
}
