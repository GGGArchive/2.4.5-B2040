package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.duel.SurvivalStatusCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.event.model.MafiaFightEvent;
   import com.goodgamestudios.mafia.event.model.MafiaSurvivalEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaSurvivalResultData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSurvivalFightLostWonDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaSurvivalFightLostWonDialogProperties;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   import com.goodgamestudios.mafia.vo.FighterVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.gskinner.motion.GTween;
   import com.gskinner.motion.easing.Back;
   import com.gskinner.motion.easing.Sine;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   
   public class MafiaSurvivalFightScreen extends MafiaBasicFightScreen
   {
      
      public static const NAME:String = "MafiaHellFightScreen";
       
      
      private var elementFilters:DropShadowFilter;
      
      private var result:MafiaBasicFightScreenProperties;
      
      public function MafiaSurvivalFightScreen(param1:DisplayObject)
      {
         this.elementFilters = new DropShadowFilter(4,-45,0,0.5,6,6,1,2);
         super(param1);
      }
      
      override protected function onCombatStart(param1:Event) : void
      {
         this.fillOpponents();
         super.fillFighterData(fighterLeft,this.fight.fighterLeft);
         super.onCombatStart(param1);
      }
      
      override protected function onEndOfCombat(param1:Event) : void
      {
         var _loc2_:RightFightAttendantExtended = null;
         var _loc3_:GTween = null;
         hitPointAnimation(MafiaFightResultData.FIGHTER_RIGHT);
         hitPointAnimation(MafiaFightResultData.FIGHTER_LEFT);
         clearActionAnimation();
         clearResultAnimations();
         if(this.survivalData.fights.length == 0)
         {
            layoutManager.customCursor.isEnabled = true;
            showFightResult(true);
         }
         else
         {
            _loc2_ = this.fightScreen.enemyHolder.getChildAt(this.fightScreen.enemyHolder.numChildren - 1) as RightFightAttendantExtended;
            _loc3_ = new GTween(_loc2_,0.2,{"rotation":-15});
            _loc3_.onComplete = this.onRightElementRotateComplete;
            this.fightScreen.btn_skip.visible = false;
         }
      }
      
      override public function show() : void
      {
         controller.addEventListener(MafiaFightEvent.START_MULTIFIGHT,this.onStartSurvival);
         controller.addEventListener(MafiaFightEvent.END_MULTIFIGHT,this.onSurvivalEnd);
         MafiaModel.userData.duelData.survivalData.survivalResetTime = 0;
         MafiaDialogHandler.getInstance().blockDialogs = true;
         fighterLeft.bloodone.visible = false;
         fighterLeft.bloodtwo.visible = false;
         this.fightScreen.numberGirl.visible = false;
         this.fightScreen.ringGirlBG.visible = false;
         this.fightScreen.btn_skip.visible = false;
         MovieClipHelper.clearMovieClip(this.fightScreen.enemyHolder);
         this.fightScreen.btn_skip.label = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_20");
         super.show();
      }
      
      protected function onSurvivalEnd(param1:Event) : void
      {
         layoutManager.customCursor.isEnabled = true;
         showFightResult(true);
         this.removeEvents();
      }
      
      protected function onStartSurvival(param1:Event) : void
      {
         fillFighterData(fighterLeft,MafiaModel.userData.duelData.survivalData.preCombatProfile);
         this.fillOpponents();
         this.tweenGirl();
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_FIGHT;
      }
      
      override protected function applyProperties() : void
      {
         this.fightScreen.btn_skip.visible = true;
      }
      
      private function fillOpponents() : void
      {
         var _loc3_:RightFightAttendantExtended = null;
         var _loc4_:FighterVO = null;
         var _loc1_:int = 0;
         MovieClipHelper.clearMovieClip(this.fightScreen.enemyHolder);
         var _loc2_:int = 0;
         while(_loc2_ < this.survivalData.enemiesLeft)
         {
            _loc3_ = new RightFightAttendantExtended();
            _loc3_.header.gotoAndStop(this.getHeaderFrame(this.survivalData.getEnemyTypeByIndex(this.survivalData.round + _loc2_)));
            _loc3_.header.txt_name.text = "#" + (_loc2_ + 1 + MafiaModel.userData.duelData.survivalData.survivalProgress);
            _loc3_.bloodone.visible = false;
            _loc3_.bloodtwo.visible = false;
            if(_loc2_ < this.survivalData.fightersRight.length)
            {
               _loc4_ = this.survivalData.fightersRight[_loc2_];
               _loc3_.header.classHolder.addChild(_loc4_.characterClassMC);
               _loc3_.avatarPicField1.holder.addChild(_loc4_.typeMC);
               _loc3_.header.txt_level.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " " + String(_loc4_.level);
               _loc3_.txt_health.text = NumberStringHelper.groupString(_loc4_.currentHitpoints,MafiaModel.languageData.getTextById) + "/" + NumberStringHelper.groupString(_loc4_.totalHitpoints,MafiaModel.languageData.getTextById);
               _loc3_.txt_attack_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack");
               _loc3_.txt_endurance_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance");
               _loc3_.txt_luck_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck");
               _loc3_.txt_resistance_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough");
               _loc3_.txt_attack_value.text = NumberStringHelper.groupString(_loc4_.attack,MafiaModel.languageData.getTextById);
               _loc3_.txt_endurance_value.text = NumberStringHelper.groupString(_loc4_.endurance,MafiaModel.languageData.getTextById);
               _loc3_.txt_luck_value.text = NumberStringHelper.groupString(_loc4_.luck,MafiaModel.languageData.getTextById);
               _loc3_.txt_resistance_value.text = NumberStringHelper.groupString(_loc4_.toughness,MafiaModel.languageData.getTextById);
               if(_loc1_ == 0)
               {
                  _loc4_.characterClassMC.visible = true;
                  _loc3_.header.txt_name.text = "#" + (_loc2_ + 1 + MafiaModel.userData.duelData.survivalData.survivalProgress) + " " + _loc4_.name;
               }
            }
            _loc3_.filters = [this.elementFilters];
            _loc3_.y = 0 - _loc1_;
            _loc1_ = _loc1_ + (28 - this.fightScreen.enemyHolder.numChildren * 4);
            _loc3_.scaleX = _loc3_.scaleY = 1 - this.fightScreen.enemyHolder.numChildren / 8;
            this.fightScreen.enemyHolder.addChildAt(_loc3_,0);
            updateAllTextFields(_loc3_);
            _loc2_++;
         }
      }
      
      private function getHeaderFrame(param1:int) : Object
      {
         switch(param1)
         {
            case MafiaSurvivalResultData.ENEMY_NORMAL:
               return 1;
            case MafiaSurvivalResultData.ENEMY_ROUND_BOSS:
               return 2;
            case MafiaSurvivalResultData.ENEMY_LAST_BOSS:
               return 3;
            default:
               return MafiaSurvivalResultData.ENEMY_NORMAL;
         }
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaFightEvent.START_MULTIFIGHT,this.onStartSurvival);
         controller.removeEventListener(MafiaFightEvent.END_MULTIFIGHT,this.onSurvivalEnd);
         super.removeEvents();
      }
      
      private function tweenGirl() : void
      {
         var _loc1_:GTween = null;
         this.fightScreen.btn_skip.visible = false;
         this.fightScreen.numberGirl.visible = true;
         this.fightScreen.ringGirlBG.visible = true;
         this.fightScreen.ringGirlBG.alpha = 0.4;
         this.fightScreen.numberGirl.count.gotoAndStop(Math.floor(MafiaModel.userData.duelData.survivalData.survivalProgress / 5) + 1);
         this.fightScreen.numberGirl.x = 920;
         this.fightScreen.numberGirl.cacheAsBitmap = true;
         _loc1_ = new GTween(this.fightScreen.numberGirl,0.7,{"x":400});
         _loc1_.ease = Back.easeOut;
         _loc1_.onComplete = this.onFirstTweenGirlComplete;
         _loc1_.onChange = this.onFirstTweenGirlChange;
      }
      
      private function onFirstTweenGirlChange(param1:GTween) : void
      {
         if(param1.position < 0.5)
         {
            (param1.target as MovieClip).alpha = param1.position * 4;
         }
         else
         {
            (param1.target as MovieClip).alpha = 1;
         }
      }
      
      private function onFirstTweenGirlComplete(param1:GTween) : void
      {
         param1 = new GTween(param1.target,0.7,{"x":-120});
         param1.ease = Back.easeIn;
         param1.delay = 1;
         param1.onComplete = this.onSecondTweenGirlComplete;
         param1.onInit = this.onSecondTweenGirlInit;
      }
      
      private function onSecondTweenGirlInit(param1:GTween) : void
      {
         new GTween(this.fightScreen.ringGirlBG,0.7,{"alpha":0});
      }
      
      private function onSecondTweenGirlComplete(param1:GTween) : void
      {
         this.fightScreen.ringGirlBG.visible = false;
         this.fightScreen.btn_skip.visible = true;
         controller.dispatchEvent(new MafiaSurvivalEvent(MafiaSurvivalEvent.BEGIN_OF_SURVIVAL_ANIMATION_FINISHED));
      }
      
      private function onRightElementRotateComplete(param1:GTween) : void
      {
         param1 = new GTween(param1.target,0.5,{"y":600});
         param1.ease = Sine.easeIn;
         param1.onComplete = this.onRightElementFallComplete;
      }
      
      private function onRightElementFallComplete(param1:GTween) : void
      {
         this.fightScreen.btn_skip.visible = true;
         controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.END_OF_COMBAT_ANIMATION_FINISHED));
      }
      
      override protected function showBloodOnLoser() : void
      {
         var _loc1_:RightFightAttendantExtended = null;
         if(this.fight.getLoser() == MafiaFightResultData.FIGHTER_RIGHT)
         {
            _loc1_ = this.fightScreen.enemyHolder.getChildAt(this.fightScreen.enemyHolder.numChildren - 1) as RightFightAttendantExtended;
            _loc1_.healthBar.line.scaleX = 0;
            _loc1_.bloodone.visible = true;
            _loc1_.bloodtwo.visible = true;
         }
         else
         {
            super.showBloodOnLoser();
         }
      }
      
      override protected function policeEncounter() : void
      {
         MafiaModel.userData.duelData.survivalData.wonAgainstBoss = true;
         MafiaDialogHandler.getInstance().registerDialogs(MafiaSurvivalFightLostWonDialog.NAME,new MafiaSurvivalFightLostWonDialogProperties(true),true,BasicDialogHandler.PRIORITY_HIGH);
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[0]);
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_SURVIVAL_COOLDOWN,[]);
      }
      
      override protected function noPoliceEncounter() : void
      {
         if(MafiaModel.userData.duelData.survivalData.survivalProgress == MafiaSurvivalResultData.MAX_ENEMIES && this.fight.isLeftFighterWinner)
         {
            MafiaModel.userData.duelData.survivalData.wonAgainstBoss = true;
            MafiaDialogHandler.getInstance().registerDialogs(MafiaSurvivalFightLostWonDialog.NAME,new MafiaSurvivalFightLostWonDialogProperties(true),true,BasicDialogHandler.PRIORITY_HIGH);
            layoutManager.state = Constants_LayoutStates.STATE_DUEL;
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[0]);
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_SURVIVAL_COOLDOWN,[]);
         }
         else
         {
            layoutManager.state = Constants_LayoutStates.STATE_SURVIVAL;
            SurvivalStatusCommand.sendCommand();
         }
         super.noPoliceEncounter();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case resultPanel.btn_close:
               PlayerProfileCommand.sendCommand(MafiaModel.userData.playerID,true);
               clearFight();
               break;
            default:
               super.onClick(param1);
         }
      }
      
      override protected function get fighterRight() : MovieClip
      {
         return this.fightScreen.enemyHolder.getChildAt(this.fightScreen.enemyHolder.numChildren - 1) as MovieClip;
      }
      
      private function get survivalData() : MafiaSurvivalResultData
      {
         return MafiaModel.userData.duelData.survivalData;
      }
      
      override protected function get fight() : MafiaFightResultData
      {
         return MafiaModel.userData.duelData.survivalData.currentFight;
      }
      
      override protected function get fightScreen() : MovieClip
      {
         return disp as MafiaSurvivalFight;
      }
      
      override protected function get reward() : RewardVO
      {
         return MafiaModel.userData.duelData.survivalData.reward;
      }
   }
}
