package com.goodgamestudios.mafia.constants.enums
{
   public class ItemLocation extends BasicEnum
   {
      
      private static var _none:ItemLocation;
      
      private static var _inventory:ItemLocation;
      
      private static var _gear:ItemLocation;
      
      private static var _armament:ItemLocation;
      
      private static var _foodInUse:ItemLocation;
      
      private static var _shopBlackMarket:ItemLocation;
      
      private static var _shopKiosk:ItemLocation;
      
      private static var _shopConsumables:ItemLocation;
      
      private static var _shopEvent:ItemLocation;
      
      private static var _shopSafe:ItemLocation;
      
      private static var _shopBreakingTheLaw:ItemLocation;
      
      private static var _shopExtras:ItemLocation;
      
      private static var _shopTournament:ItemLocation;
       
      
      public function ItemLocation(param1:String, param2:uint, param3:DoNotInstantiate#77)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : ItemLocation
      {
         if(_none == null)
         {
            _none = new ItemLocation("None",0,new DoNotInstantiate#77());
         }
         return _none;
      }
      
      public static function get Inventory() : ItemLocation
      {
         if(_inventory == null)
         {
            _inventory = new ItemLocation("Inventory",1,new DoNotInstantiate#77());
         }
         return _inventory;
      }
      
      public static function get Gear() : ItemLocation
      {
         if(_gear == null)
         {
            _gear = new ItemLocation("Gear",2,new DoNotInstantiate#77());
         }
         return _gear;
      }
      
      public static function get Armament() : ItemLocation
      {
         if(_armament == null)
         {
            _armament = new ItemLocation("Armament",3,new DoNotInstantiate#77());
         }
         return _armament;
      }
      
      public static function get FoodInUse() : ItemLocation
      {
         if(_foodInUse == null)
         {
            _foodInUse = new ItemLocation("FoodInUse",4,new DoNotInstantiate#77());
         }
         return _foodInUse;
      }
      
      public static function get ShopBlackMarket() : ItemLocation
      {
         if(_shopBlackMarket == null)
         {
            _shopBlackMarket = new ItemLocation("ShopBlackMarket",5,new DoNotInstantiate#77());
         }
         return _shopBlackMarket;
      }
      
      public static function get ShopKiosk() : ItemLocation
      {
         if(_shopKiosk == null)
         {
            _shopKiosk = new ItemLocation("ShopKiosk",6,new DoNotInstantiate#77());
         }
         return _shopKiosk;
      }
      
      public static function get ShopConsumables() : ItemLocation
      {
         if(_shopConsumables == null)
         {
            _shopConsumables = new ItemLocation("ShopConsumables",7,new DoNotInstantiate#77());
         }
         return _shopConsumables;
      }
      
      public static function get ShopEvent() : ItemLocation
      {
         if(_shopEvent == null)
         {
            _shopEvent = new ItemLocation("ShopEvent",8,new DoNotInstantiate#77());
         }
         return _shopEvent;
      }
      
      public static function get ShopSafe() : ItemLocation
      {
         if(_shopSafe == null)
         {
            _shopSafe = new ItemLocation("ShopSafe",9,new DoNotInstantiate#77());
         }
         return _shopSafe;
      }
      
      public static function get ShopBreakingTheLaw() : ItemLocation
      {
         if(_shopBreakingTheLaw == null)
         {
            _shopBreakingTheLaw = new ItemLocation("ShopBreakingTheLaw",10,new DoNotInstantiate#77());
         }
         return _shopBreakingTheLaw;
      }
      
      public static function get ShopExtras() : ItemLocation
      {
         if(_shopExtras == null)
         {
            _shopExtras = new ItemLocation("ShopExtras",11,new DoNotInstantiate#77());
         }
         return _shopExtras;
      }
      
      public static function get ShopTournament() : ItemLocation
      {
         if(_shopTournament == null)
         {
            _shopTournament = new ItemLocation("ShopTournament",12,new DoNotInstantiate#77());
         }
         return _shopTournament;
      }
   }
}

class DoNotInstantiate#77
{
    
   
   function DoNotInstantiate#77()
   {
      super();
   }
}
