package com.goodgamestudios.mafia.constants.enums
{
   public class GearType extends ItemSubtype
   {
      
      private static var _vehicle:GearType;
      
      private static var _house:GearType;
      
      private static var _pet:GearType;
      
      private static var _luxury:GearType;
      
      private static var _bodyguard:GearType;
      
      private static var _accessory:GearType;
      
      private static var _tattoo:GearType;
      
      private static var _luckyCharm:GearType;
      
      private static var values:Vector.<GearType>;
       
      
      public function GearType(param1:String, param2:uint, param3:DoNotInstantiate#70)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
         if(values == null)
         {
            values = new Vector.<GearType>();
         }
         values.push(this);
      }
      
      public static function get Vehicle() : GearType
      {
         if(_vehicle == null)
         {
            _vehicle = new GearType("Vehicle",1,new DoNotInstantiate#70());
         }
         return _vehicle;
      }
      
      public static function get House() : GearType
      {
         if(_house == null)
         {
            _house = new GearType("House",2,new DoNotInstantiate#70());
         }
         return _house;
      }
      
      public static function get Pet() : GearType
      {
         if(_pet == null)
         {
            _pet = new GearType("Pet",3,new DoNotInstantiate#70());
         }
         return _pet;
      }
      
      public static function get Luxury() : GearType
      {
         if(_luxury == null)
         {
            _luxury = new GearType("Luxury",4,new DoNotInstantiate#70());
         }
         return _luxury;
      }
      
      public static function get Bodyguard() : GearType
      {
         if(_bodyguard == null)
         {
            _bodyguard = new GearType("Bodyguard",5,new DoNotInstantiate#70());
         }
         return _bodyguard;
      }
      
      public static function get Accessory() : GearType
      {
         if(_accessory == null)
         {
            _accessory = new GearType("Accessory",6,new DoNotInstantiate#70());
         }
         return _accessory;
      }
      
      public static function get Tattoo() : GearType
      {
         if(_tattoo == null)
         {
            _tattoo = new GearType("Tattoo",7,new DoNotInstantiate#70());
         }
         return _tattoo;
      }
      
      public static function get LuckyCharm() : GearType
      {
         if(_luckyCharm == null)
         {
            _luckyCharm = new GearType("LuckyCharm",8,new DoNotInstantiate#70());
         }
         return _luckyCharm;
      }
      
      public static function getValueByIndex(param1:uint) : GearType
      {
         var _loc2_:GearType = null;
         for each(_loc2_ in values)
         {
            if(_loc2_.index == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

class DoNotInstantiate#70
{
    
   
   function DoNotInstantiate#70()
   {
      super();
   }
}
