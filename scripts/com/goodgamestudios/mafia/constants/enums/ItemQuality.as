package com.goodgamestudios.mafia.constants.enums
{
   public class ItemQuality extends BasicEnum
   {
      
      private static var _none:ItemQuality;
      
      private static var _normal:ItemQuality;
      
      private static var _premium:ItemQuality;
      
      private static var _epic:ItemQuality;
      
      private static var _legendary:ItemQuality;
       
      
      public function ItemQuality(param1:String, param2:uint, param3:DoNotInstantiate#82)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : ItemQuality
      {
         if(_none == null)
         {
            _none = new ItemQuality("None",0,new DoNotInstantiate#82());
         }
         return _none;
      }
      
      public static function get Normal() : ItemQuality
      {
         if(_normal == null)
         {
            _normal = new ItemQuality("Normal",1,new DoNotInstantiate#82());
         }
         return _normal;
      }
      
      public static function get Premium() : ItemQuality
      {
         if(_premium == null)
         {
            _premium = new ItemQuality("Premium",2,new DoNotInstantiate#82());
         }
         return _premium;
      }
      
      public static function get Epic() : ItemQuality
      {
         if(_epic == null)
         {
            _epic = new ItemQuality("Epic",3,new DoNotInstantiate#82());
         }
         return _epic;
      }
      
      public static function get Legendary() : ItemQuality
      {
         if(_legendary == null)
         {
            _legendary = new ItemQuality("Legendary",4,new DoNotInstantiate#82());
         }
         return _legendary;
      }
   }
}

class DoNotInstantiate#82
{
    
   
   function DoNotInstantiate#82()
   {
      super();
   }
}
