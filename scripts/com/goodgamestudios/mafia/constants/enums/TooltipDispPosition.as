package com.goodgamestudios.mafia.constants.enums
{
   public class TooltipDispPosition extends BasicEnum
   {
      
      private static var _none:TooltipDispPosition;
      
      private static var _left:TooltipDispPosition;
      
      private static var _right:TooltipDispPosition;
      
      private static var _top:TooltipDispPosition;
      
      private static var _center:TooltipDispPosition;
      
      private static var _over:TooltipDispPosition;
       
      
      public function TooltipDispPosition(param1:String, param2:uint, param3:DoNotInstantiate#114)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : TooltipDispPosition
      {
         if(_none == null)
         {
            _none = new TooltipDispPosition("None",0,new DoNotInstantiate#114());
         }
         return _none;
      }
      
      public static function get Left() : TooltipDispPosition
      {
         if(_left == null)
         {
            _left = new TooltipDispPosition("Left",0,new DoNotInstantiate#114());
         }
         return _left;
      }
      
      public static function get Right() : TooltipDispPosition
      {
         if(_right == null)
         {
            _right = new TooltipDispPosition("Right",0,new DoNotInstantiate#114());
         }
         return _right;
      }
      
      public static function get Top() : TooltipDispPosition
      {
         if(_top == null)
         {
            _top = new TooltipDispPosition("Top",0,new DoNotInstantiate#114());
         }
         return _top;
      }
      
      public static function get Center() : TooltipDispPosition
      {
         if(_center == null)
         {
            _center = new TooltipDispPosition(" Center",0,new DoNotInstantiate#114());
         }
         return _center;
      }
      
      public static function get Over() : TooltipDispPosition
      {
         if(_over == null)
         {
            _over = new TooltipDispPosition("Over",0,new DoNotInstantiate#114());
         }
         return _over;
      }
   }
}

class DoNotInstantiate#114
{
    
   
   function DoNotInstantiate#114()
   {
      super();
   }
}
