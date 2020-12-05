package com.goodgamestudios.mafia.view.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.equipment.AddArmamentCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.SetActiveArmamentCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.ViewArmamentCommand;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaActivateBattleArmamentDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaActivateBattleArmamentDialogProperties;
   import com.goodgamestudios.mafia.view.panels.MafiaPanel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MafiaArmamentPresetSelection extends MafiaPanel
   {
       
      
      protected const NUM_SLOTS:uint = 4;
      
      protected const BTN_STATE_NORMAL:String = "normal";
      
      protected const BTN_STATE_OVER:String = "over";
      
      protected const BTN_STATE_ACTIVE:String = "active";
      
      protected const BTN_STATE_LOCKED:String = "locked";
      
      protected const BTN_STATE_DISABLED:String = "disabled";
      
      protected var unlockMode:Boolean;
      
      public function MafiaArmamentPresetSelection(param1:CombatPresetMC)
      {
         super(param1);
         this.setup(0,0,false);
      }
      
      public function setup(param1:uint, param2:uint, param3:Boolean) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:String = null;
         if(param2 > param1)
         {
            trace("-- WARNING! Active preset is invalid! --");
         }
         this.unlockMode = param3;
         var _loc6_:uint = 0;
         while(_loc6_ < this.NUM_SLOTS)
         {
            _loc4_ = disp["btn_" + _loc6_];
            _loc4_.mouseChildren = false;
            if(_loc6_ < param1)
            {
               _loc4_.gotoAndStop(_loc6_ == param2?this.BTN_STATE_ACTIVE:this.BTN_STATE_NORMAL);
               _loc4_.txt_slot.text = (_loc6_ + 1).toString();
               _loc5_ = !!param3?MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_activateArmament",[_loc6_ + 1]):MafiaModel.languageData.getTextById("MafiaPreFightScreen_9");
            }
            else if(param3)
            {
               _loc4_.gotoAndStop(this.BTN_STATE_LOCKED);
               _loc5_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_unlockArmament");
            }
            else
            {
               _loc4_.gotoAndStop(this.BTN_STATE_DISABLED);
               _loc5_ = null;
            }
            _loc4_.toolTipText = _loc5_;
            this.panel.marker.x = _loc6_ == param2?Number(_loc4_.x):Number(this.panel.marker.x);
            this.panel.marker.rotation = !!param3?Number(0):Number(180);
            this.panel.marker.visible = param1 > 0;
            updateAllTextFields();
            _loc6_++;
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         super.onMouseOver(param1);
         if(param1.target is CombatPresetButton)
         {
            _loc2_ = param1.target as MovieClip;
            if(_loc2_.currentFrameLabel == this.BTN_STATE_NORMAL)
            {
               _loc2_.gotoAndStop(this.BTN_STATE_OVER);
            }
            if(_loc2_.txtTooltipText)
            {
               layoutManager.tooltipManager.show(_loc2_.tooltip,_loc2_);
            }
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         super.onMouseOut(param1);
         if(param1.target is CombatPresetButton)
         {
            _loc2_ = param1.target as MovieClip;
            if(_loc2_.currentFrameLabel == this.BTN_STATE_OVER)
            {
               _loc2_.gotoAndStop(this.BTN_STATE_NORMAL);
            }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         if(param1.target is CombatPresetButton)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = Number(_loc2_.name.split("_")[1]);
            switch(_loc2_.currentFrameLabel)
            {
               case this.BTN_STATE_LOCKED:
                  this.showUnlockDialog();
                  break;
               case this.BTN_STATE_NORMAL:
               case this.BTN_STATE_OVER:
                  if(this.unlockMode)
                  {
                     SetActiveArmamentCommand.sendCommand(_loc3_);
                  }
                  else
                  {
                     MafiaModel.userData.armamentPresetData.activeArmament = _loc3_;
                     BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_PRESET_DATA));
                     ViewArmamentCommand.sendCommand(MafiaModel.userData.playerID);
                  }
            }
         }
         updateAllTextFields();
      }
      
      override public function updatePosition() : void
      {
      }
      
      protected function get panel() : CombatPresetMC
      {
         return disp as CombatPresetMC;
      }
      
      protected function showUnlockDialog() : void
      {
         var _loc1_:uint = MafiaModel.userData.armamentPresetData.unlockCost;
         MafiaLayoutManager.getInstance().showDialog(MafiaActivateBattleArmamentDialog.NAME,new MafiaActivateBattleArmamentDialogProperties(MafiaModel.languageData.getTextById("MafiaUnlockArmamentDialog_title"),MafiaModel.languageData.getTextById("MafiaUnlockArmamentDialog_copy_1"),this.tryToUnlock,null,MafiaModel.languageData.getTextById("MafiaGangScreen_copy_5"),_loc1_));
      }
      
      protected function tryToUnlock() : void
      {
         if(MafiaModel.userData.gold >= MafiaModel.userData.armamentPresetData.unlockCost)
         {
            AddArmamentCommand.sendCommand();
         }
         else
         {
            MafiaLayoutManager.getInstance().showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForExpandArmament_copy"),basicController.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
         }
      }
   }
}
