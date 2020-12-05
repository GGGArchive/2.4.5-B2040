package com.goodgamestudios.graphics.utils
{
   import com.goodgamestudios.assetmanager.AssetManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class MovieClipHelper
   {
       
      
      public function MovieClipHelper()
      {
         super();
      }
      
      public static function stopAllMovies(param1:DisplayObjectContainer) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:MovieClip = param1 as MovieClip;
         if(_loc2_)
         {
            _loc2_.stop();
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            stopAllMovies(param1.getChildAt(_loc3_) as DisplayObjectContainer);
            _loc3_++;
         }
      }
      
      public static function stopAllMoviesGotoFrameOne(param1:DisplayObjectContainer) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:MovieClip = param1 as MovieClip;
         if(_loc2_)
         {
            _loc2_.gotoAndStop(1);
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            stopAllMoviesGotoFrameOne(param1.getChildAt(_loc3_) as DisplayObjectContainer);
            _loc3_++;
         }
      }
      
      public static function playAllMovies(param1:DisplayObjectContainer) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:MovieClip = param1 as MovieClip;
         if(_loc2_ && _loc2_.totalFrames > 1)
         {
            _loc2_.play();
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            MovieClipHelper.playAllMovies(param1.getChildAt(_loc3_) as DisplayObjectContainer);
            _loc3_++;
         }
      }
      
      public static function centerMovieClip(param1:DisplayObjectContainer, param2:int, param3:int, param4:Boolean = true) : void
      {
         var _loc5_:Rectangle = param1.getBounds(null);
         var _loc6_:Number = param1.scaleX;
         if(param4)
         {
            _loc6_ = param3 / _loc5_.width;
            if(_loc5_.height * _loc6_ > param2)
            {
               _loc6_ = param2 / _loc5_.height;
            }
         }
         param1.x = -(_loc5_.width * _loc6_ / 2 + _loc5_.left * _loc6_);
         param1.y = -(_loc5_.height * _loc6_ / 2 + _loc5_.top * _loc6_);
         param1.scaleX = param1.scaleY = _loc6_;
      }
      
      public static function isChildrenOf(param1:DisplayObject, param2:DisplayObjectContainer) : Boolean
      {
         var _loc3_:DisplayObject = param1;
         var _loc4_:Boolean = false;
         while(!_loc4_ && _loc3_.parent)
         {
            if(_loc3_.parent == param2)
            {
               _loc4_ = true;
            }
            else
            {
               _loc3_ = _loc3_.parent;
            }
         }
         return _loc4_;
      }
      
      public static function clearMovieClip(param1:DisplayObjectContainer) : void
      {
         if(param1)
         {
            while(param1.numChildren > 0)
            {
               param1.removeChildAt(0);
            }
         }
         else
         {
            trace("[As3Toolbox::MovieClipHelper]: clearMovieClip called with null mc. Have a nice day debugging.");
         }
      }
      
      public static function replaceMovieClip(param1:DisplayObjectContainer, param2:Class = null) : void
      {
         if(param2)
         {
            if(param1.numChildren > 0)
            {
               if(param1.getChildAt(0) is param2 == false)
               {
                  clearMovieClip(param1);
                  param1.addChild(new param2());
               }
            }
            else
            {
               param1.addChild(new param2());
            }
         }
         else
         {
            clearMovieClip(param1);
         }
      }
      
      public static function disableChildrenExceptList(param1:DisplayObjectContainer, param2:Array) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:DisplayObjectContainer = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_) as DisplayObjectContainer;
            for each(_loc5_ in param2)
            {
               if(_loc4_ == _loc5_)
               {
                  _loc4_.mouseEnabled = true;
               }
               else
               {
                  _loc4_.mouseEnabled = _loc4_.mouseChildren = false;
               }
            }
            _loc3_++;
         }
      }
      
      public static function getMovieClipByClassName(param1:String) : MovieClip
      {
         var dispClass:Class = null;
         var className:String = param1;
         try
         {
            dispClass = AssetManager.manager.getClass(className) as Class;
            return new dispClass() as MovieClip;
         }
         catch(error:Error)
         {
            return null;
         }
         return null;
      }
      
      public static function getSpriteByClassName(param1:String) : Sprite
      {
         var dispClass:Class = null;
         var className:String = param1;
         try
         {
            dispClass = AssetManager.manager.getClass(className) as Class;
            return new dispClass() as Sprite;
         }
         catch(error:Error)
         {
            return null;
         }
         return null;
      }
      
      public static function secureGoto(param1:MovieClip, param2:Object, param3:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc6_:FrameLabel = null;
         var _loc4_:int = 1;
         if(param2 is int)
         {
            _loc4_ = param2 as int;
            _loc5_ = param1.totalFrames;
            if(_loc4_ > _loc5_)
            {
               _loc4_ = _loc5_;
            }
            else if(_loc4_ <= 0)
            {
               _loc4_ = 1;
            }
         }
         else if(param2 is String)
         {
            for each(_loc6_ in param1.currentLabels)
            {
               if(_loc6_.name.toLocaleLowerCase() == (param2 as String).toLocaleLowerCase())
               {
                  _loc4_ = _loc6_.frame;
               }
            }
            if(_loc4_ <= 0)
            {
               _loc4_ = 1;
            }
         }
         if(param3)
         {
            param1.gotoAndPlay(_loc4_);
         }
         else
         {
            param1.gotoAndStop(_loc4_);
         }
      }
      
      public static function getVisibleSize(param1:DisplayObject) : Rectangle
      {
         var _loc3_:BitmapData = null;
         var _loc4_:Rectangle = null;
         var _loc2_:Matrix = new Matrix();
         _loc2_.tx = -param1.getBounds(null).x;
         _loc2_.ty = -param1.getBounds(null).y;
         if(param1.width > 0 && param1.height > 0)
         {
            _loc3_ = new BitmapData(param1.width,param1.height,true,0);
            _loc3_.draw(param1,_loc2_);
            _loc4_ = _loc3_.getColorBoundsRect(4294967295,0,false);
            _loc3_.dispose();
            return _loc4_;
         }
         return new Rectangle(0,0,0,0);
      }
      
      public static function scaleToFit(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = Math.min(param2 / (param1.width / param1.scaleX),param3 / (param1.height / param1.scaleY));
         param1.scaleX = param1.scaleY = _loc4_;
      }
      
      public static function scaleDownToFit(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = Math.min(param2 / (param1.width / param1.scaleX),param3 / (param1.height / param1.scaleY));
         if(_loc4_ < param1.scaleX)
         {
            param1.scaleX = param1.scaleY = _loc4_;
         }
      }
      
      public static function watchAnimationEnd(param1:MovieClip, param2:Function = null) : void
      {
         var oef:Function = null;
         var mc:MovieClip = param1;
         var callback:Function = param2;
         oef = function(param1:Event):void
         {
            if(mc.currentFrame == mc.totalFrames)
            {
               mc.removeEventListener(Event.ENTER_FRAME,oef);
               mc.stop();
               mc.dispatchEvent(new Event(Event.COMPLETE));
               if(callback is Function)
               {
                  callback(mc);
               }
            }
         };
         mc.addEventListener(Event.ENTER_FRAME,oef);
      }
   }
}
