package com.goodgamestudios.graphics.utils
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class DisplayObjectDuplicater
   {
       
      
      public function DisplayObjectDuplicater()
      {
         super();
      }
      
      public static function duplicate(param1:MovieClip) : MovieClip
      {
         var _loc4_:Rectangle = null;
         if(param1 == null)
         {
            return new MovieClip();
         }
         var _loc2_:Class = Object(param1).constructor as Class;
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.transform = param1.transform;
         _loc3_.filters = param1.filters;
         _loc3_.opaqueBackground = param1.opaqueBackground;
         if(param1.properties)
         {
            _loc3_.properties = param1.properties;
         }
         if(param1.scale9Grid)
         {
            _loc4_ = param1.scale9Grid;
            _loc3_.scale9Grid = _loc4_;
         }
         return _loc3_;
      }
   }
}
