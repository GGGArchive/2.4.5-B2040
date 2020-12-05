package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaSelfUpdatingTooltipProperties;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class MafiaSelfUpdatingTooltip extends MafiaMultiLineAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaSelfUpdatingTooltip";
       
      
      private var timer:Timer;
      
      public function MafiaSelfUpdatingTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.selfUpdatingTooltipProperties.copy = this.selfUpdatingTooltipProperties.onUpdate(this.selfUpdatingTooltipProperties.functionParams);
         super.applyProperties();
      }
      
      protected function get selfUpdatingTooltip() : MafiaSelfUpdatingTooltip
      {
         return disp as MafiaSelfUpdatingTooltip;
      }
      
      protected function get selfUpdatingTooltipProperties() : MafiaSelfUpdatingTooltipProperties
      {
         return properties as MafiaSelfUpdatingTooltipProperties;
      }
      
      override public function show() : void
      {
         super.show();
         this.startUpdateTimer();
      }
      
      override public function hide() : void
      {
         this.stopUpdateTimer();
         super.hide();
      }
      
      override public function destroy() : void
      {
         this.stopUpdateTimer();
         super.destroy();
      }
      
      private function startUpdateTimer() : void
      {
         if(this.timer == null)
         {
            this.timer = new Timer(this.selfUpdatingTooltipProperties.updateInterval);
            this.timer.addEventListener(TimerEvent.TIMER,this.updateText);
            this.timer.start();
         }
      }
      
      private function stopUpdateTimer() : void
      {
         if(this.timer != null)
         {
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER,this.updateText);
            this.timer = null;
         }
      }
      
      private function updateText(param1:Event) : void
      {
         this.applyProperties();
      }
   }
}
