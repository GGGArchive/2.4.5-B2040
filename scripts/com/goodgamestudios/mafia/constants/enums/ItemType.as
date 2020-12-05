package com.goodgamestudios.mafia.constants.enums
{
   public class ItemType extends BasicEnum
   {
      
      private static var _none:ItemType;
      
      private static var _gear:ItemType;
      
      private static var _food:ItemType;
      
      private static var _weapon:ItemType;
      
      private static var _consumable:ItemType;
      
      private static var _skill:ItemType;
      
      private static var _accessory:ItemType;
      
      private static var _extra:ItemType;
       
      
      public function ItemType(param1:String, param2:uint, param3:DoNotInstantiate#80)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : ItemType
      {
         if(_none == null)
         {
            _none = new ItemType("None",0,new DoNotInstantiate#80());
         }
         return _none;
      }
      
      public static function get Gear() : ItemType
      {
         if(_gear == null)
         {
            _gear = new ItemType("Gear",1,new DoNotInstantiate#80());
         }
         return _gear;
      }
      
      public static function get Food() : ItemType
      {
         if(_food == null)
         {
            _food = new ItemType("Food",2,new DoNotInstantiate#80());
         }
         return _food;
      }
      
      public static function get Weapon() : ItemType
      {
         if(_weapon == null)
         {
            _weapon = new ItemType("Weapon",3,new DoNotInstantiate#80());
         }
         return _weapon;
      }
      
      public static function get Consumable() : ItemType
      {
         if(_consumable == null)
         {
            _consumable = new ItemType("Consumable",4,new DoNotInstantiate#80());
         }
         return _consumable;
      }
      
      public static function get Skill() : ItemType
      {
         if(_skill == null)
         {
            _skill = new ItemType("Skill",5,new DoNotInstantiate#80());
         }
         return _skill;
      }
      
      public static function get Accessory() : ItemType
      {
         if(_accessory == null)
         {
            _accessory = new ItemType("Accessory",6,new DoNotInstantiate#80());
         }
         return _accessory;
      }
      
      public static function get Extra() : ItemType
      {
         if(_extra == null)
         {
            _extra = new ItemType("Extra",7,new DoNotInstantiate#80());
         }
         return _extra;
      }
   }
}

class DoNotInstantiate#80
{
    
   
   function DoNotInstantiate#80()
   {
      super();
   }
}
