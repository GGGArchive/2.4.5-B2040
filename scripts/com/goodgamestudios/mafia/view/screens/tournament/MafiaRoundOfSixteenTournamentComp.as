package com.goodgamestudios.mafia.view.screens.tournament
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Tournament;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.FighterState;
   import com.goodgamestudios.mafia.controller.commands.specialevent.tournament.ViewTournamentFightCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaTournamentEvent;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.tooltips.MafiaRoundOfSixteenAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaRoundOfSixteenAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.tournament.TournamentFinalFightVO;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MafiaRoundOfSixteenTournamentComp
   {
      
      private static const OFFSET_AVATAR_NORMAL:Number = 35;
      
      private static const OFFSET_AVATAR_FINALS:Number = 15;
      
      private static const OFFSET_TOOLTIP_NORMAL:Number = 77;
      
      private static const OFFSET_TOOLTIP_FINALS:Number = 175;
       
      
      private var tab:MovieClip;
      
      public function MafiaRoundOfSixteenTournamentComp(param1:MovieClip)
      {
         super();
         this.tab = param1;
         this.tab.txt_ro16_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_22");
         this.tab.txt_ro8_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_23");
         this.tab.txt_ro4_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_24");
         this.tab.txt_ro2_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_25");
      }
      
      public function show() : void
      {
         this.resetFight();
         this.controller.addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_FINALS_OVERVIEW_UPDATED,this.onFinalsOverviewUpdate);
         this.tab.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function hide() : void
      {
         this.controller.removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_FINALS_OVERVIEW_UPDATED,this.onFinalsOverviewUpdate);
         this.tab.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.resetFight();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(BasicToolTipManager.TOOLTIP_VO in param1.target)
         {
            this.watchFightReplay(param1.target.properties);
         }
      }
      
      private function onFinalsOverviewUpdate(param1:MafiaSpecialEventsEvent) : void
      {
         this.fillFights();
      }
      
      public function fillFights() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc1_:MafiaTournamentEvent = MafiaModel.specialEvent.tournamentEvent;
         _loc2_ = 1;
         while(_loc2_ <= 8)
         {
            _loc3_ = this.tab["fight_ro16_" + _loc2_];
            _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            _loc3_.mouseChildren = false;
            this.fillFight(_loc3_,_loc1_.getFinalFightVO(Constants_Tournament.RO16_ROUNDOFSIXTEEN,_loc2_ - 1));
            this.setTooltip(_loc3_,_loc1_.getFinalFightVO(Constants_Tournament.RO16_ROUNDOFSIXTEEN,_loc2_ - 1),Constants_Tournament.RO16_ROUNDOFSIXTEEN);
            _loc3_.properties = _loc1_.getFinalFightVO(Constants_Tournament.RO16_ROUNDOFSIXTEEN,_loc2_ - 1);
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= 4)
         {
            _loc3_ = this.tab["fight_ro8_" + _loc2_];
            _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            _loc3_.mouseChildren = false;
            this.fillFight(_loc3_,_loc1_.getFinalFightVO(Constants_Tournament.RO16_QUARTERFINAL,_loc2_ - 1));
            this.setTooltip(_loc3_,_loc1_.getFinalFightVO(Constants_Tournament.RO16_QUARTERFINAL,_loc2_ - 1),Constants_Tournament.RO16_QUARTERFINAL);
            _loc3_.properties = _loc1_.getFinalFightVO(Constants_Tournament.RO16_QUARTERFINAL,_loc2_ - 1);
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= 2)
         {
            _loc3_ = this.tab["fight_ro4_" + _loc2_];
            _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            _loc3_.mouseChildren = false;
            this.fillFight(_loc3_,_loc1_.getFinalFightVO(Constants_Tournament.RO16_SEMIFINAL,_loc2_ - 1));
            this.setTooltip(_loc3_,_loc1_.getFinalFightVO(Constants_Tournament.RO16_SEMIFINAL,_loc2_ - 1),Constants_Tournament.RO16_SEMIFINAL);
            _loc3_.properties = _loc1_.getFinalFightVO(Constants_Tournament.RO16_SEMIFINAL,_loc2_ - 1);
            _loc2_++;
         }
         _loc3_ = this.tab["fight_final"];
         _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         _loc3_.mouseChildren = false;
         this.fillFight(_loc3_,_loc1_.getFinalFightVO(Constants_Tournament.RO16_FINAL,0),true);
         this.setTooltip(_loc3_,_loc1_.getFinalFightVO(Constants_Tournament.RO16_FINAL,0),Constants_Tournament.RO16_FINAL);
         _loc3_.properties = _loc1_.getFinalFightVO(Constants_Tournament.RO16_FINAL,0);
      }
      
      private function setTooltip(param1:MovieClip, param2:TournamentFinalFightVO, param3:int) : void
      {
         if(!param2.avatarPicString1)
         {
            return;
         }
         var _loc4_:int = OFFSET_TOOLTIP_NORMAL;
         if(param3 == Constants_Tournament.RO16_FINAL)
         {
            _loc4_ = OFFSET_TOOLTIP_FINALS;
         }
         var _loc5_:Point = param1.localToGlobal(new Point());
         _loc5_.x = (_loc5_.x - this.layoutManager.gameNullPoint) / this.layoutManager.scaleFactor;
         _loc5_.y = _loc5_.y / this.layoutManager.scaleFactor - _loc4_;
         param1.toolTipVO = new TooltipVO(MafiaRoundOfSixteenAdvancedTooltip.NAME,new MafiaRoundOfSixteenAdvancedTooltipProperties(param2,param3),_loc5_,"",BasicCustomCursor.CURSOR_CLICK);
      }
      
      private function fillFight(param1:MovieClip, param2:TournamentFinalFightVO, param3:Boolean = false) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         if(param3)
         {
            _loc4_ = Constants_ViewScales.SCALE_AVATAR_ROUNDOFSIXTEEN_FINAL;
            _loc5_ = OFFSET_AVATAR_FINALS;
         }
         else
         {
            _loc4_ = Constants_ViewScales.SCALE_AVATAR_ROUNDOFSIXTEEN_NORMAL;
            _loc5_ = OFFSET_AVATAR_NORMAL;
         }
         if(param2 != null)
         {
            _loc6_ = 1;
            while(_loc6_ <= 2)
            {
               param1["fighter" + _loc6_ + "_freecard"].visible = false;
               param1["fighter" + _loc6_ + "_unknown"].visible = false;
               param1["fighter" + _loc6_ + "_left"].visible = false;
               param1["fighter" + _loc6_ + "_lost"].visible = false;
               switch(param2["fighterState" + _loc6_])
               {
                  case FighterState.Freecard:
                     param1["fighter" + _loc6_ + "_freecard"].visible = true;
                     break;
                  case FighterState.None:
                     param1["fighter" + _loc6_ + "_unknown"].visible = true;
                     break;
                  case FighterState.Left:
                     param1["fighter" + _loc6_ + "_left"].visible = true;
                     break;
                  case FighterState.Lost:
                     param1["fighter" + _loc6_ + "_lost"].visible = true;
                  case FighterState.Ready:
                  case FighterState.Won:
                     this.fillAvatarPic(param1["fighter_" + _loc6_ + "_avatar"],_loc4_,param2["avatarPicString" + _loc6_],_loc5_);
               }
               _loc6_++;
            }
         }
         else
         {
            param1.fighter1_unknown.visible = true;
            param1.fighter2_unknown.visible = true;
            param1.fighter1_left.visible = false;
            param1.fighter2_left.visible = false;
            param1.fighter1_lost.visible = false;
            param1.fighter2_lost.visible = false;
            param1.fighter1_freecard.visible = false;
            param1.fighter2_freecard.visible = false;
         }
      }
      
      private function resetDuelContainer(param1:MovieClip) : void
      {
         var _loc2_:uint = 1;
         while(_loc2_ <= 2)
         {
            param1["fighter" + _loc2_ + "_unknown"].visible = true;
            param1["fighter" + _loc2_ + "_left"].visible = false;
            param1["fighter" + _loc2_ + "_lost"].visible = false;
            MovieClipHelper.clearMovieClip(param1["fighter_" + _loc2_ + "_avatar"]);
            _loc2_++;
         }
      }
      
      private function fillAvatarPic(param1:MovieClip, param2:Number, param3:String, param4:Number) : void
      {
         MovieClipHelper.clearMovieClip(param1);
         var _loc5_:Sprite = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(param3),param2,false);
         _loc5_.y = _loc5_.y + param4;
         param1.addChild(_loc5_);
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         if(BasicToolTipManager.TOOLTIP_LABEL in param1.target)
         {
            this.layoutManager.tooltipManager.show(param1.target.toolTipText,param1.target as DisplayObject);
            return;
         }
         if(BasicToolTipManager.TOOLTIP_VO in param1.target)
         {
            this.layoutManager.tooltipManager.showAdvancedTooltip(param1.target.toolTipVO,param1.target as DisplayObject);
            BasicLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         if(BasicToolTipManager.TOOLTIP_LABEL in param1.target)
         {
            this.layoutManager.tooltipManager.hide();
            return;
         }
         if(BasicToolTipManager.TOOLTIP_VO in param1.target)
         {
            this.layoutManager.tooltipManager.hideAdvancedTooltip();
            BasicLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      private function resetFight() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 1;
         while(_loc1_ <= 8)
         {
            _loc2_ = this.tab["fight_ro16_" + _loc1_];
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            this.resetDuelContainer(_loc2_);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            _loc2_ = this.tab["fight_ro8_" + _loc1_];
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            this.resetDuelContainer(_loc2_);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 2)
         {
            _loc2_ = this.tab["fight_ro4_" + _loc1_];
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            this.resetDuelContainer(_loc2_);
            _loc1_++;
         }
         _loc2_ = this.tab["fight_final"];
         _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.resetDuelContainer(_loc2_);
      }
      
      private function watchFightReplay(param1:TournamentFinalFightVO) : void
      {
         if(param1.fighterState1 != FighterState.Freecard && param1.fighterState2 != FighterState.Freecard)
         {
            if(param1.state == TournamentFinalFightVO.STATE_OVER)
            {
               ViewTournamentFightCommand.sendCommand(param1.fighter1.playerID,param1.fighter2.playerID);
            }
         }
      }
      
      protected function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
   }
}
