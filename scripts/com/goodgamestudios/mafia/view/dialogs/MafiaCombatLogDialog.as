package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaCombatLogDialogProperties;
   import com.goodgamestudios.mafia.view.helper.CombatLogHelper;
   import com.goodgamestudios.mafia.vo.fight.FightItemVO;
   import com.goodgamestudios.mafia.vo.fight.FightTurnVO;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaCombatLogDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaCombatLogDialog";
       
      
      private var itemPositions:Array;
      
      private var logHelper:CombatLogHelper;
      
      private const ITEM_WIDTH:Number = 24.7;
      
      private const ITEM_SPACE:Number = 12;
      
      public function MafiaCombatLogDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
      }
      
      override public function hide() : void
      {
         super.hide();
         this.logHelper.hide();
      }
      
      override public function destroy() : void
      {
         this.logHelper.destroy();
         super.destroy();
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.txt_title.text = MafiaModel.languageData.getTextById("MafiaCombatLogDialog_title");
         this.drawUsedConsumables(this.getUsedConsumablesByPlayer(MafiaFightResultData.FIGHTER_LEFT,this.standardDialogProperties.duelResultLogData),MafiaFightResultData.FIGHTER_LEFT);
         this.drawUsedConsumables(this.getUsedConsumablesByPlayer(MafiaFightResultData.FIGHTER_RIGHT,this.standardDialogProperties.duelResultLogData),MafiaFightResultData.FIGHTER_RIGHT);
         this.standardDialog.txt_player_used_items.text = MafiaModel.languageData.getTextById("MafiaCombatLogDialog_copy_1",[MafiaModel.userData.userName]);
         this.standardDialog.txt_oponent_used_items.text = MafiaModel.languageData.getTextById("MafiaCombatLogDialog_copy_1",[this.standardDialogProperties.duelResultLogData.fighterRight.name]);
         this.standardDialog.txt_turns.text = MafiaModel.languageData.getTextById("MafiaCombatLogDialog_copy_2");
         this.logHelper = new CombatLogHelper(this.standardDialog.mc_scrollcomp);
         this.logHelper.init();
         this.fillLog();
      }
      
      private function fillLog() : void
      {
         this.logHelper.onAddTurnLogs(this.standardDialogProperties.duelResultLogData.fightTurns,this.standardDialogProperties.duelResultLogData);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_close:
            case this.standardDialog.btn_ok:
               this.hide();
         }
      }
      
      private function drawUsedConsumables(param1:Vector.<FightItemVO>, param2:int) : void
      {
         var _loc3_:String = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         if(param2 == MafiaFightResultData.FIGHTER_RIGHT)
         {
            _loc3_ = "mc_opponent_item_";
         }
         else if(param2 == MafiaFightResultData.FIGHTER_LEFT)
         {
            _loc3_ = "mc_player_item_";
         }
         var _loc4_:int = 0;
         while(_loc4_ < 20)
         {
            _loc6_ = this.standardDialog[_loc3_ + _loc4_] as MovieClip;
            MovieClipHelper.clearMovieClip(_loc6_);
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            if(_loc5_ < 20)
            {
               _loc7_ = MafiaItemData.getInstance().generateItemPic(param1[_loc5_].type,param1[_loc5_].subtype,param1[_loc5_].id,param1[_loc5_].quality);
               _loc7_.scaleX = _loc7_.scaleY = Constants_ViewScales.SCALE_COMBATLOG_LARGE;
               _loc8_ = this.standardDialog[_loc3_ + _loc5_] as MovieClip;
               _loc8_.addChild(_loc7_);
            }
            _loc5_++;
         }
      }
      
      private function getUsedConsumablesByPlayer(param1:int, param2:MafiaFightResultData) : Vector.<FightItemVO>
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:FightTurnVO = null;
         var _loc8_:int = 0;
         var _loc9_:FightActionVO = null;
         var _loc3_:Vector.<FightItemVO> = new Vector.<FightItemVO>();
         if(param1 == MafiaFightResultData.FIGHTER_LEFT)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.left_ammunition.length)
            {
               _loc3_.push(param2.left_ammunition[_loc5_]);
               _loc5_++;
            }
         }
         else if(param1 == MafiaFightResultData.FIGHTER_RIGHT)
         {
            _loc6_ = 0;
            while(_loc6_ < param2.right_ammunition.length)
            {
               _loc3_.push(param2.right_ammunition[_loc6_]);
               _loc6_++;
            }
         }
         var _loc4_:int = 0;
         while(_loc4_ < param2.fightTurns.length)
         {
            _loc7_ = param2.fightTurns[_loc4_];
            if(_loc7_.fighterOnTurn == param1)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc7_.actions.length)
               {
                  _loc9_ = _loc7_.actions[_loc8_];
                  if(_loc9_.consume && _loc9_.consume.item.type != ItemType.Weapon)
                  {
                     _loc3_.push(_loc9_.consume.item);
                  }
                  _loc8_++;
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      protected function get standardDialogProperties() : MafiaCombatLogDialogProperties
      {
         return properties as MafiaCombatLogDialogProperties;
      }
      
      protected function get standardDialog() : MafiaCombatLog
      {
         return disp as MafiaCombatLog;
      }
   }
}
