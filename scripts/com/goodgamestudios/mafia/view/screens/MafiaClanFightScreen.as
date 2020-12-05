package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.controller.MafiaMultiFightController;
   import com.goodgamestudios.mafia.controller.commands.clan.ShowClanCommand;
   import com.goodgamestudios.mafia.event.model.MafiaClanEvent;
   import com.goodgamestudios.mafia.event.model.MafiaEvent;
   import com.goodgamestudios.mafia.event.model.MafiaFightEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.MafiaClanWarData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaMultiFightScreenProperties;
   import com.goodgamestudios.mafia.vo.FighterVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.gskinner.motion.GTween;
   import com.gskinner.motion.easing.Sine;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   
   public class MafiaClanFightScreen extends MafiaBasicFightScreen
   {
      
      public static const NAME:String = "MafiaMultiFightScreen";
       
      
      private var war:MafiaClanWarData;
      
      private var elementFilters:DropShadowFilter;
      
      public function MafiaClanFightScreen(param1:DisplayObject)
      {
         this.elementFilters = new DropShadowFilter(4,-45,0,0.5,6,6,1,2);
         super(param1);
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_MULTIFIGHT;
      }
      
      override public function show() : void
      {
         controller.addEventListener(MafiaClanEvent.CHANGE_CLANWARDATA,this.onClanWarData);
         controller.addEventListener(MafiaFightEvent.START_MULTIFIGHT,this.onMultiFightStart);
         controller.addEventListener(MafiaFightEvent.END_MULTIFIGHT,this.onMultiFightEnd);
         MafiaDialogHandler.getInstance().blockDialogs = true;
         this.multiFightScreen.btn_skip.visible = false;
         this.multiFightScreen.btn_skip.label = MafiaModel.languageData.getTextById("generic_btn_skip");
         MovieClipHelper.clearMovieClip(this.multiFightScreen.leftFightHolder);
         MovieClipHelper.clearMovieClip(this.multiFightScreen.rightFightHolder);
         layoutManager.hideAllDialogs();
         super.show();
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaClanEvent.CHANGE_CLANWARDATA,this.onClanWarData);
         controller.removeEventListener(MafiaFightEvent.START_MULTIFIGHT,this.onMultiFightStart);
         controller.removeEventListener(MafiaFightEvent.END_MULTIFIGHT,this.onMultiFightEnd);
         super.removeEvents();
      }
      
      private function onClanWarData(param1:MafiaEvent) : void
      {
         MafiaMultiFightController.getInstance().startMultiFight(MafiaModel.userData.userClan.clanWar,FightType.ClanWar);
      }
      
      protected function onMultiFightStart(param1:MafiaEvent) : void
      {
         this.war = MafiaModel.userData.userClan.clanWar;
      }
      
      protected function onMultiFightEnd(param1:MafiaEvent) : void
      {
         layoutManager.customCursor.isEnabled = true;
         showFightResult(true);
      }
      
      override protected function onCombatStart(param1:Event) : void
      {
         this.fillFightersLeft();
         this.fillFightersRight();
         super.onCombatStart(param1);
      }
      
      override protected function onEndOfCombat(param1:Event) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:GTween = null;
         hitPointAnimation(MafiaFightResultData.FIGHTER_RIGHT);
         hitPointAnimation(MafiaFightResultData.FIGHTER_LEFT);
         var _loc2_:Boolean = this.war.fights.length > 0?this.war.fights[0].fighterLeft.id == MafiaModel.userData.playerID:false;
         if(this.war.fights.length == 0 || (this.war.currentFight.skip || this.war.skip) && !_loc2_)
         {
            controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.END_OF_COMBAT_ANIMATION_FINISHED));
            return;
         }
         if(!this.war.currentFight.isLeftFighterWinner)
         {
            _loc3_ = this.fighterLeft;
            _loc4_ = new GTween(_loc3_,0.2,{"rotation":15});
            _loc4_.onComplete = this.onLeftElementRotateComplete;
            return;
         }
         _loc3_ = this.fighterRight;
         _loc4_ = new GTween(_loc3_,0.2,{"rotation":-15});
         _loc4_.onComplete = this.onRightElementRotateComplete;
      }
      
      private function onLeftElementRotateComplete(param1:GTween) : void
      {
         param1 = new GTween(param1.target,0.5,{"y":Constants_Basic.GAME_HEIGHT});
         param1.ease = Sine.easeIn;
         param1.onComplete = this.onLeftElementFallComplete;
      }
      
      private function onLeftElementFallComplete(param1:GTween) : void
      {
         controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.END_OF_COMBAT_ANIMATION_FINISHED));
      }
      
      private function onRightElementRotateComplete(param1:GTween) : void
      {
         param1 = new GTween(param1.target,0.5,{"y":Constants_Basic.GAME_HEIGHT});
         param1.ease = Sine.easeIn;
         param1.onComplete = this.onRightElementFallComplete;
      }
      
      private function onRightElementFallComplete(param1:GTween) : void
      {
         controller.dispatchEvent(new MafiaFightEvent(MafiaFightEvent.END_OF_COMBAT_ANIMATION_FINISHED));
      }
      
      private function fillFightersLeft() : void
      {
         this.fillFightersSide(this.war.fightersLeft,this.multiFightScreen.leftFightHolder,LeftFightAttendant);
      }
      
      private function fillFightersRight() : void
      {
         this.fillFightersSide(this.war.fightersRight,this.multiFightScreen.rightFightHolder,RightFightAttendant);
      }
      
      private function fillFightersSide(param1:Vector.<FighterVO>, param2:MovieClip, param3:Class) : void
      {
         var _loc5_:FighterVO = null;
         var _loc7_:MovieClip = null;
         MovieClipHelper.clearMovieClip(param2);
         var _loc4_:int = 0;
         var _loc6_:uint = 0;
         while(_loc6_ < param1.length)
         {
            _loc5_ = param1[_loc6_];
            _loc7_ = new param3();
            _loc7_.filters = [this.elementFilters];
            _loc7_.header.txt_name.text = _loc5_.name;
            if(_loc5_.characterClass != null && _loc5_.characterClass != CharacterClass.None)
            {
               _loc7_.header.txt_level.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " " + _loc5_.level.toString();
               _loc7_.avatarPicField1.holder.addChild(_loc5_.typeMC);
               _loc7_.header.classHolder.addChild(_loc5_.characterClassMC);
            }
            setHitpoints(_loc7_,_loc5_);
            _loc7_.y = _loc4_;
            if(_loc6_ <= 1)
            {
               _loc4_ = _loc4_ - 33;
            }
            else
            {
               _loc4_ = _loc4_ - 5;
            }
            _loc7_.scaleX = _loc7_.scaleY = 1 - _loc6_ / 20;
            _loc7_.bloodone.visible = false;
            _loc7_.bloodtwo.visible = false;
            param2.addChildAt(_loc7_,0);
            _loc6_++;
         }
      }
      
      override protected function get fighterRight() : MovieClip
      {
         return this.multiFightScreen.rightFightHolder.getChildAt(this.multiFightScreen.rightFightHolder.numChildren - 1) as MovieClip;
      }
      
      override protected function get fighterLeft() : MovieClip
      {
         return this.multiFightScreen.leftFightHolder.getChildAt(this.multiFightScreen.leftFightHolder.numChildren - 1) as MovieClip;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case resultPanel.btn_close:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               clearFight();
               layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
               ShowClanCommand.sendCommand();
               break;
            default:
               super.onClick(param1);
         }
      }
      
      protected function get result() : MafiaMultiFightScreenProperties
      {
         return properties as MafiaMultiFightScreenProperties;
      }
      
      protected function get multiFightScreen() : MafiaMultiFight
      {
         return disp as MafiaMultiFight;
      }
      
      override protected function get fight() : MafiaFightResultData
      {
         return MafiaModel.userData.userClan.clanWar.currentFight;
      }
      
      override protected function get reward() : RewardVO
      {
         return this.war.playerReward;
      }
   }
}
