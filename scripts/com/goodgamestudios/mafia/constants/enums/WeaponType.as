package com.goodgamestudios.mafia.constants.enums
{
   public class WeaponType extends ItemSubtype
   {
      
      private static var _pistol:WeaponType;
      
      private static var _smg:WeaponType;
      
      private static var _shotgun:WeaponType;
      
      private static var _assault:WeaponType;
      
      private static var _sniper:WeaponType;
      
      private static var _any:WeaponType;
       
      
      public function WeaponType(param1:String, param2:uint, param3:DoNotInstantiate#81)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get Pistol() : WeaponType
      {
         if(_pistol == null)
         {
            _pistol = new WeaponType("Pistol",1,new DoNotInstantiate#81());
         }
         return _pistol;
      }
      
      public static function get Smg() : WeaponType
      {
         if(_smg == null)
         {
            _smg = new WeaponType("Smg",2,new DoNotInstantiate#81());
         }
         return _smg;
      }
      
      public static function get Shotgun() : WeaponType
      {
         if(_shotgun == null)
         {
            _shotgun = new WeaponType("Shotgun",3,new DoNotInstantiate#81());
         }
         return _shotgun;
      }
      
      public static function get Assault() : WeaponType
      {
         if(_assault == null)
         {
            _assault = new WeaponType("Assault",4,new DoNotInstantiate#81());
         }
         return _assault;
      }
      
      public static function get Sniper() : WeaponType
      {
         if(_sniper == null)
         {
            _sniper = new WeaponType("Sniper",5,new DoNotInstantiate#81());
         }
         return _sniper;
      }
      
      public static function get Any() : WeaponType
      {
         if(_any == null)
         {
            _any = new WeaponType("Any",6,new DoNotInstantiate#81());
         }
         return _any;
      }
   }
}

class DoNotInstantiate#81
{
    
   
   function DoNotInstantiate#81()
   {
      super();
   }
}
