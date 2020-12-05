package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_Weapon;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.commands.avatar.OUDCommand;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionType;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.hit.PBFightActionHitResult;
   import com.goodgamestudios.mafia.event.model.MafiaFightEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.vo.FighterVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.mafia.vo.fight.FightItemVO;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionEffectVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.gskinner.motion.GTween;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.media.Sound;
   import flash.utils.getDefinitionByName;
   
   public class MafiaBasicFightScreen extends MafiaScreen
   {
       
      
      protected var aniMC:MovieClip;
      
      protected var resultAniMC:MovieClip;
      
      private const FIGHT_WEAPON_SCALE:Number = 1.5;
      
      private const BUFF_Y_DISTANCE:int = 49;
      
      private const BUFF_PADDING:Number = 0.25;
      
      private const EFFECT_FADE_DURATION:Number = 0.3;
      
      private const EFFECT_MOVE_DURATION:Number = 0.3;
      
      private const SKIP_DURATION:Number = 1.0E-5;
      
      private const EFFECT_UPDATE_DURATION:Number = 0.3;
      
      private var HEAL_ITEM_MAX_SIZE:Number = 50;
      
      private var entrySeparators:Vector.<FightResultLine>;
      
      public function MafiaBasicFightScreen(param1:DisplayObject, param2:Boolean = true)
      {
         this.entrySeparators = new Vector.<FightResultLine>();
         super(param1,param2);
      }
      
      protected function onCombatStart(param1:Event) : void
      {
         this.fightScreen.btn_skip.visible = true;
      }
      
      protected function onPlayConsumableAnimation(param1:Event) : void
      {
         this.playActionAnimation(this.fight.currentAction.consume.item);
      }
      
      protected function onPlayWeaponAnimation(param1:Event) : void
      {
         this.playActionAnimation(this.fight.currentAction.hit.weapon);
      }
      
      protected function onUpdateEffects(param1:Event) : void
      {
         this.effectAnimation(MafiaFightResultData.FIGHTER_LEFT);
         this.effectAnimation(MafiaFightResultData.FIGHTER_RIGHT);
      }
      
      protected function get fighterRight() : MovieClip
      {
         return this.fightScreen.fighterRight;
      }
      
      protected function get fighterLeft() : MovieClip
      {
         return this.fightScreen.fighterLeft;
      }
      
      protected function get fight() : MafiaFightResultData
      {
         return (properties as MafiaBasicFightScreenProperties).fightResult;
      }
      
      protected function get reward() : RewardVO
      {
         return (properties as MafiaBasicFightScreenProperties).reward;
      }
      
      protected function get fightScreen() : MovieClip
      {
         return disp as MovieClip;
      }
      
      override public function show() : void
      {
         super.show();
         layoutManager.customCursor.isEnabled = false;
         this.fightScreen.btn_skip.visible = false;
         this.fightScreen.btn_skip.label = MafiaModel.languageData.getTextById("generic_btn_skip");
         if(this.fightScreen.result)
         {
            this.fightScreen.result.visible = false;
         }
         if(this.fightScreen.missionResultTooltip)
         {
            this.fightScreen.missionResultTooltip.visible = false;
         }
         if(this.fightScreen.blankResultTooltip)
         {
            this.fightScreen.blankResultTooltip.visible = false;
         }
         if(this.fightScreen.duelResultTooltip)
         {
            this.fightScreen.duelResultTooltip.visible = false;
         }
         if(this.fightScreen.policeResultTooltip)
         {
            this.fightScreen.policeResultTooltip.visible = false;
         }
         if(this.fightScreen.tournamentResultTooltip)
         {
            this.fightScreen.tournamentResultTooltip.visible = false;
         }
         if(this.fightScreen.tournamentSpectatorResultTooltip)
         {
            this.fightScreen.tournamentSpectatorResultTooltip.visible = false;
         }
         controller.addEventListener(MafiaFightEvent.PLAY_WEAPON_ANIMATION,this.onPlayWeaponAnimation);
         controller.addEventListener(MafiaFightEvent.PLAY_CONSUMABLE_ANIMATION,this.onPlayConsumableAnimation);
         controller.addEventListener(MafiaFightEvent.END_COMBAT,this.onEndOfCombat);
         controller.addEventListener(MafiaFightEvent.START_COMBAT,this.onCombatStart);
         controller.addEventListener(MafiaFightEvent.UPDATE_EFFECTS,this.onUpdateEffects);
         MovieClipHelper.clearMovieClip(this.fightScreen.actionAniHolder);
         this.fightScreen.actionAniHolder.mouseEnabled = false;
         this.fightScreen.actionAniHolder.mouseChildren = false;
         this.fillResultTooltips();
      }
      
      private function fillResultTooltips() : void
      {
         if(this.resultPanel)
         {
            if(this.resultPanel.reward_xp)
            {
               this.resultPanel.reward_xp.mouseChildren = false;
               this.resultPanel.reward_xp.toolTipText = MafiaModel.languageData.getTextById("generic_xp");
            }
            if(this.resultPanel.reward_cash)
            {
               this.resultPanel.reward_cash.mouseChildren = false;
               this.resultPanel.reward_cash.toolTipText = MafiaModel.languageData.getTextById("MafiaPayment_cash");
            }
            if(this.resultPanel.reward_gold)
            {
               this.resultPanel.reward_gold.mouseChildren = false;
               this.resultPanel.reward_gold.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_currency2");
            }
            if(this.resultPanel.reward_honor)
            {
               this.resultPanel.reward_honor.mouseChildren = false;
               this.resultPanel.reward_honor.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_honor");
            }
            if(this.resultPanel.reward_ap)
            {
               this.resultPanel.reward_ap.mouseChildren = false;
               this.resultPanel.reward_ap.toolTipText = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_14");
            }
            if(this.resultPanel.reward_drink)
            {
               this.resultPanel.reward_drink.mouseChildren = false;
               this.resultPanel.reward_drink.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_freeDrink");
            }
            if(this.resultPanel.btn_log)
            {
               this.resultPanel.btn_log.toolTipText = MafiaModel.languageData.getTextById("MafiaCombatLogDialog_title");
            }
         }
      }
      
      private function getMovieClipOfFighter(param1:int) : MovieClip
      {
         if(param1 == MafiaFightResultData.FIGHTER_LEFT)
         {
            return this.fighterLeft;
         }
         return this.fighterRight;
      }
      
      protected function onEndOfCombat(param1:Event) : void
      {
         layoutManager.customCursor.isEnabled = true;
         this.hitPointAnimation(MafiaFightResultData.FIGHTER_RIGHT);
         this.hitPointAnimation(MafiaFightResultData.FIGHTER_LEFT);
         this.clearActionAnimation();
         this.clearResultAnimations();
         this.showFightResult(true);
         this.removeEvents();
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaFightEvent.PLAY_WEAPON_ANIMATION,this.onPlayWeaponAnimation);
         controller.removeEventListener(MafiaFightEvent.PLAY_CONSUMABLE_ANIMATION,this.onPlayConsumableAnimation);
         controller.removeEventListener(MafiaFightEvent.END_COMBAT,this.onEndOfCombat);
         controller.removeEventListener(MafiaFightEvent.START_COMBAT,this.onCombatStart);
         controller.removeEventListener(MafiaFightEvent.UPDATE_EFFECTS,this.onUpdateEffects);
      }
      
      protected function showFightResult(param1:Boolean) : void
      {
         this.fightScreen.btn_skip.visible = false;
         MovieClipHelper.clearMovieClip(this.fighterLeft.smokeAniHolder);
         MovieClipHelper.clearMovieClip(this.fighterRight.smokeAniHolder);
         this.showBloodOnLoser();
         if(this.fight.getWinner() == this.fight.getPlayer())
         {
            this.showWinnerText();
            if(param1)
            {
               controller.soundController.playSoundEffect(MafiaSoundController.SND_WIN_FIGHT);
            }
         }
         else if(this.fight.getLoser() == this.fight.getPlayer())
         {
            this.showLoserText();
            if(param1)
            {
               controller.soundController.playSoundEffect(MafiaSoundController.SND_LOSE_FIGHT);
            }
         }
         else if(MafiaModel.userData.userClan.clanWar)
         {
            if(MafiaModel.userData.profileData.clanID == MafiaModel.userData.userClan.clanWar.winnerClanId)
            {
               this.showWinnerText();
               if(param1)
               {
                  controller.soundController.playSoundEffect(MafiaSoundController.SND_WIN_FIGHT);
               }
            }
            else
            {
               this.showLoserText();
               if(param1)
               {
                  controller.soundController.playSoundEffect(MafiaSoundController.SND_LOSE_FIGHT);
               }
            }
         }
         this.fillResult();
         updateAllTextFields();
      }
      
      protected function fillResult() : void
      {
         var _loc6_:FightResultLine = null;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:MovieClip = null;
         var _loc10_:FightResultLine = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         this.resultPanel.visible = true;
         var _loc1_:Boolean = MafiaModel.userData.profileData.isActivityGainingUnlocked;
         var _loc2_:Array = [this.reward.xp,this.reward.cash,this.reward.gold,this.reward.honor,!!_loc1_?this.reward.ap:0,this.reward.drink,this.reward.item];
         var _loc3_:Array = ["xp","cash","gold","honor","ap","drink","item"];
         var _loc4_:Number = 0;
         while(this.entrySeparators.length > 0)
         {
            _loc6_ = this.entrySeparators.pop();
            this.resultPanel.removeChild(_loc6_);
         }
         var _loc5_:uint = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc7_ = _loc2_[_loc5_];
            _loc8_ = _loc3_[_loc5_];
            _loc9_ = this.resultPanel["reward_" + _loc8_];
            if(_loc7_)
            {
               if(_loc4_ > 0)
               {
                  _loc10_ = new FightResultLine();
                  _loc10_.y = _loc4_;
                  this.resultPanel.addChild(_loc10_);
                  this.entrySeparators.push(_loc10_);
               }
               if(_loc8_ == "item")
               {
                  _loc11_ = _loc9_.getChildByName("itemIcon") as MovieClip;
                  if(_loc11_)
                  {
                     _loc9_.removeChild(_loc11_);
                  }
                  _loc12_ = MafiaItemData.getInstance().generateItemIcon(_loc7_ as ItemVO);
                  _loc9_.addChild(_loc12_);
                  _loc9_.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc7_ as ItemVO,TooltipDispPosition.Right);
                  if(_loc7_.amount > 1)
                  {
                     _loc9_.amount.visible = true;
                     _loc9_.amount.txt_amount.text = _loc7_.amount.toString();
                     _loc9_.addChildAt(_loc9_.amount,_loc9_.numChildren - 1);
                  }
                  else
                  {
                     _loc9_.amount.visible = false;
                  }
               }
               else
               {
                  _loc9_.txt_value.text = NumberStringHelper.groupString(_loc7_,MafiaModel.languageData.getTextById);
               }
               _loc9_.y = _loc9_.y - _loc9_.getRect(this.resultPanel).top + _loc4_;
               _loc4_ = _loc4_ + _loc9_.height;
               _loc9_.visible = true;
            }
            else
            {
               _loc9_.visible = false;
            }
            _loc5_++;
         }
         _loc4_ = _loc4_ + 15;
         if(this.showLogButton)
         {
            this.resultPanel.btn_log.visible = true;
            this.resultPanel.btn_log.y = this.resultPanel.btn_log.y - this.resultPanel.btn_log.getRect(this.resultPanel).top + _loc4_;
            _loc4_ = _loc4_ + (this.resultPanel.btn_log.height + 10);
         }
         else
         {
            this.resultPanel.btn_log.visible = false;
         }
         this.resultPanel.btn_close.label = MafiaModel.languageData.getTextById("generic_btn_okay");
         this.resultPanel.btn_close.y = this.resultPanel.btn_close.y - this.resultPanel.btn_close.getRect(this.resultPanel).top + _loc4_;
         _loc4_ = _loc4_ + (this.resultPanel.btn_close.height + 10);
         this.resultPanel.bg.height = -this.resultPanel.bg.getRect(this.resultPanel).top + _loc4_;
      }
      
      protected function showBloodOnLoser() : void
      {
         var _loc1_:MovieClip = this.getMovieClipOfFighter(this.fight.getLoser());
         _loc1_.bloodone.visible = true;
         _loc1_.bloodtwo.visible = true;
      }
      
      protected function showWinnerText() : void
      {
         this.resultPanel.title.gotoAndStop(1);
         this.resultPanel.title.txt_label.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_5");
      }
      
      protected function showLoserText() : void
      {
         this.resultPanel.title.gotoAndStop(2);
         this.resultPanel.title.txt_label.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_6");
      }
      
      protected function clearFight() : void
      {
         OUDCommand.sendCommand([MafiaModel.userData.playerID]);
         this.clearActionAnimation();
         this.clearResultAnimations();
         this.checkPolice();
      }
      
      protected function checkPolice() : void
      {
         if(MafiaModel.userData.policeData.isEncounter())
         {
            this.policeEncounter();
            layoutManager.state = Constants_LayoutStates.STATE_POLICE_FIGHT;
         }
         else
         {
            this.noPoliceEncounter();
         }
      }
      
      protected function policeEncounter() : void
      {
         throw new Error("Please override me");
      }
      
      protected function noPoliceEncounter() : void
      {
         MafiaDialogHandler.getInstance().blockDialogs = false;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.fightScreen.btn_skip:
               this.clearActionAnimation();
               this.clearResultAnimations();
               controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.SKIP_COMBAT));
         }
      }
      
      protected function fillFighterData(param1:MovieClip, param2:FighterVO) : void
      {
         param1.smokeAniHolder.mouseEnabled = param1.smokeAniHolder.mouseChildren = false;
         param1.resultAniHolder.mouseEnabled = param1.resultAniHolder.mouseChildren = false;
         MovieClipHelper.clearMovieClip(param1.avatarPicField1.holder);
         MovieClipHelper.clearMovieClip(param1.header.classHolder);
         MovieClipHelper.clearMovieClip(param1.effectHolder);
         MovieClipHelper.clearMovieClip(param1.resultAniHolder);
         MovieClipHelper.clearMovieClip(param1.smokeAniHolder);
         param1.avatarPicField1.holder.addChild(param2.typeMC);
         param1.bloodone.visible = false;
         param1.bloodtwo.visible = false;
         this.setHitpoints(param1,param2);
         param1.header.txt_name.text = param2.name;
         param1.header.txt_level.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " " + param2.level;
         param1.header.classHolder.addChild(param2.characterClassMC);
         param1.txt_attack_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack");
         param1.txt_attack_label.cacheAsBitmap = true;
         param1.txt_endurance_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance");
         param1.txt_luck_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck");
         param1.txt_resistance_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough");
         param1.txt_attack_value.text = NumberStringHelper.groupString(param2.attack,MafiaModel.languageData.getTextById);
         param1.txt_endurance_value.text = NumberStringHelper.groupString(param2.endurance,MafiaModel.languageData.getTextById);
         param1.txt_luck_value.text = NumberStringHelper.groupString(param2.luck,MafiaModel.languageData.getTextById);
         param1.txt_resistance_value.text = NumberStringHelper.groupString(param2.toughness,MafiaModel.languageData.getTextById);
      }
      
      protected function setHitpoints(param1:MovieClip, param2:FighterVO) : void
      {
         var _loc3_:Number = Math.max(0,param2.currentHitpoints / param2.totalHitpoints);
         param1.healthBar.line.scaleX = _loc3_;
         param1.txt_health.text = NumberStringHelper.groupString(param2.currentHitpoints,MafiaModel.languageData.getTextById) + "/" + NumberStringHelper.groupString(param2.totalHitpoints,MafiaModel.languageData.getTextById);
      }
      
      public function clearActionAnimation() : void
      {
         MovieClipHelper.clearMovieClip(this.fightScreen.actionAniHolder);
         if(this.aniMC)
         {
            this.aniMC.stop();
            this.aniMC.visible = false;
            this.fightScreen.removeEventListener(Event.ENTER_FRAME,this.onActionAnimation);
            this.aniMC = null;
         }
      }
      
      public function clearResultAnimations() : void
      {
         MovieClipHelper.clearMovieClip(this.fighterRight.resultAniHolder);
         MovieClipHelper.clearMovieClip(this.fighterLeft.resultAniHolder);
         if(this.resultAniMC)
         {
            this.resultAniMC.stop();
            this.resultAniMC.visible = false;
            this.fightScreen.removeEventListener(Event.ENTER_FRAME,this.onResultAnimation);
            this.resultAniMC = null;
         }
      }
      
      public function playActionAnimation(param1:FightItemVO) : void
      {
         var _loc4_:Class = null;
         var _loc5_:Number = NaN;
         var _loc2_:MovieClip = MafiaItemData.getInstance().generateItemPic(param1.type,param1.subtype,param1.id,param1.quality);
         var _loc3_:String = Constants_Weapon.getItemAnimation(param1);
         if(param1.type == ItemType.Weapon && this.fight.currentAction.consume && this.fight.currentAction.consume.heal > 0)
         {
            _loc3_ = null;
         }
         if(!_loc3_)
         {
            this.onActionAnimationFinished();
         }
         else
         {
            _loc4_ = getDefinitionByName(_loc3_) as Class;
            this.clearActionAnimation();
            this.aniMC = new _loc4_();
            this.aniMC.properties = _loc3_;
            _loc5_ = 1;
            if(param1.type == ItemType.Weapon)
            {
               _loc5_ = this.FIGHT_WEAPON_SCALE;
            }
            _loc2_.scaleX = _loc2_.scaleY = _loc5_;
            if(_loc2_.combatPos)
            {
               _loc2_.x = _loc2_.x - _loc5_ * _loc2_.combatPos.x;
               _loc2_.y = _loc2_.y - _loc5_ * _loc2_.combatPos.y;
            }
            _loc2_.filters = [MafiaItemData.getInstance().itemGlowfilter];
            MovieClipHelper.clearMovieClip(this.aniMC.ani.holder);
            this.aniMC.ani.holder.addChild(_loc2_);
            if(this.fight.currentAttacker == MafiaFightResultData.FIGHTER_RIGHT)
            {
               this.aniMC.scaleX = -1;
               this.aniMC.x = Constants_Basic.GAME_WIDTH;
            }
            this.fightScreen.actionAniHolder.addChild(this.aniMC);
            this.fightScreen.addEventListener(Event.ENTER_FRAME,this.onActionAnimation,false,0,true);
         }
      }
      
      protected function onActionAnimation(param1:Event) : void
      {
         var _loc2_:Sound = null;
         if(this.aniMC && this.aniMC.properties)
         {
            if(this.aniMC.currentFrameLabel == Constants_Weapon.FRAMELABEL_SOUND || this.aniMC.currentFrameLabel == Constants_Weapon.FRAMELABEL_SECONDSOUND || this.aniMC.currentFrameLabel == Constants_Weapon.FRAMELABEL_DRAW_WEAPON_SOUND)
            {
               _loc2_ = Constants_Weapon.getWeaponSound(this.aniMC.properties,this.aniMC.currentFrameLabel);
               if(_loc2_)
               {
                  controller.soundController.playSoundEffect(_loc2_);
               }
               else
               {
                  trace("no sound for this frame label");
               }
            }
         }
         if(this.aniMC && this.aniMC.currentFrameLabel == Constants_Weapon.FRAMELABEL_END)
         {
            this.aniMC.stop();
            this.aniMC.visible = false;
            this.onActionAnimationFinished();
         }
      }
      
      protected function onActionAnimationFinished() : void
      {
         this.clearActionAnimation();
         this.playResultAnimation();
         this.hitPointAnimation(this.fight.currentDefender);
         this.hitPointAnimation(this.fight.currentAttacker);
      }
      
      private function playResultAnimation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FightItemVO = null;
         var _loc3_:MovieClip = null;
         this.fightScreen.addEventListener(Event.ENTER_FRAME,this.onResultAnimation,false,0,true);
         switch(this.fight.currentAction.type)
         {
            case PBFightActionType.HIT:
               if(this.fight.currentAction.hit)
               {
                  _loc1_ = this.fight.currentDefender;
                  switch(this.fight.currentAction.hit.result)
                  {
                     case PBFightActionHitResult.HIT:
                        if(this.fight.currentAction.hit.secondDamage > 0)
                        {
                           this.resultAniMC = new (getDefinitionByName("DoubleDamageResultAnimation") as Class)() as MovieClip;
                           if(this.fight.currentAction.hit.isCritical)
                           {
                              this.resultAniMC.normalDamage.visible = false;
                              this.resultAniMC.criticalDamage.visible = true;
                              this.resultAniMC.criticalDamage.textHolder.txt_result.text = "-" + NumberStringHelper.groupString(this.fight.currentAction.hit.firstDamage,MafiaModel.languageData.getTextById);
                           }
                           else
                           {
                              this.resultAniMC.criticalDamage.visible = false;
                              this.resultAniMC.normalDamage.visible = true;
                              this.resultAniMC.normalDamage.textHolder.txt_result.text = "-" + NumberStringHelper.groupString(this.fight.currentAction.hit.firstDamage,MafiaModel.languageData.getTextById);
                           }
                           this.resultAniMC.textHolder.txt_result.text = "-" + NumberStringHelper.groupString(this.fight.currentAction.hit.secondDamage,MafiaModel.languageData.getTextById);
                        }
                        else
                        {
                           if(this.fight.currentAction.hit.isCritical)
                           {
                              this.resultAniMC = new (getDefinitionByName("CriticalDamageResultAnimation") as Class)() as MovieClip;
                           }
                           else
                           {
                              this.resultAniMC = new (getDefinitionByName("DamageResultAnimation") as Class)() as MovieClip;
                           }
                           this.resultAniMC.textHolder.txt_result.text = "-" + NumberStringHelper.groupString(this.fight.currentAction.hit.firstDamage,MafiaModel.languageData.getTextById);
                        }
                        break;
                     case PBFightActionHitResult.EVADED:
                        this.resultAniMC = new (getDefinitionByName("DodgeResultAnimation") as Class)() as MovieClip;
                        this.resultAniMC.textHolder.txt_result.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dodge");
                        break;
                     case PBFightActionHitResult.MISSED:
                        this.resultAniMC = new (getDefinitionByName("MissedResultAnimation") as Class)() as MovieClip;
                        this.resultAniMC.textHolder.txt_result.text = MafiaModel.languageData.getTextById("MafiaFightScreen_text_miss");
                        break;
                     default:
                        trace("ERROR: Unknown hit result");
                  }
               }
               break;
            case PBFightActionType.CONSUME:
               if(this.fight.currentAction.consume.heal > 0)
               {
                  _loc1_ = this.fight.currentAttacker;
                  this.resultAniMC = new (getDefinitionByName("HealResultAnimation") as Class)() as MovieClip;
                  this.resultAniMC.textHolder.txt_result.text = "+" + NumberStringHelper.groupString(this.fight.currentAction.consume.heal,MafiaModel.languageData.getTextById);
                  _loc2_ = this.fight.currentAction.consume.item;
                  _loc3_ = MafiaItemData.getInstance().generateItemPic(_loc2_.type,_loc2_.subtype,_loc2_.id,_loc2_.quality);
                  _loc3_.filters = [MafiaItemData.getInstance().itemGlowfilter];
                  MovieClipHelper.scaleDownToFit(_loc3_,this.HEAL_ITEM_MAX_SIZE,this.HEAL_ITEM_MAX_SIZE);
                  MovieClipHelper.clearMovieClip(this.resultAniMC.itemHolder);
                  this.resultAniMC.itemHolder.addChild(_loc3_);
               }
               else if(this.fight.currentAction.consume.damage > 0)
               {
                  _loc1_ = this.fight.currentDefender;
                  this.resultAniMC = new (getDefinitionByName("DamageResultAnimation") as Class)() as MovieClip;
                  this.resultAniMC.textHolder.txt_result.text = "-" + NumberStringHelper.groupString(this.fight.currentAction.consume.damage,MafiaModel.languageData.getTextById);
               }
               else if(this.fight.currentAction.consume.item.id == Constants_Weapon.CONSUME_ADRENALINE)
               {
                  _loc1_ = this.fight.currentAttacker;
                  this.resultAniMC = new (getDefinitionByName("NoResultAnimation") as Class)() as MovieClip;
                  _loc2_ = this.fight.currentAction.consume.item;
                  _loc3_ = MafiaItemData.getInstance().generateItemPic(_loc2_.type,_loc2_.subtype,_loc2_.id,_loc2_.quality);
                  _loc3_.filters = [MafiaItemData.getInstance().itemGlowfilter];
                  MovieClipHelper.clearMovieClip(this.resultAniMC.itemHolder);
                  this.resultAniMC.itemHolder.addChild(_loc3_);
               }
               break;
            default:
               trace("ERROR: Unknown fight action type");
         }
         if(this.resultAniMC)
         {
            if(_loc1_ == MafiaFightResultData.FIGHTER_RIGHT)
            {
               this.fighterRight.resultAniHolder.addChild(this.resultAniMC);
            }
            else
            {
               this.fighterLeft.resultAniHolder.addChild(this.resultAniMC);
            }
            if(this.resultAniMC.textHolder)
            {
               updateTextField(this.resultAniMC.textHolder.txt_result);
            }
         }
         else
         {
            controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.RESULT_ANIMATION_FINISHED));
         }
      }
      
      private function effectAnimation(param1:int) : void
      {
         var _loc4_:FightActionEffectVO = null;
         var _loc2_:MovieClip = this.getMovieClipOfFighter(param1);
         var _loc3_:FighterVO = this.fight.getFighter(param1);
         if(_loc3_.effects)
         {
            for each(_loc4_ in _loc3_.effects)
            {
               if(_loc4_.item && _loc4_.item.id == Constants_Weapon.CONSUME_SMOKE_GRENADE)
               {
                  if(_loc4_.durationLeft == _loc4_.duration)
                  {
                     this.playSmokeEffectAnimation(_loc4_);
                  }
               }
            }
            this.effectUpdateTimePhase(param1,_loc2_,_loc3_);
         }
         else
         {
            controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.EFFECT_ANIMATION_FINISHED,[param1]));
         }
      }
      
      private function effectUpdateTimePhase(param1:int, param2:MovieClip, param3:FighterVO) : void
      {
         var _loc4_:Boolean = true;
         var _loc5_:int = 0;
         while(_loc5_ < param3.effectsLastRound.length)
         {
            this.effectUpdateTime(param1,param2,param3,param3.effectsLastRound[_loc5_],_loc5_,_loc4_);
            _loc4_ = false;
            _loc5_++;
         }
         if(_loc4_)
         {
            this.effectFadeoutPhase(param1,param2,param3);
         }
      }
      
      private function effectUpdateTime(param1:int, param2:MovieClip, param3:FighterVO, param4:FightActionEffectVO, param5:int, param6:Boolean) : void
      {
         var myTween:GTween = null;
         var side:int = param1;
         var fighterMC:MovieClip = param2;
         var fighterData:FighterVO = param3;
         var effect:FightActionEffectVO = param4;
         var position:int = param5;
         var isFirstCall:Boolean = param6;
         var duration:Number = !!this.fight.skip?Number(this.SKIP_DURATION):Number(this.EFFECT_UPDATE_DURATION);
         myTween = new GTween(effect.buffMC.effectMask,duration,{"y":this.effectCalcMaskY(effect)});
         myTween.onComplete = function():void
         {
            if(isFirstCall)
            {
               effectFadeoutPhase(side,fighterMC,fighterData);
            }
         };
      }
      
      private function effectFadeoutPhase(param1:int, param2:MovieClip, param3:FighterVO) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = true;
         _loc5_ = 0;
         while(_loc5_ < param3.effectsLastRound.length)
         {
            _loc4_ = param3.effects.lastIndexOf(param3.effectsLastRound[_loc5_]);
            if(_loc4_ == -1)
            {
               this.effectFadeout(param1,param3.effectsLastRound[_loc5_],param2,param3,_loc6_);
               _loc6_ = false;
            }
            _loc5_++;
         }
         if(_loc6_)
         {
            this.effectMovePhase(param1,param2,param3);
         }
      }
      
      private function effectFadeout(param1:int, param2:FightActionEffectVO, param3:MovieClip, param4:FighterVO, param5:Boolean) : void
      {
         var myTween:GTween = null;
         var side:int = param1;
         var effect:FightActionEffectVO = param2;
         var fighterMC:MovieClip = param3;
         var fighterData:FighterVO = param4;
         var isFirstCall:Boolean = param5;
         var duration:Number = !!this.fight.skip?Number(this.SKIP_DURATION):Number(this.EFFECT_FADE_DURATION);
         myTween = new GTween(effect.buffMC,duration,{"x":this.effectCalcX(false,effect.target)});
         myTween.onComplete = function():void
         {
            if(fighterMC.effectHolder.contains(effect.buffMC))
            {
               fighterMC.effectHolder.removeChild(effect.buffMC);
               if(effect.item && effect.item.id == Constants_Weapon.CONSUME_SMOKE_GRENADE)
               {
                  MovieClipHelper.clearMovieClip(fighterMC.smokeAniHolder);
               }
               if(isFirstCall)
               {
                  effectMovePhase(side,fighterMC,fighterData);
               }
            }
            else
            {
               trace("remove effect error");
            }
         };
      }
      
      private function effectMovePhase(param1:int, param2:MovieClip, param3:FighterVO) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Boolean = true;
         var _loc5_:int = 0;
         while(_loc5_ < param3.effects.length)
         {
            _loc6_ = param3.effectsLastRound.lastIndexOf(param3.effects[_loc5_]);
            if(_loc6_ != -1)
            {
               this.effectMove(param1,param2,param3,param3.effects[_loc5_],_loc5_,_loc4_);
               _loc4_ = false;
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            this.effectFadeInPhase(param1,param2,param3);
         }
      }
      
      private function effectMove(param1:int, param2:MovieClip, param3:FighterVO, param4:FightActionEffectVO, param5:int, param6:Boolean) : void
      {
         var myTween:GTween = null;
         var side:int = param1;
         var fighterMC:MovieClip = param2;
         var fighterData:FighterVO = param3;
         var effect:FightActionEffectVO = param4;
         var position:int = param5;
         var isFirstCall:Boolean = param6;
         var duration:Number = !!this.fight.skip?Number(this.SKIP_DURATION):Number(this.EFFECT_MOVE_DURATION);
         myTween = new GTween(effect.buffMC,duration,{"y":this.effectCalcY(position)});
         myTween.onComplete = function():void
         {
            if(isFirstCall)
            {
               effectFadeInPhase(side,fighterMC,fighterData);
            }
         };
      }
      
      private function effectFadeInPhase(param1:int, param2:MovieClip, param3:FighterVO) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Boolean = true;
         var _loc5_:int = 0;
         while(_loc5_ < param3.effects.length)
         {
            _loc6_ = param3.effectsLastRound.lastIndexOf(param3.effects[_loc5_]);
            if(_loc6_ == -1)
            {
               this.effectFadeIn(param1,param2,param3,param3.effects[_loc5_],_loc5_,_loc4_);
               _loc4_ = false;
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.EFFECT_ANIMATION_FINISHED,[param1]));
         }
      }
      
      private function effectFadeIn(param1:int, param2:MovieClip, param3:FighterVO, param4:FightActionEffectVO, param5:int, param6:Boolean) : void
      {
         var duration:Number = NaN;
         var myTween:GTween = null;
         var itemMC:MovieClip = null;
         var scale:Number = NaN;
         var rageIcon:Icon_enrage_buff = null;
         var scaleRageIcon:Number = NaN;
         var side:int = param1;
         var mc:MovieClip = param2;
         var fighterData:FighterVO = param3;
         var effect:FightActionEffectVO = param4;
         var position:int = param5;
         var isFirstCall:Boolean = param6;
         if(!effect.buffMC)
         {
            effect.buffMC = new (getDefinitionByName(effect.buffType) as Class)() as MovieClip;
            if(effect.target == MafiaFightResultData.FIGHTER_RIGHT)
            {
               effect.buffMC.scaleX = -1;
            }
            effect.buffMC.x = this.effectCalcX(false,effect.target);
            if(effect.item)
            {
               itemMC = MafiaItemData.getInstance().generateItemPic(effect.item.type,effect.item.subtype,effect.item.id,effect.item.quality);
               scale = Math.min(effect.buffMC.height / itemMC.height,effect.buffMC.height / itemMC.width) - this.BUFF_PADDING;
               itemMC.scaleX = itemMC.scaleY = scale;
               effect.buffMC.itemHolder.addChild(itemMC);
            }
            else if(effect.id == 37)
            {
               rageIcon = new Icon_enrage_buff();
               scaleRageIcon = Math.min(effect.buffMC.height / rageIcon.height,effect.buffMC.height / rageIcon.width) - this.BUFF_PADDING;
               rageIcon.scaleX = rageIcon.scaleY = scaleRageIcon;
               effect.buffMC.itemHolder.addChild(rageIcon);
            }
            else
            {
               trace("Error: No item found for this effect");
            }
            effect.buffMC.mouseChildren = false;
            effect.buffMC.toolTipText = effect.description;
            mc.effectHolder.addChild(effect.buffMC);
            duration = !!this.fight.skip?Number(this.SKIP_DURATION):Number(this.EFFECT_FADE_DURATION);
            myTween = new GTween(effect.buffMC,duration,{"x":this.effectCalcX(true,effect.target)});
            effect.buffMC.y = this.effectCalcY(position);
            effect.buffMC.effectMask.y = this.effectCalcMaskY(effect);
            myTween.onComplete = function():void
            {
               if(isFirstCall)
               {
                  controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.EFFECT_ANIMATION_FINISHED,[side]));
               }
            };
         }
         else
         {
            trace("fade in error!");
         }
      }
      
      private function effectCalcX(param1:Boolean, param2:int) : Number
      {
         if(param1)
         {
            return param2 == MafiaFightResultData.FIGHTER_LEFT?Number(24):Number(-24);
         }
         return param2 == MafiaFightResultData.FIGHTER_LEFT?Number(-24):Number(24);
      }
      
      private function effectCalcY(param1:int) : Number
      {
         return param1 * this.BUFF_Y_DISTANCE + 22.5;
      }
      
      private function effectCalcMaskY(param1:FightActionEffectVO) : Number
      {
         var _loc2_:Number = 1 - (param1.durationLeft + param1.durationLeft % 2) / param1.duration;
         var _loc3_:Number = param1.buffMC.effectMask.height * _loc2_ - param1.buffMC.effectMask.height / 2;
         return _loc3_;
      }
      
      private function playSmokeEffectAnimation(param1:FightActionEffectVO) : void
      {
         var _loc2_:MovieClip = MafiaItemData.getInstance().generateItemPic(param1.item.type,param1.item.subtype,param1.item.id,param1.item.quality);
         _loc2_.filters = [MafiaItemData.getInstance().itemGlowfilter];
         var _loc3_:MovieClip = this.getMovieClipOfFighter(param1.target);
         MovieClipHelper.clearMovieClip(_loc3_.smokeAniHolder);
         var _loc4_:MovieClip = new (getDefinitionByName("SmokeEffectAnimation") as Class)() as MovieClip;
         _loc4_.ani.holder.addChild(_loc2_);
         if(param1.target == MafiaFightResultData.FIGHTER_LEFT)
         {
            _loc4_.scaleX = -1;
            _loc4_.x = Constants_Basic.GAME_WIDTH;
         }
         else
         {
            _loc4_.x = -Constants_Basic.GAME_WIDTH;
         }
         _loc3_.smokeAniHolder.addChild(_loc4_);
      }
      
      protected function onResultAnimation(param1:Event) : void
      {
         if(this.resultAniMC && this.resultAniMC.currentFrameLabel == Constants_Weapon.FRAMELABEL_END)
         {
            this.clearResultAnimations();
            controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.RESULT_ANIMATION_FINISHED));
         }
      }
      
      protected function hitPointAnimation(param1:int) : void
      {
         var fighterMC:MovieClip = null;
         var myTween:GTween = null;
         var tmpChar:String = null;
         var fighter:int = param1;
         fighterMC = this.getMovieClipOfFighter(fighter);
         var newScaleX:Number = Math.max(0,this.fight.getFighterCurrentHP(fighter) / this.fight.getFighterTotalHP(fighter));
         var oldString:String = fighterMC.txt_health.text;
         var hpString:String = "";
         var exitLoop:Boolean = false;
         var i:int = 0;
         while(i < oldString.length)
         {
            tmpChar = oldString.charAt(i);
            switch(tmpChar)
            {
               case "-":
               case "0":
               case "1":
               case "2":
               case "3":
               case "4":
               case "5":
               case "6":
               case "7":
               case "8":
               case "9":
                  hpString = hpString + tmpChar;
                  break;
               case "/":
                  exitLoop = true;
            }
            if(exitLoop)
            {
               break;
            }
            i++;
         }
         var oldHP:int = int(hpString);
         var newHP:int = this.fight.getFighterCurrentHP(fighter);
         fighterMC.healthBar.line.healthpoints = oldHP;
         myTween = new GTween(fighterMC.healthBar.line,0.4,{
            "scaleX":newScaleX,
            "healthpoints":newHP
         });
         myTween.onChange = function():void
         {
            var _loc1_:int = fighterMC.healthBar.line.healthpoints;
            fighterMC.txt_health.text = NumberStringHelper.groupString(_loc1_,MafiaModel.languageData.getTextById) + "/" + NumberStringHelper.groupString(fight.getFighterTotalHP(fighter),MafiaModel.languageData.getTextById);
         };
         if(!this.fight.skip)
         {
            myTween.onComplete = function():void
            {
               controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.HEALTH_BAR_ANIMATION_FINISHED));
            };
         }
      }
      
      protected function get resultPanel() : MovieClip
      {
         return this.fightScreen.result;
      }
      
      protected function get showLogButton() : Boolean
      {
         return false;
      }
   }
}
