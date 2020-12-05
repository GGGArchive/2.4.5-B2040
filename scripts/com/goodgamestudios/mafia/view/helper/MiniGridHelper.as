package com.goodgamestudios.mafia.view.helper
{
   import flash.display.MovieClip;
   
   public class MiniGridHelper
   {
       
      
      public function MiniGridHelper(param1:MovieClip, param2:uint, param3:uint)
      {
         var _loc8_:int = 0;
         var _loc9_:MiniBox = null;
         super();
         var _loc4_:int = 96;
         var _loc5_:int = 12;
         var _loc6_:int = Math.ceil(_loc4_ / _loc5_);
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               _loc9_ = new MiniBox();
               _loc9_.x = (_loc9_.width + 1) * _loc8_;
               _loc9_.y = (_loc9_.height + 1) * _loc7_;
               param1.addChild(_loc9_);
               if(_loc8_ < param2 && _loc7_ < param3)
               {
                  _loc9_.gotoAndStop(2);
               }
               else
               {
                  _loc9_.gotoAndStop(1);
               }
               _loc8_++;
            }
            _loc7_++;
         }
      }
   }
}
