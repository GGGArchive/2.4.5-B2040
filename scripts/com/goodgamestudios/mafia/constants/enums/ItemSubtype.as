package com.goodgamestudios.mafia.constants.enums
{
   public class ItemSubtype extends BasicEnum
   {
      
      private static var _none:ItemSubtype;
       
      
      public function ItemSubtype(param1:String, param2:uint)
      {
         super(param1,param2);
      }
      
      public static function get None() : ItemSubtype
      {
         if(_none == null)
         {
            _none = new ItemSubtype("None",0);
         }
         return _none;
      }
   }
}
