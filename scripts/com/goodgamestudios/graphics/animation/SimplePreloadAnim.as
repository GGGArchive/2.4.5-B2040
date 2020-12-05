package com.goodgamestudios.graphics.animation
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class SimplePreloadAnim extends Sprite
   {
       
      
      private var startTime:Number;
      
      private var currentDegree:int = 0;
      
      private var ggsLogo:GGS_Logo;
      
      public var circleRadius:Number = 8;
      
      public var numCircles:Number = 20;
      
      public var speed:int = 5;
      
      public var preloadWidth:Number = 50;
      
      public var preloadHeight:Number = 50;
      
      public var usedDegrees:Number = 120;
      
      public function SimplePreloadAnim()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.ggsLogo = new GGS_Logo();
         var _loc2_:Number = (this.preloadWidth - 10) / this.ggsLogo.width;
         this.ggsLogo.scaleX = this.ggsLogo.scaleY = _loc2_;
         this.ggsLogo.x = stage.stageWidth / 2;
         this.ggsLogo.y = stage.stageHeight / 2;
         addChild(this.ggsLogo);
         this.startTime = getTimer();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         addEventListener(Event.ENTER_FRAME,this.updatePreloadAnim);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         removeEventListener(Event.ENTER_FRAME,this.updatePreloadAnim);
      }
      
      private function updatePreloadAnim(param1:Event) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = getTimer();
         this.currentDegree = this.currentDegree + (_loc2_ - this.startTime) / this.speed;
         this.startTime = _loc2_;
         if(this.currentDegree >= 360)
         {
            this.currentDegree = 0;
         }
         graphics.clear();
         var _loc3_:Number = 0;
         var _loc6_:Number = 0;
         while(_loc6_ < 360)
         {
            _loc3_ = _loc6_ > this.currentDegree?Number(1 - (360 - _loc6_ + this.currentDegree) / this.usedDegrees):Number(1 - (this.currentDegree - _loc6_) / this.usedDegrees);
            _loc4_ = Math.cos(_loc6_ * (Math.PI / 180)) * this.preloadWidth + stage.stageWidth / 2;
            _loc5_ = Math.sin(_loc6_ * (Math.PI / 180)) * this.preloadHeight + stage.stageHeight / 2;
            graphics.beginFill(14540253,1);
            graphics.drawCircle(_loc4_,_loc5_,this.circleRadius);
            graphics.beginFill(2506366,Math.max(0,_loc3_));
            graphics.drawCircle(_loc4_,_loc5_,this.circleRadius);
            _loc6_ = _loc6_ + (Math.floor(360 / this.numCircles) + 360 % this.numCircles / this.numCircles);
         }
         this.ggsLogo.x = stage.stageWidth / 2;
         this.ggsLogo.y = stage.stageHeight / 2;
      }
   }
}
