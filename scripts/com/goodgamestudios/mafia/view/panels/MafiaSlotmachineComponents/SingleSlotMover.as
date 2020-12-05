package com.goodgamestudios.mafia.view.panels.MafiaSlotmachineComponents
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.math.Random;
   import flash.display.MovieClip;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   import flash.utils.getDefinitionByName;
   
   public class SingleSlotMover
   {
       
      
      private var disp:MovieClip;
      
      private var icons:Vector.<SlotItemContainer>;
      
      private var endIcon:int;
      
      private const SPACEBETWEEN:int = 20;
      
      private const MIDDLEPOSITION:int = 70;
      
      private var POSITION:Array;
      
      private var speed:Number = 1;
      
      private var lastUpdate:int;
      
      private const MAX_SPEED:int = 15;
      
      private const MIN_SPEED:int = 1;
      
      public var animate:Boolean = false;
      
      private var becomeSlower:Boolean = false;
      
      private var itemGlowfilter:GlowFilter;
      
      private var stopAt:int = 0;
      
      public function SingleSlotMover(param1:MovieClip)
      {
         var _loc4_:MovieClip = null;
         var _loc5_:SlotItemContainer = null;
         this.icons = new Vector.<SlotItemContainer>();
         super();
         this.disp = param1;
         MovieClipHelper.clearMovieClip(this.disp);
         this.itemGlowfilter = new GlowFilter(0,1,1 * MafiaLayoutManager.getInstance().scaleFactor,1 * MafiaLayoutManager.getInstance().scaleFactor,20,3);
         var _loc2_:int = 0;
         while(_loc2_ < Constants_Basic.SLOTMOVER_PIC_CLASSNAME_LIST.length)
         {
            _loc4_ = new (getDefinitionByName(Constants_Basic.SLOTMOVER_PIC_CLASSNAME_LIST[_loc2_]) as Class)() as MovieClip;
            _loc4_.scaleX = _loc4_.scaleY = 0.65;
            _loc5_ = new SlotItemContainer();
            _loc5_.holder.addChild(_loc4_);
            this.icons.push(_loc5_);
            this.disp.addChild(this.icons[_loc2_]);
            this.icons[_loc2_].filters = [this.itemGlowfilter,new BlurFilter(0,0,1)];
            _loc2_++;
         }
         this.initPositions();
         var _loc3_:int = Random.integer(0,Constants_Basic.SLOTMOVER_PIC_CLASSNAME_LIST.length);
         _loc2_ = 0;
         while(_loc2_ < Constants_Basic.SLOTMOVER_PIC_CLASSNAME_LIST.length)
         {
            this.icons[_loc3_ + _loc2_ >= this.icons.length?_loc3_ + _loc2_ - this.icons.length:_loc3_ + _loc2_].y = this.POSITION[_loc2_];
            _loc2_++;
         }
      }
      
      public function reset() : void
      {
         this.speed = 1;
         this.lastUpdate = 0;
         this.animate = false;
         this.becomeSlower = false;
         this.stopAt = 0;
         if(this.icons[this.endIcon])
         {
            this.icons[this.endIcon].gotoAndStop(1);
         }
      }
      
      private function initPositions() : void
      {
         this.POSITION = [];
         var _loc1_:int = -3;
         var _loc2_:int = 0;
         while(_loc2_ < this.icons.length)
         {
            this.POSITION[_loc2_] = this.MIDDLEPOSITION + (_loc2_ + _loc1_) * this.SPACEBETWEEN;
            _loc2_++;
         }
      }
      
      public function updateDisp(param1:int) : void
      {
         var _loc3_:int = 0;
         if(this.isFinished)
         {
            _loc3_ = 0;
            while(_loc3_ < this.icons.length)
            {
               this.icons[_loc3_].filters = [this.itemGlowfilter];
               _loc3_++;
            }
            return;
         }
         if(!this.animate)
         {
            return;
         }
         if(this.lastUpdate == 0)
         {
            this.lastUpdate = param1;
            return;
         }
         this.controllSpeed(param1);
         var _loc2_:int = 0;
         while(_loc2_ < this.icons.length)
         {
            this.icons[_loc2_].y = this.icons[_loc2_].y + this.speed;
            if(this.icons[_loc2_].y > this.POSITION[this.POSITION.length - 1])
            {
               this.icons[_loc2_].y = this.lowestY() - this.SPACEBETWEEN;
            }
            this.icons[_loc2_].filters = [this.itemGlowfilter,new BlurFilter(0,this.speed * 0.5)];
            _loc2_++;
         }
         this.checkStopCondition();
         this.lastUpdate = param1;
      }
      
      private function checkStopCondition() : void
      {
         if(this.stopAt == 0)
         {
            return;
         }
         if(this.stopAt > 0)
         {
            if(this.icons[this.stopAt - 1].y < this.POSITION[3] + 20 && this.icons[this.stopAt - 1].y > this.POSITION[3] - 20)
            {
               this.becomeSlower = true;
               this.speed = this.MIN_SPEED;
               this.sortToEndPosition();
            }
         }
         else
         {
            this.stopAt = -Random.integer(1,6);
            this.stopAt = this.stopAt * 2;
            if(this.icons[this.stopAt * -1].y + this.SPACEBETWEEN * 0.5 < this.POSITION[3] + 20 && this.icons[this.stopAt * -1].y + this.SPACEBETWEEN * 0.5 > this.POSITION[3] - 20)
            {
               this.becomeSlower = true;
               this.speed = this.MIN_SPEED;
               this.sortToEndPosition();
            }
         }
      }
      
      private function sortToEndPosition() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.stopAt >= 1 && this.stopAt <= Constants_Basic.SLOTMOVER_PIC_CLASSNAME_LIST.length)
         {
            _loc1_ = this.stopAt - 1 - 3 < 0?int(this.stopAt - 1 - 3 + Constants_Basic.SLOTMOVER_PIC_CLASSNAME_LIST.length):int(this.stopAt - 1 - 3);
            this.endIcon = this.stopAt - 1;
            _loc2_ = 0;
            while(_loc2_ < Constants_Basic.SLOTMOVER_PIC_CLASSNAME_LIST.length)
            {
               this.icons[_loc1_ + _loc2_ >= this.icons.length?_loc1_ + _loc2_ - this.icons.length:_loc1_ + _loc2_].y = this.POSITION[_loc2_];
               _loc2_++;
            }
         }
         else
         {
            _loc3_ = this.stopAt * -1;
            this.endIcon = _loc3_ + 2;
            if(this.endIcon > this.icons.length - 1)
            {
               this.endIcon = 0;
            }
            _loc4_ = 0;
            while(_loc4_ < Constants_Basic.SLOTMOVER_PIC_CLASSNAME_LIST.length)
            {
               this.icons[_loc3_ + _loc4_ >= this.icons.length?_loc3_ + _loc4_ - this.icons.length:_loc3_ + _loc4_].y = this.POSITION[_loc4_] + this.SPACEBETWEEN;
               _loc4_++;
            }
         }
      }
      
      public function highlightWinIcon() : void
      {
         this.icons[this.endIcon].gotoAndPlay(2);
         this.disp.setChildIndex(this.icons[this.endIcon],0);
      }
      
      private function controllSpeed(param1:int) : void
      {
         var _loc2_:Number = this.speed * (param1 - this.lastUpdate) + 0.001;
         if(this.becomeSlower)
         {
            if(this.speed > this.MIN_SPEED)
            {
               this.speed = this.speed - _loc2_;
            }
            else
            {
               this.speed = this.MIN_SPEED;
            }
         }
         else if(this.speed < this.MAX_SPEED)
         {
            this.speed = this.speed + _loc2_ * 3;
         }
         else
         {
            this.speed = this.MAX_SPEED;
         }
      }
      
      private function lowestY() : int
      {
         var _loc1_:int = 100;
         var _loc2_:int = 0;
         while(_loc2_ < this.icons.length)
         {
            if(this.icons[_loc2_].y < _loc1_)
            {
               _loc1_ = this.icons[_loc2_].y;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function stopAtIconNr(param1:int) : void
      {
         if(this.stopAt == 0)
         {
            this.stopAt = param1 * 2;
         }
      }
      
      public function get isFinished() : Boolean
      {
         if(this.becomeSlower && this.speed == this.MIN_SPEED)
         {
            return true;
         }
         return false;
      }
      
      public function get isReadyToHear() : Boolean
      {
         if(this.speed == this.MAX_SPEED)
         {
            return true;
         }
         return false;
      }
   }
}
