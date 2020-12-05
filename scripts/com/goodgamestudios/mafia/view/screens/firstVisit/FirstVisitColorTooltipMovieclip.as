package com.goodgamestudios.mafia.view.screens.firstVisit
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class FirstVisitColorTooltipMovieclip
   {
       
      
      public var disp:ColorPopup;
      
      private var _colorArray:Array;
      
      private var _sourceMc:MovieClip;
      
      private var _avatar_screen:Object;
      
      private var buttonArray:Vector.<MovieClip>;
      
      private var callbackFunction:Function;
      
      private const SPACE_X:int = 40;
      
      private const SPACE_Y:int = 40;
      
      public var type:String;
      
      public function FirstVisitColorTooltipMovieclip(param1:Array, param2:MovieClip, param3:Object, param4:String, param5:Function)
      {
         this.buttonArray = new Vector.<MovieClip>();
         super();
         this.disp = new ColorPopup();
         this._colorArray = param1;
         this._sourceMc = param2;
         this._avatar_screen = param3;
         this.callbackFunction = param5;
         param3.addChild(this.disp);
         this.position();
         param2.stage.addEventListener(Event.RESIZE,this.onResize);
         this.type = param4;
         this.initMC();
         this.disp.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onResize(param1:Event) : void
      {
         this.position();
      }
      
      private function position() : void
      {
         if(this.disp && this.disp.stage)
         {
            if(this.disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT < this.disp.stage.stageWidth / Constants_Basic.GAME_WIDTH)
            {
               this.disp.scaleX = this.disp.scaleY = this.disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT;
            }
            else
            {
               this.disp.scaleX = this.disp.scaleY = this.disp.stage.stageWidth / Constants_Basic.GAME_WIDTH;
            }
            this.disp.x = (this.disp.stage.stageWidth - Constants_Basic.GAME_WIDTH * this.disp.scaleX) * 0.5;
         }
         var _loc1_:Point = this._sourceMc.localToGlobal(new Point(this._sourceMc.stage.x,this._sourceMc.stage.y));
         this.disp.x = _loc1_.x;
         this.disp.y = _loc1_.y - 10;
      }
      
      private function initMC() : void
      {
         var _loc2_:ColorChoiceButton = null;
         var _loc3_:ColorTransform = null;
         this.disp.gotoAndStop(this._colorArray.length > 6?2:1);
         var _loc1_:int = 0;
         while(_loc1_ < (this.disp.currentFrame == 1?6:9))
         {
            _loc2_ = this.disp["i" + _loc1_];
            _loc3_ = new ColorTransform();
            if(this._colorArray[_loc1_] is Array)
            {
               if(this._colorArray[_loc1_][1])
               {
                  _loc2_.gotoAndStop(2);
                  _loc3_.color = this._colorArray[_loc1_][0];
                  _loc2_.btn2.cc1.transform.colorTransform = _loc3_;
                  _loc3_.color = this._colorArray[_loc1_][1];
                  _loc2_.btn2.cc2.transform.colorTransform = _loc3_;
               }
               else
               {
                  _loc2_.gotoAndStop(1);
                  _loc3_.color = this._colorArray[_loc1_][0];
                  _loc2_.btn1.cc.transform.colorTransform = _loc3_;
               }
            }
            else
            {
               _loc3_.color = this._colorArray[_loc1_];
               _loc2_.btn1.cc.transform.colorTransform = _loc3_;
            }
            this.buttonArray.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(!(param1.target is MovieClip))
         {
            return;
         }
         switch(param1.target)
         {
            case this.disp.i0:
               if(this.disp.i0.currentFrame == 1)
               {
                  this.callbackFunction(this.disp.i0.btn1.cc.transform.colorTransform.color);
               }
               else
               {
                  this.callbackFunction(this.disp.i0.btn2.cc1.transform.colorTransform.color,this.disp.i0.btn2.cc2.transform.colorTransform.color);
               }
               break;
            case this.disp.i1:
               if(this.disp.i1.currentFrame == 1)
               {
                  this.callbackFunction(this.disp.i1.btn1.cc.transform.colorTransform.color);
               }
               else
               {
                  this.callbackFunction(this.disp.i1.btn2.cc1.transform.colorTransform.color,this.disp.i1.btn2.cc2.transform.colorTransform.color);
               }
               break;
            case this.disp.i2:
               if(this.disp.i2.currentFrame == 1)
               {
                  this.callbackFunction(this.disp.i2.btn1.cc.transform.colorTransform.color);
               }
               else
               {
                  this.callbackFunction(this.disp.i2.btn2.cc1.transform.colorTransform.color,this.disp.i2.btn2.cc2.transform.colorTransform.color);
               }
               break;
            case this.disp.i3:
               if(this.disp.i3.currentFrame == 1)
               {
                  this.callbackFunction(this.disp.i3.btn1.cc.transform.colorTransform.color);
               }
               else
               {
                  this.callbackFunction(this.disp.i3.btn2.cc1.transform.colorTransform.color,this.disp.i3.btn2.cc2.transform.colorTransform.color);
               }
               break;
            case this.disp.i4:
               if(this.disp.i4.currentFrame == 1)
               {
                  this.callbackFunction(this.disp.i4.btn1.cc.transform.colorTransform.color);
               }
               else
               {
                  this.callbackFunction(this.disp.i4.btn2.cc1.transform.colorTransform.color,this.disp.i4.btn2.cc2.transform.colorTransform.color);
               }
               break;
            case this.disp.i5:
               if(this.disp.i5.currentFrame == 1)
               {
                  this.callbackFunction(this.disp.i5.btn1.cc.transform.colorTransform.color);
               }
               else
               {
                  this.callbackFunction(this.disp.i5.btn2.cc1.transform.colorTransform.color,this.disp.i5.btn2.cc2.transform.colorTransform.color);
               }
               break;
            case this.disp.i6:
               if(this.disp.i6.currentFrame == 1)
               {
                  this.callbackFunction(this.disp.i6.btn1.cc.transform.colorTransform.color);
               }
               else
               {
                  this.callbackFunction(this.disp.i6.btn2.cc1.transform.colorTransform.color,this.disp.i6.btn2.cc2.transform.colorTransform.color);
               }
               break;
            case this.disp.i7:
               if(this.disp.i7.currentFrame == 1)
               {
                  this.callbackFunction(this.disp.i7.btn1.cc.transform.colorTransform.color);
               }
               else
               {
                  this.callbackFunction(this.disp.i7.btn2.cc1.transform.colorTransform.color,this.disp.i7.btn2.cc2.transform.colorTransform.color);
               }
               break;
            case this.disp.i8:
               if(this.disp.i8.currentFrame == 1)
               {
                  this.callbackFunction(this.disp.i8.btn1.cc.transform.colorTransform.color);
               }
               else
               {
                  this.callbackFunction(this.disp.i8.btn2.cc1.transform.colorTransform.color,this.disp.i8.btn2.cc2.transform.colorTransform.color);
               }
         }
      }
      
      public function destroy() : void
      {
         this._sourceMc.stage.removeEventListener(Event.RESIZE,this.onResize);
         if(this.disp.parent)
         {
            this.disp.parent.removeChild(this.disp);
         }
         MovieClipHelper.clearMovieClip(this.disp);
         this._sourceMc = null;
         this._avatar_screen = null;
         while(this.buttonArray.length > 0)
         {
            this.buttonArray.shift();
         }
      }
   }
}
