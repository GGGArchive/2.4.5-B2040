package com.goodgamestudios.mafia.view.screens.energy
{
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.graphics.utils.ColorUtils;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.event.model.MafiaMissionEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.MafiaScreen;
   import com.gskinner.motion.GTween;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   
   public class MafiaEnergyBarComponent extends MafiaScreen
   {
      
      private static const ENERGY_BAR_WIDTH_NORMAL:int = 345;
      
      private static const ENERGY_BAR_WIDTH_EXPANDED:int = 405;
       
      
      private var lastEnergyValue:Number;
      
      private var isRefillTimeLabelExpanded:Boolean;
      
      private const MAX_ENERGY:int = 1000;
      
      public function MafiaEnergyBarComponent(param1:DisplayObject)
      {
         super(param1,false);
         this.energyBar.mouseChildren = false;
         this.energyBar.alpha = 1;
         this.lastEnergyValue = -1;
      }
      
      override public function updatePosition() : void
      {
      }
      
      override public function show() : void
      {
         super.show();
         this.visualizeDefault();
         controller.addEventListener(MafiaMissionEvent.CHANGE_ENERGYUPDATETIMER,this.onEnergyRefreshData);
      }
      
      private function showRefillTimeLabelAnimated() : void
      {
         var _loc1_:GTween = null;
         if(!this.isRefillTimeLabelExpanded)
         {
            _loc1_ = new GTween(this.energyBar.background,0.5,{"width":ENERGY_BAR_WIDTH_EXPANDED});
            _loc1_.onComplete = this.onEnergyRefillScaleComplete;
            this.isRefillTimeLabelExpanded = true;
         }
      }
      
      private function onEnergyRefillScaleComplete(param1:GTween) : void
      {
         if(MafiaModel.userData.userMissionEnergy < this.MAX_ENERGY)
         {
            this.energyBar.txt_energyRefresh.visible = true;
         }
         else
         {
            this.energyBar.txt_energyRefresh.visible = false;
         }
      }
      
      private function hideRefillTimeLabelAnimated() : void
      {
         var _loc1_:GTween = null;
         if(this.isRefillTimeLabelExpanded)
         {
            _loc1_ = new GTween(this.energyBar.background,0.5,{"width":ENERGY_BAR_WIDTH_NORMAL});
            this.energyBar.txt_energyRefresh.visible = false;
            this.isRefillTimeLabelExpanded = false;
         }
      }
      
      private function hideRefillTimeLabel() : void
      {
         this.energyBar.background.width = ENERGY_BAR_WIDTH_NORMAL;
         this.energyBar.txt_energyRefresh.visible = false;
         this.isRefillTimeLabelExpanded = false;
      }
      
      public function visualizeDefault() : void
      {
         this.hideRefillTimeLabel();
         this.energyBar.toolTipText = null;
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaMissionEvent.CHANGE_ENERGYUPDATETIMER,this.onEnergyRefreshData);
         super.removeEvents();
      }
      
      private function onEnergyRefreshData(param1:MafiaMissionEvent) : void
      {
         var _loc2_:int = MafiaModel.userData.userMissionEnergy;
         if(_loc2_ < Constants_Basic.MAX_ENERGY)
         {
            this.showRefillTimeLabelAnimated();
         }
         else
         {
            this.hideRefillTimeLabelAnimated();
         }
         if(this.isRefillTimeLabelExpanded)
         {
            this.energyBar.txt_energyRefresh.text = "+ " + param1.params[0];
            this.energyBar.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_refill_1",[param1.params[0]]);
         }
         else
         {
            this.energyBar.toolTipText = null;
         }
      }
      
      public function showDefaultEnergyBar() : void
      {
         var _loc2_:GTween = null;
         this.energyBar.alpha = 1;
         this.energyBar.tempEnergy_Bar.alpha = 0;
         this.energyBar.txt_value.text = MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_energy") + ": " + String(MafiaModel.userData.userMissionEnergy / 10);
         this.energyBar.actEnergy_Bar.scaleX = MafiaModel.userData.userMissionEnergy / Constants_Basic.MAX_ENERGY;
         var _loc1_:ColorMatrix = new ColorMatrix();
         _loc1_.reset();
         this.energyBar.actEnergy_Bar.filters = [_loc1_.filter];
         if(MafiaModel.userData.userMissionEnergy == 0)
         {
            this.energyBar.alpha = 0.5;
         }
         if(this.lastEnergyValue != -1 && this.lastEnergyValue < MafiaModel.userData.userMissionEnergy)
         {
            _loc2_ = new GTween(this.energyBar,0.3);
            _loc2_.onChange = this.onGlowEnergy;
            _loc2_.onComplete = this.onGlowEnergyComplete;
         }
         this.lastEnergyValue = MafiaModel.userData.userMissionEnergy;
      }
      
      private function onGlowEnergy(param1:GTween) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:GlowFilter = new GlowFilter(16777215,1,15,15,3,1);
         _loc2_.filters = [_loc3_];
      }
      
      private function onGlowEnergyComplete(param1:GTween) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.filters = [];
      }
      
      public function fillEnergyBar(param1:Number) : void
      {
         var _loc2_:ColorMatrix = null;
         if(param1 * 10 > MafiaModel.userData.userMissionEnergy)
         {
            _loc2_ = new ColorMatrix();
            _loc2_.colorize(ColorUtils.toColor("0xff3300"),1);
            this.energyBar.actEnergy_Bar.filters = [_loc2_.filter];
         }
         else
         {
            this.energyBar.tempEnergy_Bar.alpha = 0.5;
            this.energyBar.tempEnergy_Bar.scaleX = MafiaModel.userData.userMissionEnergy / Constants_Basic.MAX_ENERGY;
            this.energyBar.actEnergy_Bar.scaleX = (MafiaModel.userData.userMissionEnergy - param1 * 10) / Constants_Basic.MAX_ENERGY;
            this.energyBar.alpha = 1;
         }
      }
      
      public function fillPreDrinkEnergyBar() : void
      {
         this.energyBar.tempEnergy_Bar.alpha = 0.5;
         this.energyBar.tempEnergy_Bar.scaleX = (MafiaModel.userData.userMissionEnergy + 200) / Constants_Basic.MAX_ENERGY;
         if(this.energyBar.tempEnergy_Bar.scaleX > 1)
         {
            this.energyBar.tempEnergy_Bar.scaleX = 1;
         }
      }
      
      public function onOutEnergyBar() : void
      {
         this.showDefaultEnergyBar();
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      override protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case BasicTutorialController.TUT_STATE_COMPLETED:
               this.energyBar.txt_energyRefresh.visible = false;
         }
      }
      
      protected function get energyBar() : Energy_Bar
      {
         return disp as Energy_Bar;
      }
   }
}
